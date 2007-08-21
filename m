Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 6105ADDE22
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 18:32:53 +1000 (EST)
Message-ID: <46CAA332.9060907@dutchspace.nl>
Date: Tue, 21 Aug 2007 10:32:50 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Konstantin Boyanov <kkboyanov@gmail.com>
Subject: Re: Driver for device behind a PCI-VME bridge
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>	<46C954AA.7050609@dutchspace.nl>	<929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>	<929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>
	<929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>
In-Reply-To: <929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Konstantin Boyanov wrote:
>
> Hi again,
>  
> After some googling I came to the conclusion that the best approach to 
> understanding how to write a driver for a device behind a PCI-XXX 
> bridge is to look at the source for the USB subsystem, although the 
> USB subsystem is actually a bus subssytem and not a class.

I also work with devices on the VME bus. The approach we took is to map 
all the devices into userspace, and use Xenomai for RT performance. This 
avoids the need to write drivers for all the devices. The RT-performance 
of Xenomai is quite good: the jitter on a timer-interrupt is always less 
than 20usec, even under high load, where standard Linux only achieves 
this in a no load situatieo, under high load standard Linux has a jitter 
of over 10 msec.

The setup we choose was to have a RT-interrupt handler and a RT IOCTL 
call "WAIT_FOR_INTERRUPT". This is a slightly modified version from the 
Motorola driver (I guess that you also use the Tundra chipset to access 
the VME-bus). Here you can wait for a specific VME interrupt-level, and 
it returns the vector number. So you can have several applications 
connect to the same VME driver, but all on different levels.

Kind regards,
    Johan Borkhuis
