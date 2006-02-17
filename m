Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78EDF679F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 12:22:53 +1100 (EST)
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: scatter/gather DMA and cache coherency
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
	<20060216174655.GC16848@mag.az.mvista.com>
Date: Fri, 17 Feb 2006 11:52:31 +1030
Message-ID: <kwaccqbwyw.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "MAG" == Mark A Greer <mgreer@mvista.com> writes:

  MAG> On Thu, Feb 16, 2006 at 05:51:20PM +1030, Phil Nitschke wrote:
  >> The problem is, that sometimes the data is corrupt (usually on the
  >> first transfer).  We've concluded that the problem is related to
  >> cache coherency.  The Artesyn 2.6.10 reference kernel (branched
  >> from the kernel at penguinppc.org) must be built with
  >> CONFIG_NOT_COHERENT_CACHE=y, as Artesyn have never successfully
  >> verified operation with hardware coherency enabled.  My
  >> understanding is that their Marvel system controller (MV64460)
  >> supports cache snooping, but their Linux kernel support hasn't
  >> caught up yet.

  MAG> It would have been useful if you had given the actual hardware
  MAG> you're using.

Processor: http://www.artesyncp.com/products/PmPPC7448.html

  MAG> For the record, don't assume that this is Artesyn's fault.
  MAG> Artesyn says that the erratum workaround is impractical and they
  MAG> may be right.  I don't know, I just write software...

I don't know either.  I don't have a problem with Artesyn; they've
always been nice to me ;-)  Here's what one of their engineers had to
say on the topic:

  Artesyn> I stated in a previous email that our boards must have the
  Artesyn> CONFIG_NOT_COHERENT_CACHE option turned on.  This is because
  Artesyn> or our history with the Discovery family of bridges.
  Artesyn> Initially it was reported that the hardware cache coherency
  Artesyn> (snooping) was known to be not functional.  Then at a later
  Artesyn> date when it was supposed to be fixed, we found that it was
  Artesyn> not completely dependable so Artesyn has taken a stance to
  Artesyn> not trust snooping on the Discovery chips and to always use
  Artesyn> software cache coherency methods.

  >> So if I understand my situation correctly, the device driver must
  >> use software-enforced coherency to avoid data corruption.  Is this
  >> correct?

  MAG> It looks like Eugene is guiding you on this.  Listen to him.  I
  MAG> will add that you should align your buffers on cacheline
  MAG> boundaries and make the allocation sizes multiples of the
  MAG> cacheline size otherwise you could have other data sharing the
  MAG> first and/or last cacheline of your buffers and mess up your
  MAG> software cache mgmt.

It might well be that the third party driver isn't enforcing the
cacheline boundary alignment.  Artesyn tell me that "it is stated in the
MV64460 Users Manual that when interfacing cache coherent DRAM or
integrated SRAM, the maximum write burst size must be set to 32 bytes".
So I guess this is that cacheline size?  Anyway, we don't see any
corruption when the DMA buffer size is 32 bytes, but we do see it for 24
bytes, 36 bytes, etc.

I'll discuss this with the H/W vendors that wrote the driver.

--
Phil
