Return-Path: <B10716@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D26CDB6F8B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Sep 2011 01:38:12 +1000 (EST)
Received: from mail79-va3 (localhost.localdomain [127.0.0.1])	by
	mail79-va3-R.bigfish.com (Postfix) with ESMTP id 2F781248298	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2011 15:38:07 +0000 (UTC)
Received: from VA3EHSMHS018.bigfish.com (unknown [10.7.14.236])	by
	mail79-va3.bigfish.com (Postfix) with ESMTP id CC21A82004C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2011 15:38:06 +0000 (UTC)
Received: from [127.0.0.1] (zro03-ws408.ea.freescale.net [10.171.73.44])	by
	az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	p81FboE9014417	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2011 10:37:53 -0500 (CDT)
Message-ID: <4E5FA6ED.9010703@freescale.com>
Date: Thu, 1 Sep 2011 18:38:21 +0300
From: Tudor Laurentiu <Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/time: When starting the decrementer don't zero
	the other bits in TCR
References: <1314274795-4966-1-git-send-email-Laurentiu.Tudor@freescale.com>
	<9A0167AA-E19D-4492-8D65-6FA4518ABE98@kernel.crashing.org>
	<4E5F42CE.1060502@freescale.com>
	<E9F5F1BB-305E-4AB5-A82F-C5840D24EEEC@kernel.crashing.org>
In-Reply-To: <E9F5F1BB-305E-4AB5-A82F-C5840D24EEEC@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/1/2011 4:56 PM, Kumar Gala wrote:
>
> On Sep 1, 2011, at 3:31 AM, Tudor Laurentiu wrote:
>
>> On 9/1/2011 9:27 AM, Kumar Gala wrote:
>>>
>>> On Aug 25, 2011, at 7:19 AM, Laurentiu Tudor wrote:
>>>
>>>> Clearing the other TCR bits might break code that sets them (e.g. to setup
>>>> the watchdog or fixed interval timer) before start_cpu_decrementer() gets
>>>> called.
>>>
>>> Can you be more specific about the case you're concerned about.  I'm not sure we want to leave the FIT enabled if it was previously.  Watchdog I could possibly see leaving alone.
>>
>> My particular case was this: I was experimenting with having the watchdog enabled during the boot process, in case something goes wrong before the normal watchdog mechanism kicks in. That didn't work without making this modification.
>> Then, thinking that having a function start_cpu_decrementer() touching the other timers and not only the decrementer as its name implies might not be good. So I submitted this patch to the public mailing list to let the community decide if it's useful.
>
> So I think renaming the function is fine, and I think not touching the watchdog bits is also reasonable.  So if you update the patch along those lines I think we can push in.  I do want to make sure that the FIT is disabled as we dont expect it.

how about:

static void setup_cpu_timers()

?

> Probably add a comment about how care needs to be taken if the wathchdog is enable be firmware or a previous kernel.

OK.
