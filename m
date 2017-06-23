Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv4jt19XzzDqjD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 14:10:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, John Stultz <john.stultz@linaro.org>
Subject: Re: linux-next: build warning after merge of the tip tree
In-Reply-To: <20170623140006.26585989@canb.auug.org.au>
References: <20170623135834.49322610@canb.auug.org.au>
 <20170623140006.26585989@canb.auug.org.au>
Date: Fri, 23 Jun 2017 14:10:25 +1000
Message-ID: <87efubqr7y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> [Forgot to cc John]
>
> On Fri, 23 Jun 2017 13:58:34 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>> 
>> After merging the tip tree, today's linux-next build (powerpc
>> ppc64_defconfig) produced this warning:
>> 
>> kernel/time/timekeeping.c:519:2: warning: #warning Please contact your maintainers, as GENERIC_TIME_VSYSCALL_OLD compatibity will disappear soon. [-Wcpp]
>>  #warning Please contact your maintainers, as GENERIC_TIME_VSYSCALL_OLD compatibity will disappear soon.
>>   ^
>> kernel/time/timekeeping.c:519:2: warning: #warning Please contact your maintainers, as GENERIC_TIME_VSYSCALL_OLD compatibity will disappear soon. [-Wcpp]
>>  #warning Please contact your maintainers, as GENERIC_TIME_VSYSCALL_OLD compatibity will disappear soon.
>>   ^
>> 
>> Introduced by commit
>> 
>>   369adf04d80a ("time: Add warning about imminent deprecation of CONFIG_GENERIC_TIME_VSYSCALL_OLD")

Fixed in my next today by:

  d4cfb11387ee ("powerpc: Convert VDSO update function to use new update_vsyscall interface")

But you must have pulled before I pushed that, so the warning will go
away tomorrow.

cheers
