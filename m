Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C61F5DDFAF
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 06:01:46 +1000 (EST)
Message-Id: <01A4AE51-D835-4F15-8735-DE537B2F6FF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Subodh Nijsure <sunijsur@cisco.com>
In-Reply-To: <000001c9c299$bf50d3e0$f272150a@cisco.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Performance differences with IRQ_ALL_CPUS
Date: Tue, 21 Apr 2009 15:01:38 -0500
References: <000001c9c299$bf50d3e0$f272150a@cisco.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 10:56 AM, Subodh Nijsure wrote:

> Hi,
>
>
> I have board with MPC8572E (dual core PPC). I have one board running  
> kernel
> with IRQ_ALL_CPUS set to Y and another with that option turned off.   
> Kernel
> version #2.6.26
>
>
> With IRQ_ALL_CPUS turned off
> ( Here interrupts all go to CPU0 )
>
> hdparm -tT /dev/hda
> /dev/hda:
> Timing cached reads:   3048 MB in  2.00 seconds = 1523.79 MB/sec
> Timing buffered disk reads:   10 MB in  3.07 seconds =   3.25 MB/sec
>
> cat /proc/interrupts
>           CPU0       CPU1
> 18:    1394100          0   OpenPIC   Edge      ide0
>
> With IRQ_ALL_CPUS turned on I see
> (Here interrupts go to CPU0 and CPU1 )
>
> hdparm -tT /dev/hda
>
> /dev/hda:
> Timing cached reads:   1076 MB in  2.00 seconds = 538.01 MB/sec
> Timing buffered disk reads:   10 MB in  3.08 seconds =   3.25 MB/sec
>
> cat /proc/interrupts
>           CPU0       CPU1
> 18:      44951      54765   OpenPIC   Edge      ide0
>
> I "expected" that with IRQ_ALL_CPUS -- interrupt sharing I would be  
> able to
> get higher througput but I see things otherway around.
>
> Would someone care to enlighten me as to why when I set IRQ_ALL_CPUS  
> disk
> I/O performance goes down so much?  Under what circumstances should  
> one then
> turn on IRQ_ALL_CPUS option on PPC platform?
>
> Regards,
> /Subodh

This is probably because you are getting ill defined behavior on  
8572.  The 8572 (and any FSL MPIC) doesn't actually support having the  
PIC distribute interrupts to the different CPUs.  Its technically  
"illegal" to set more than one destination processor.

If you want to try and distribute interrupts than I suggest looking at  
irqbalance.

I'll look at a patch to deal with IRQ_ALL_CPUS to not setup the insane  
HW scenario.

- k
