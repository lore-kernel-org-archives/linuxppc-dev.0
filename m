Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 942A0B6F65
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2011 10:43:01 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: fix wrong divisor in usecs_to_cputime
References: <m2fwgvnwlm.fsf__7616.12257124415$1323342974$gmane$org@igel.home>
 <m2pqfx2zub.fsf@igel.home> <20111210102837.526cbc19@kryten>
Date: Sat, 10 Dec 2011 00:42:56 +0100
In-Reply-To: <20111210102837.526cbc19@kryten> (Anton Blanchard's message of
 "Sat, 10 Dec 2011 10:28:37 +1100")
Message-ID: <m2iplp2txb.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> Hi Andreas,
>
>> Commit d57af9b (taskstats: use real microsecond granularity for CPU
>> times) renamed msecs_to_cputime to usecs_to_cputime, but failed to
>> update all numbers on the way.  This causes nonsensical cpu
>> idle/iowait values to be displayed in /proc/stat (the only user of
>> usecs_to_cputime so far).
>> 
>> This also renames __cputime_msec_factor to __cputime_usec_factor,
>> adapting its value and using it directly in cputime_to_usecs instead
>> of doing two multiplications.
>
> Thanks for finding this! I noticed the strange behaviour yesterday and
> was just about to investigate.
>
> Can I suggest we add: 
>
> Cc: <stable@vger.kernel.org> [2.6.37+]
>
> so it will make it back into the stable trees?

There is no user of usecs_to_cputime before 3.2-rc1, so it wouldn't have
any effect for older versions.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
