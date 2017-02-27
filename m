Return-Path: <David.Daney@cavium.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0075.outbound.protection.outlook.com [104.47.37.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXGQN41SkzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 09:21:32 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
 Ralf Baechle <ralf@linux-mips.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
Cc: Jason Baron <jbaron@akamai.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>,
 Russell King <linux@armlinux.org.uk>, Chris Metcalf <cmetcalf@mellanox.com>,
 Zhigang Lu <zlu@ezchip.com>
From: David Daney <ddaney@caviumnetworks.com>
Message-ID: <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
Date: Mon, 27 Feb 2017 14:21:21 -0800
MIME-Version: 1.0
In-Reply-To: <20170227170911.2280ca3e@gandalf.local.home>
Content-Type: multipart/mixed; boundary="------------D566EBDEDAFBEDE0F1C637BC"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------D566EBDEDAFBEDE0F1C637BC
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/27/2017 02:09 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 13:41:13 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> On 02/27/2017 01:06 PM, Steven Rostedt wrote:
>>> On Mon, 27 Feb 2017 11:59:50 -0800
>>> David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>>> For me the size is not the important issue, it is the alignment of the
>>>> struct jump_entry entries in the table.  I don't understand how your
>>>> patch helps, and I cannot Acked-by unless I understand what is being
>>>> done and can see that it is both correct and necessary.
>>>
>>> You brought up a very good point and I'm glad that I had Jason Cc all
>>> the arch maintainers in one patch.
>>>
>>> I think jump_labels may be much more broken than we think, and Jason's
>>> fix doesn't fix anything. We had this same issues with tracepoints.
>>>
>>> I'm looking at jump_label_init, and how we iterate over an array of
>>> struct jump_entry's that was put together by the linker. The problem is
>>> that jump_entry is not a power of 2 in size.
>>>
>>
>> ELF sections may have an ENTSIZE property exactly for arrays.  Since
>> each jump_entry will have a unique value they cannot be merged, but we
>> can tell the assembler they are an array and get them properly packed.
>> Perhaps something like (untested):
>>
>>     .pushsection __jump_table,  \"awM\",@progbits,24
>>     FOO
>>     .popsection
>>
>
> And the linker will honor this too?

See attached for mips.  It seems to do the right thing.

I leave it as an exercise to the reader to fix the other architectures.

Consult your own  binutils experts to verify that what I say is true.


David Daney

--------------D566EBDEDAFBEDE0F1C637BC
Content-Type: text/x-patch;
 name="0001-MIPS-jump_lable-Give-__jump_table-elements-an-entsiz.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-jump_lable-Give-__jump_table-elements-an-entsiz.pa";
 filename*1="tch"

>From 484111a11bb5187a4c190cd80b4a03a18ee7047b Mon Sep 17 00:00:00 2001
From: David Daney <david.daney@cavium.com>
Date: Mon, 27 Feb 2017 14:14:30 -0800
Subject: [PATCH] MIPS: jump_lable: Give __jump_table elements an entsize.

Since the __jump_table is a big array of non power-of-2 sized
elements, tell the linker the size so they can be properly packed.
Since each element will have unique "code" and "key" fields, no
merging will ever occur, but it should end up properly packed.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/jump_label.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e776725..c9a695f 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -26,14 +26,26 @@
 #define NOP_INSN "nop"
 #endif
 
+#ifdef CONFIG_64BIT
+typedef u64 jump_label_t;
+#else
+typedef u32 jump_label_t;
+#endif
+
+struct jump_entry {
+	jump_label_t code;
+	jump_label_t target;
+	jump_label_t key;
+};
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		".pushsection __jump_table, \"awM\",@progbits, %1\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
-		: :  "i" (&((char *)key)[branch]) : : l_yes);
+		: :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)): : l_yes);
 
 	return false;
 l_yes:
@@ -44,27 +56,15 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		".pushsection __jump_table, \"awM\"@progbits, %1\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
-		: :  "i" (&((char *)key)[branch]) : : l_yes);
+		: :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#ifdef CONFIG_64BIT
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif /* _ASM_MIPS_JUMP_LABEL_H */
-- 
2.9.3


--------------D566EBDEDAFBEDE0F1C637BC--
