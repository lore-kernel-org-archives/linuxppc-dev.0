Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND02.psi.ch (mailsend02.psi.ch [129.129.191.54])
	by ozlabs.org (Postfix) with ESMTP id 4C0DCDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 01:31:59 +1000 (EST)
Date: Wed, 29 Aug 2007 17:31:56 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux doesn not boot from u-boot on ML403
In-Reply-To: <fa686aa40708290817k897f8c2y5fdf12e5a48cc0ac@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0708291728450.20119-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

	Yes you are right that I should use uImage instead of zImage.elf

I have tried first bootm and uImage but it also hanged during 
uncompression so next I have tried bootelf zImage.elf to see how this 
works because I was able to run zImage.elf straight from EDK via jtag.

Cheers

Mirek
  

On Wed, 29 Aug 2007, Grant Likely wrote:

> On 8/29/07, Miroslaw Dach <miroslaw.dach@psi.ch> wrote:
> > Hi Grant,
> >
> >         My zImage.elf has 1.1 MB and uImage 968 KB.
> > Could you tell me please how to hook up GDB to debug u-boot?
> 
> Ah-HA!  You're using the wrong type of kernel image.  When booting
> from u-boot, you should be using a 'uImage', not a 'zImage.elf'.
> (generated with 'make uImage' in the kernel tree).  An you should use
> the 'bootm' command to boot the kernel.
> 
> With bootm, u-boot can pass parameters to the kernel and it is u-boot
> that does the uncompression (instead of the zImage wrapper).
> 
> Cheers,
> g.
> 
> 

-- 
=============================================================================
          Miroslaw Dach (Miroslaw.Dach@psi.ch) - SLS/Controls Group 
                PSI - Paul Scherrer Institut CH-5232 Villigen
=============================================================================
