Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7AE5BDDDEC
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Aug 2008 16:37:42 +1000 (EST)
Message-ID: <48969805.40904@ovro.caltech.edu>
Date: Sun, 03 Aug 2008 22:47:49 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: floating point support in the driver.
References: <18772952.post@talk.nabble.com>	<20080801.095429.-1827411968.imp@bsdimp.com>	<18805820.post@talk.nabble.com>
	<20080803.233352.915266361.imp@bsdimp.com>
In-Reply-To: <20080803.233352.915266361.imp@bsdimp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: misbah_khan@engineer.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Misbah,

I would recommend you look at your floating-point code again
and benchmark each section. You should be able to estimate
the number of clock cycles required to complete an operation
and then check that against your measurements.

Depending on whether your algorithm is processing intensive
or data movement intensive, you may find that the big time
waster is moving data on or off chip, or perhaps its a large
vector operation that is blowing out the cache. If you
do find that, then on some processors you can lock the
cache, so your algorithm would require a custom driver
that steals part of the cache from the OS, but the floating point
code would not run in the kernel, it would run on data
stored in the stolen cache area. You can lock both instructions
and data in the cache; eg. an FFT routine can be locked in
the instruction cache, while FFT data is in the data cache.
I'm not sure how easy this is to do under Linux though.

Here's an example of the level of detail you can get
downto when benchmarking code:

http://www.ovro.caltech.edu/~dwh/correlator/pdf/dsp_programming.pdf

The FFT routine used on this processor made use of both
the instruction and data cache (on-chip SRAM) on the
DSP.

This code is being re-developed to run on a MPC8349EA PowerPC
with FPU. I did some initial testing to confirm that the
FPU operates as per the data sheet, and will eventually get
around to more complete testing.

Which processor were you running your code on, and what
frequency were you operating the processor at? How does
the algorithm timing compare when run on other processors,
eg. your desktop or laptop machine?

Cheers,
Dave
