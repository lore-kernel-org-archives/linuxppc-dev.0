Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0F759DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 20:17:25 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Fix ptrace compat wrapper for fpu register access
References: <m2k568xlfg.fsf@igel.home> <13580.1238371079@neuling.org>
Date: Mon, 30 Mar 2009 11:17:19 +0200
In-Reply-To: <13580.1238371079@neuling.org> (Michael Neuling's message of
	"Mon, 30 Mar 2009 10:57:59 +1100")
Message-ID: <m2vdpr2wv4.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> So if you're looking fixing 32 bit apps ptracing 64 bit apps, does that
> mean we can get a single 32 bit GDB that'll ptrace both 64 and 32 bit
> apps?

Currently gdb only supports 32x64 debugging for the SPU.

>> @@ -263,7 +263,8 @@ long compat_arch_ptrace(struct task_struct *child, compat
> _long_t request,
>>  			ret = ptrace_put_reg(child, numReg, freg);
>>  		} else {
>>  			flush_fp_to_thread(child);
>> -			((unsigned int *)child->thread.regs)[index] = data;
>> +			((unsigned int *)child->thread.regs)
>> +				[FPRINDEX(index)] = data;
>
> This index is into the ptregs structure not the fpr.  I'm not sure the
> FPRINDEX macro is applicable here.

You're right, this hunk is bogus.  But indexing off thread.regs is
totally bogus as well.  I think what was intented is this:

@@ -263,7 +263,9 @@ long compat_arch_ptrace(struct task_stru
 			ret = ptrace_put_reg(child, numReg, freg);
 		} else {
 			flush_fp_to_thread(child);
-			((unsigned int *)child->thread.regs)[index] = data;
+			((unsigned int *)child->thread.fpr)
+				[TS_FPRWIDTH * (numReg - PT_FPR0) * 2 +
+				 index % 2] = data;
 			ret = 0;
 		}
 		break;

But gdb does not actually use PPC_PTRACE_POKEUSR_3264.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
