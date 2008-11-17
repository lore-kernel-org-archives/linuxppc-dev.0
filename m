Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 15DC3DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 21:22:26 +1100 (EST)
Received: from [192.168.1.37] (66-81-70-236.bayarea.dialup.o1.com
	[66.81.70.236]) (authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mAHAM8EE042925
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 02:22:21 -0800 (PST)
Message-ID: <492145BB.7080904@hypersurf.com>
Date: Mon, 17 Nov 2008 02:21:47 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: pmac_zilog debugging ...
References: <4914B549.9010805@hypersurf.com>	<1226096603.13603.74.camel@pasglop>
	<491C11B2.1060909@hypersurf.com>	<1226612654.7178.84.camel@pasglop>
	<491CAA32.20307@hypersurf.com>	<1226624429.7178.105.camel@pasglop>
	<49212D61.3080305@hypersurf.com>
	<1226912422.7178.228.camel@pasglop>
In-Reply-To: <1226912422.7178.228.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>  
> 
> That's definitely strange. I would expect the kernel to be able to get
> interrupts fast enough to service a 1200 bauds serial port. Maybe
> there's something else wrong, or an other driver causing undue interrupt
> latencies.... 
> 
As far as I can see the system is NOT busy. I see no evidence of excessive
interrupt loading. It does have an Adaptec 2940 u2w SCSI card, an ATI video card,
and a USB/firewire card. The SCSI card has some disks on it. The other two cards
are unused. I guess, in theory, something in my 2.6.27 kernel could be causing one
of the two unused cards to throw spurious interrupts?

I still think the hardware is mis-behaving.

> Out of curiosity, check that IDE properly unmasks interrupts (hdparm
> -u1 /dev/hda).
> 
This is an 8600. It is SCSI only (the onboard controller is the MESH).
> 
>> So, I'm on board with this approach. Since I don't really know what I am
>>doing, how do you recommend I proceed?
> 
> 
> Google for a document called MacTech.pdf which contains various
> documentations for bits of the ancestor of the IO chip in your machine,
> along with a description of the DBDMA engine :-) Something else you can
> do is to look at how it's properly used by other drivers such as bmac
> and look at some of the darwin source code for reference on how the HW
> works.
> 
where might one find older Darwin source?

> Cheers,
> Ben.
> 
> _______________________________________________
> 
