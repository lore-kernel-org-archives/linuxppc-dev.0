Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id A246DDE6DC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 00:18:27 +1100 (EST)
In-Reply-To: <20090108123619.3543719f@lxorguk.ukuu.org.uk>
References: <hvc-console-29-3@bga.com> <hvc-console-29-3-1@bga.com>
	<20090108123619.3543719f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <455ca36e8b5778fd4c7218ef31fca07c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/4] hvc_console: do not set low_latency
Date: Thu, 8 Jan 2009 07:25:14 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Joe Peterson <joe@skyrush.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2009, at 6:36 AM, Alan Cox wrote:

>> v2.6.16-rc1 via 33f0f88f1c51ae5c2d593d26960c760ea154c2e2
>>     [PATCH] TTY layer buffering revamp
>>
>> added this new api.
>
> No - tty_flip_buffer_push is from 2.1.66 and with the same constraints
> from the day it was added.
>
Yes but wrappers were added and this this and many ohter drivers were  
converted to use them:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git; 
a=commitdiff;h=33f0f88f1c51ae5c2d593d26960c760ea154c2e2

And they were slightly buggy leading to the buggy workaround.

>
>> Having the flag set for purely polled drivers will save delaying
>> the work when receiving input for 1 jiffie.
>>
>>
>> Index: work.git/drivers/char/hvc_console.c
>> ===================================================================
>> --- work.git.orig/drivers/char/hvc_console.c	2009-01-08  
>> 03:01:24.000000000 -0600
>> +++ work.git/drivers/char/hvc_console.c	2009-01-08 03:01:51.000000000  
>> -0600
>> @@ -318,7 +318,8 @@ static int hvc_open(struct tty_struct *t
>>  	} /* else count == 0 */
>>
>>  	tty->driver_data = hp;
>> -	tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
>> +	if (!hp->irq_requested)
>> +		tty->low_latency = 1; /* Makes flushes to ldisc synchronous. */
>>
>>  	hp->tty = tty;
>
> Looks good to me

Thanks, I guess that is an Ack?

milton
