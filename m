Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 94AC7DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 22:11:56 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Fix ptrace compat wrapper for fpu register access
References: <m2k568xlfg.fsf@igel.home> <13580.1238371079@neuling.org>
	<m2vdpr2wv4.fsf@igel.home> <29891.1238406751@neuling.org>
Date: Mon, 30 Mar 2009 13:11:51 +0200
In-Reply-To: <29891.1238406751@neuling.org> (Michael Neuling's message of
	"Mon, 30 Mar 2009 20:52:31 +1100")
Message-ID: <m2myb32rk8.fsf@igel.home>
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

>> @@ -263,7 +263,9 @@ long compat_arch_ptrace(struct task_stru
>>  			ret = ptrace_put_reg(child, numReg, freg);
>>  		} else {
>>  			flush_fp_to_thread(child);
>> -			((unsigned int *)child->thread.regs)[index] = data;
>> +			((unsigned int *)child->thread.fpr)
>> +				[TS_FPRWIDTH * (numReg - PT_FPR0) * 2 +
>> +				 index % 2] = data;
>
> I think the indexing here should be the same as PEEKUSR_3264.  This
> looks better but all this magic indexing makes me want to vomit.

How about this instead:

@@ -241,6 +241,7 @@ long compat_arch_ptrace(struct task_stru
 	case PPC_PTRACE_POKEUSR_3264: {
 		u32 index;
 		u32 numReg;
+		u32 *tmp;
 
 		ret = -EIO;
 		/* Determine which register the user wants */
@@ -263,7 +264,8 @@ long compat_arch_ptrace(struct task_stru
 			ret = ptrace_put_reg(child, numReg, freg);
 		} else {
 			flush_fp_to_thread(child);
-			((unsigned int *)child->thread.regs)[index] = data;
+			tmp = (u32 *)child->thread.fpr[numReg - PT_FPR0];
+			tmp[index % 2] = data;
 			ret = 0;
 		}
 		break;

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
