Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 934AFDDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 22:46:18 +1000 (EST)
Message-ID: <47209021.4080501@ru.mvista.com>
Date: Thu, 25 Oct 2007 16:46:25 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: New time code miscalculates cpu usage
References: <20071016202525.GA11837@lixom.net>	
	<471FA875.6080602@ru.mvista.com> <1193262969.6653.32.camel@pasglop>
In-Reply-To: <1193262969.6653.32.camel@pasglop>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>>Not sure when this started happening, but I wanted to report it. I'll
>>>start bisecting in a day or two if noone else has gotten around to
>>>looking at it:

>>>$ echo "int main(void) { while(1); }" > test.c ; gcc test.c
>>>$ time ./a.out & sleep 2 ; killall a.out
>>>real    0m2.008s
>>>user    0m4.014s
>>>sys     0m0.002s

>>>Seen on POWER5 and PA6T, haven't tried anything else yet.

>>    I'm not surprised -- the kernel accounts twice for each tick.

> Your input would be much more valuable if you actually pointed out where
> that happens and why since you seem to know it.

   I've already pointed out the reason, yet it won't hurt to repeat indeed.
timer_interrupt() calls both account_process_time() and the hrtimers event 
handler which leads to:

- if determenistic accounting is off, account_process_time() is the same as
   update_process_times() which gets also calleed by hrtimers via the event
   handler, so we get each tick accounted for twice;

- if determenistic accounting is on, then timer_interrupt() calls
   account_process_time() and update_process_times() is still called by
   hrtimers, so each tick's gets accounted for userspace twice...

> Ben.

WBR, Sergei
