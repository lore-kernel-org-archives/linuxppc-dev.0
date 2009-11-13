Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B2B73B6F2B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Nov 2009 06:57:40 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nADJvQg8014862
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 12:57:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nADK1Jk0008259
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 14:01:19 -0600 (CST)
Message-ID: <4AFDBA40.5070309@freescale.com>
Date: Fri, 13 Nov 2009 13:57:52 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Bus Error on MPC8313
References: <200007.626.qm@web83506.mail.sp1.yahoo.com>
In-Reply-To: <200007.626.qm@web83506.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> --- On Fri, 11/13/09, Scott Wood <scottwood@freescale.com> wrote:
> 
>> From: Scott Wood <scottwood@freescale.com>
>> Subject: Re: Bus Error on MPC8313
>> To: "Ron Madrid" <ron_madrid@sbcglobal.net>
>> Cc: linuxppc-dev@ozlabs.org
>> Date: Friday, November 13, 2009, 11:33 AM
>> Ron Madrid wrote:
>>> I wrote a custom driver for an MPC8313 based
>> board.  Everything seems to
>>> have been working for a long time, but now one of my
>> IOCTL functions seems
>>> to be having a problem.  I'm getting a "Bus
>> error" reported by my
>>> application and also a kernel "Oops".  Here's
>> what the kernel is reporting. 
>>> Oops: Machine check, sig: 7 [#1]
>> Were there any messages before this?  Is there
>> anything interesting in the arbiter registers?
> 
> No messages prior, only the normal kernel boot messages. 

Hmm, for some reason e300c3's cputable entry has no machine_check field, 
while all the other e300s point to machine_check_generic.

> And when this
> does happen in usually causes a lockup, so I haven't been able to check the
> status of any arbiter registers.

The system is up long enough to print an oops; you could stick some 
output in the trap handler.

>> Is this custom driver using the localbus, and are there any
>> NAND operations going on at the same time?
> 
> This driver does use the localbus. 

OK, check the localbus error registers as well.

> It seems to happen (when it does) when
> performing an access to our FPGA that is connected via UPM on the localbus. 
> I do not know if there are any NAND operations going on at that same time. 
> If there are, they are not being directly caused by any of my apps or
> driver calls.

Are there any filesystems mounted on NAND?  There are some issues with 
transactions timing out if there's contention with a long-running NAND 
operation.

-Scott
