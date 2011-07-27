Return-Path: <anton@samba.org>
Date: Wed, 27 Jul 2011 10:35:46 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au
Subject: [PATCH] powerpc: Jump label misalignment causes oops at boot
Message-ID: <20110727103546.7d4f2419@kryten>
In-Reply-To: <20110727101150.449574ef@kryten>
References: <20110727101150.449574ef@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I hit an oops at boot on the first instruction of timer_cpu_notify:

NIP [c000000000722f88] .timer_cpu_notify+0x0/0x388

The code should look like:

c000000000722f78:       eb e9 00 30     ld      r31,48(r9)
c000000000722f7c:       2f bf 00 00     cmpdi   cr7,r31,0
c000000000722f80:       40 9e ff 44     bne+    cr7,c000000000722ec4 
c000000000722f84:       4b ff ff 74     b       c000000000722ef8 

c000000000722f88 <.timer_cpu_notify>:
c000000000722f88:       7c 08 02 a6     mflr    r0
c000000000722f8c:       2f a4 00 07     cmpdi   cr7,r4,7
c000000000722f90:       fb c1 ff f0     std     r30,-16(r1)
c000000000722f94:       fb 61 ff d8     std     r27,-40(r1)

But the oops output shows:

eb61ffd8 eb81ffe0 eba1ffe8 ebc1fff0 7c0803a6 ebe1fff8 4e800020
00000000 ebe90030 c0000000 00ad0a28 00000000 2fa40007 fbc1fff0 fb61ffd8

So we scribbled over our instructions with c000000000ad0a28, which
is an address inside the jump_table ELF section.

It turns out the jump_table section is only aligned to 8 bytes but
we are aligning our entries within the section to 16 bytes. This
means our entries are offset from the table:

c000000000acd4a8 <__start___jump_table>:
        ...
c000000000ad0a10:       c0 00 00 00     lfs     f0,0(0)
c000000000ad0a14:       00 70 cd 5c     .long 0x70cd5c
c000000000ad0a18:       c0 00 00 00     lfs     f0,0(0)
c000000000ad0a1c:       00 70 cd 90     .long 0x70cd90
c000000000ad0a20:       c0 00 00 00     lfs     f0,0(0)
c000000000ad0a24:       00 ac a4 20     .long 0xaca420

And the jump table sort code gets very confused and writes into the
wrong spot. Remove the alignment, and also remove the padding since
we it saves some space and we shouldn't need it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/include/asm/jump_label.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/include/asm/jump_label.h	2011-07-27 09:35:04.266872078 +1000
+++ linux-powerpc/arch/powerpc/include/asm/jump_label.h	2011-07-27 09:39:32.581719669 +1000
@@ -22,7 +22,6 @@ static __always_inline bool arch_static_
 	asm goto("1:\n\t"
 		 "nop\n\t"
 		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".align 4\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (key) : : l_yes);
@@ -41,7 +40,6 @@ struct jump_entry {
 	jump_label_t code;
 	jump_label_t target;
 	jump_label_t key;
-	jump_label_t pad;
 };
 
 #endif /* _ASM_POWERPC_JUMP_LABEL_H */
