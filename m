Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: Run 'usermode-agent' cause kernel panic on Powerpc
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: xufeng zhang <xufeng.zhang@windriver.com>
In-Reply-To: <4CFDD8C5.70905@windriver.com>
References: <4CFDD8C5.70905@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 07 Dec 2010 08:04:43 -0600
Message-ID: <1291730683.16003.4.camel@shaggy-w500>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-12-07 at 14:48 +0800, xufeng zhang wrote:
> Hi Dave,
> 
> I have a question with the below patch you made before:
> ----------------------------------------
> powerpc/booke: Add support for advanced debug registers
> 
> From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> 
> Based on patches originally written by Torez Smith.
> -----------------------------------------
> 
> I meet a kernel panic problem while running 'usermode-agent' on PowerPC
> ----------------------------------------
> Oops: Exception in kernel mode, sig: 5 [#1]
> PREEMPT LTT NESTING LEVEL : 0
> MPC8536 DS
> last sysfs file: 
> /sys/devices/f3000000.soc/f3003100.i2c/i2c-1/i2c-dev/i2c-1/dev
> Modules linked in:
> NIP: c00081a0 LR: c03a9560 CTR: c003547c
> REGS: ef11bf10 TRAP: 2002   Not tainted  (2.6.34.6-WR4.0.0.0_standard)
> MSR: 00021000 <ME,CE>  CR: 44000624  XER: 00000000
> TASK = efc1de00[752] 'usermode-agent' THREAD: ef63e000
> GPR00: cc00cc00 ef63fe60 efc1de00 efc1de00 efc1f700 c04c8000 00258560 
> ffffffff
> GPR08: ffda8a00 40000000 00001fda c0500000 49eaebbd 1008b654 3ff8a900 
> 00000000
> GPR16: 00000000 eed84c40 c03b4570 c04ee4d0 c04ca870 ef63e03c 00000000 
> 00000000
> GPR24: c04f7ee8 c04ee4c0 00000004 c04ca440 ef63e000 efc1f700 c04ca440 
> efc1de00
> NIP [c00081a0] __switch_to+0xac/0x104
> LR [c03a9560] schedule+0x20c/0x3f4
> Call Trace:
> [ef63fe60] [efc1f700] 0xefc1f700 (unreliable)
> [ef63fe70] [c03a9560] schedule+0x20c/0x3f4
> [ef63fec0] [c00429e0] do_wait+0x1a4/0x278
> [ef63fef0] [c0042b44] sys_wait4+0x90/0xf8
> [ef63ff40] [c00106d4] ret_from_syscall+0x0/0x4
> ------------------------------------------
> 
> Actually, this problem is caused by enabling On Chip Debugging, when On
> Chip Debugging is enabled, we enable MSR_DE as below:
> #define MSR_KERNEL      (MSR_ME|MSR_RI|MSR_CE|MSR_DE)
> 
> If I comment out "mtspr(SPRN_DBCR0, thread->dbcr0);" in 
> prime_debug_regs() function,
> then it will be ok.
> 
> Here is my analysis for this problem:
> Run 'usermode-agent' application will set Internal Debug Mode(IDM) and
> Instruction Complete Debug Event(ICMP)flags for thread.
> As MSR_DE is enabled, when execute context switching in prime_debug_regs(),
> thread->dbcr0 would write to SPRN_DBCR0 register.
> So this will enable Instruction Complete Debug Event interrupt, and it 
> will cause a kernel-mode
> exception right now, it will be handled in native_DebugException(), then 
> kernel detected
> this exception not happens in user-mode, lastly kernel call die() and 
> kill current process.
> 
> So my question is could I just comment out "mtspr(SPRN_DBCR0, 
> thread->dbcr0);" in prime_debug_regs()?
> I'm sure whether or not it will impose a bad impact on debugging.

I believe it would have such an impact.  I don't see that user-mode
debugging would be enabled at all.

Maybe something like this untested patch:

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 84906d3..0e7d1cf 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -323,6 +323,13 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 
 static void prime_debug_regs(struct thread_struct *thread)
 {
+	/*
+	 * If we're setting up debug events for user space, make sure they
+	 * don't fire in kernel space before we get to user space
+	 */
+	if (thread->dbcr0 & DBCR0_IDM)
+		mtmsr(mfmsr() & ~MSR_DE);
+
 	mtspr(SPRN_IAC1, thread->iac1);
 	mtspr(SPRN_IAC2, thread->iac2);
 #if CONFIG_PPC_ADV_DEBUG_IACS > 2

-- 
Dave Kleikamp
IBM Linux Technology Center
