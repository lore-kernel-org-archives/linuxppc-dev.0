Return-Path: <anton@ozlabs.org>
Date: Tue, 20 Jun 2006 23:47:43 +1000
From: Anton Blanchard <anton@samba.org>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: Unable to handle kernel paging request in show_instructions
Message-ID: <20060620134742.GA2518@krispykreme>
References: <4497445F.50700@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4497445F.50700@us.ibm.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi David,

> The problem occures in show_instructions().  Show_instructions() takes 
> the NIP (D00000000002201) and subtracts some number so it points several 
> instructs before the failing instructions.  In this case the new value 
> is on a previous page and that page is not valid (it is not mapped).  
> When the new NIP is referenced we get a second fault.  
> 
> show_instructions tries to validate addresses by checking if it is the 
> kernel segment (0xc.....) or the first vmalloc segment (0xD.......).  
> But in this case the validation passes even though the address is 
> invalid.   Any ideas how to fix this?  Is there a easy way to validate 
> if a page is valid before accessing it?

Whats interesting is that bad_page_fault should have walked the
exception tables and recovered, considering we have a __get_user call in
show_instructions.

While we should really understand why this failed, I suspect we should
be tighter with our checking. It looks like __kernel_text_address()
does what we want. Untested patch below.

Anton


Use __kernel_text_address when validating instruction addresses in the
Oops code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -342,13 +342,6 @@ #endif
 
 static int instructions_to_print = 16;
 
-#ifdef CONFIG_PPC64
-#define BAD_PC(pc)	((REGION_ID(pc) != KERNEL_REGION_ID) && \
-		         (REGION_ID(pc) != VMALLOC_REGION_ID))
-#else
-#define BAD_PC(pc)	((pc) < KERNELBASE)
-#endif
-
 static void show_instructions(struct pt_regs *regs)
 {
 	int i;
@@ -367,7 +360,8 @@ static void show_instructions(struct pt_
 		 * bad address because the pc *should* only be a
 		 * kernel address.
 		 */
-		if (BAD_PC(pc) || __get_user(instr, (unsigned int __user *)pc)) {
+		if (!__kernel_text_address(pc) ||
+		     __get_user(instr, (unsigned int __user *)pc)) {
 			printk("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
