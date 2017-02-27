Return-Path: <jbaron@akamai.com>
Received: from prod-mail-xrelay07.akamai.com (prod-mail-xrelay07.akamai.com
 [23.79.238.175])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vXHGr5Kj4zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 10:00:04 +1100 (AEDT)
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To: David Daney <ddaney@caviumnetworks.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
 <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
 <20170227173630.57fff459@gandalf.local.home>
 <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anton Blanchard <anton@samba.org>, Rabin Vincent <rabin@rab.in>,
 Russell King <linux@armlinux.org.uk>, Chris Metcalf <cmetcalf@mellanox.com>,
 Zhigang Lu <zlu@ezchip.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <68fe24ea-7795-24d8-211b-9d8a50affe9f@akamai.com>
Date: Mon, 27 Feb 2017 17:50:25 -0500
MIME-Version: 1.0
In-Reply-To: <7bd72716-feea-073f-741c-04212ebd0802@caviumnetworks.com>
Content-Type: multipart/mixed; boundary="------------0A3EF28D71460612D7540AD2"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------0A3EF28D71460612D7540AD2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 02/27/2017 05:45 PM, David Daney wrote:
> On 02/27/2017 02:36 PM, Steven Rostedt wrote:
>> On Mon, 27 Feb 2017 14:21:21 -0800
>> David Daney <ddaney@caviumnetworks.com> wrote:
>>
>>> See attached for mips.  It seems to do the right thing.
>>>
>>> I leave it as an exercise to the reader to fix the other architectures.
>>>
>>> Consult your own  binutils experts to verify that what I say is true.
>>
>> It may still just be safer to do the pointers instead. That way we
>> don't need to worry about some strange arch or off by one binutils
>> messing it up.
>
> Obviously it is your choice, but this is bog standard ELF linking.  In
> theory even the arrays of power-of-2 sized objects should also supply an
> entity size.  Think __ex_table and its ilk.
>
>
> The benefit of supplying an entsize is that you don't have to change the
> structure of the existing code and risk breaking something in the process.
>
> David Daney
>
>

Thanks for the suggestion! I would like to see if this resolves the ppc 
issue we had. I'm attaching a powerpc patch based on your suggestion. 
Hopefully, Sachin can try it.

Thanks,

-Jason

--------------0A3EF28D71460612D7540AD2
Content-Type: text/x-patch;
 name="ppc-pack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ppc-pack.patch"

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 9a287e0ac8b1..3c5660e50f9a 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -19,14 +19,26 @@
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
 
+#ifdef CONFIG_PPC64
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
 	asm_volatile_goto("1:\n\t"
 		 "nop # arch_static_branch\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".pushsection __jump_table,  \"awM\",@progbits, %1\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
-		 : :  "i" (&((char *)key)[branch]) : : l_yes);
+		 : :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
@@ -37,32 +49,24 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 ".pushsection __jump_table,  \"awM\",@progbits, %1\n\t"
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
-		 : :  "i" (&((char *)key)[branch]) : : l_yes);
+		 : :  "i" (&((char *)key)[branch]), "i" (sizeof(struct jump_entry)) : : l_yes);
 
 	return false;
 l_yes:
 	return true;
 }
 
-#ifdef CONFIG_PPC64
-typedef u64 jump_label_t;
+
 #else
-typedef u32 jump_label_t;
-#endif
 
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
+#define ENTRY_SIZE (ULONG_SIZE * 3)
 
-#else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
-	.pushsection __jump_table, "aw";	\
+	.pushsection __jump_table, "awM",@progbits,ENTRY_SIZE; \
 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
 	.popsection
 #endif

--------------0A3EF28D71460612D7540AD2--
