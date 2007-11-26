Return-Path: <dhlii@dlasystems.com>
Received: from outbound-mail-35.bluehost.com (outbound-mail-35.bluehost.com
	[69.89.18.155]) by ozlabs.org (Postfix) with SMTP id 084AADDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 08:23:42 +1100 (EST)
Message-ID: <474B37C9.8020405@dlasystems.com>
Date: Mon, 26 Nov 2007 16:16:57 -0500
From: "David H. Lynch Jr." <dhlii@dlasystems.com>
MIME-Version: 1.0
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Koss, Mike (Mission Systems) wrote:
> Time for my $.02, since I am heavily weighting my future designs on the
> use of the device trees. :) (and b/c I don't check my work e-mail from
> home ;P)
>
> ________________________________
>
> From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com] 
> Sent: Sunday, November 25, 2007 6:59 PM
> To: David H. Lynch Jr.; Grant Likely; linuxppc-embedded
> Subject: RE: Xilinx devicetrees
>
>
> SN> the device tree is packaged (somehow, TBD) along with the bitstream.
>   
    If xilinx wants to optionally incorporate the device tree into the
bitstream in a fashion that can easily be worked out by software - that
would be excellent.


>  
> I don't know if packaging the device tree with the bitstream is the best
> way to go. It's possible that it could lead to headaches for certain
> systems that have security restrictions. 
    Make it an option. Where are the systems with security restrictions
going to get their hardware information ?
    Besides - though I am not aware off the top of my head of a
bitstream decompliler, still if you have access to the bitstream you
have access to the information about the device. We deal with alot of
high security applications. Security restrictions have to make sense.
    blocking devicetrees for security reasons is like telling somebody
they can have the manual in computer readable form, but not on paper.
    Further if you are going to boot an OS that requires devicetrees
then the devicetree must be somewhere - whether it is appended to the
bitstream, appended to the kernel, compiled into the kernel, in a
separate file, it still has to be present.



> The same could be said for
> using it w/ the SystemACE to load it into RAM after the image. (which is
> what I'm currently doing for my 2 linux images in lieu of a true on-chip
> bootloader). I am already taking the security concerns into account for
> future revisions of the hardware wrt to using a SystemACE, and am
> planning on moving the device trees into NV storage like FLASH.
>   
    I am not working with MLXXX boards. Pico has no System ACE. The card
has an FPGA, flash, ram and a few other things all in a
CF/Cardbus/expressbus formfactor. You program it in a host with  our
tools. You run it either in the host or standalone.

>
> SN> I don't understand the 'burden on software developers'.  The code to
> do this will just be standard code.  
    I got 16K of RAM for my boot loader and that 16K has to do alot more
than just manage device trees.
    I think we have 2K left. In that I have to fit scripting, and
ethernet, so where am I supposed to fit the standard code ?
    If the devicetree is say at the end of the bit file I can probably
copy it to ram and pass a pointer to linux in maybe a couple of hundred
bytes.
    If I have to do much more it ain't happening.


> The worst that one can say is:
> SN> 1) I need several KB additional non volatile storage.  Given the
> size of the FPGA bitstream, this can't be a huge constraint.
>   
       Several KB is NOT happening. The bitstream is in flash. Flash is
not a limited reasorce for  us.
       FPGA cells, and BRAM are precious as gold. The more we use the
less our clients have.
     
       Different systems are going to have different resource constraints.
       What is unlimited for me may be severely limited for someone
else. What is unlimted for you may be seriously limited for me.
      

> I do agree that using more FPGA resources is not a solution to the
> problem. I'm already hitting 80% usage on a FX60 and trying to squeeze
> more real estate for storage of the device tree seems silly. Especially
> since that would require that every image have this extra hardware built
> into it just to support booting a Linux kernel. Why should I have to
> have different hardware to boot linux, versus non-kernel, xilkernel, or
> other (GHS, LynxOS, etc..)?
>   
    One of the problems is that neither devicetrees, nor any of the ways
of tracking them are one size fits all solutions.
    I do GHS work, it would be nice if GHS supported devicetrees and
maybe it will.
    bound to the kernel, in a separate file, appended to the bitstream
and in the FPGA fabric all have pluses and minuses.
    One reason I am harping on version registers is they are extremely
cost cheap, can easily be made optional, and can be fairly easily
incorporated into any OS (or no OS - we do that too). They are not a
replacement for devicetrees. But they still have very important uses in
many environments.

>
> SN> Certainly..  But in a sense, these are all intermediate files on the
> path to the image on the board.
    Unless we are going to teach linux to read and interpret .bit files
while loading, then devicetrees are intermediate in an entirely
different sense.
    The hardware works fine regardless of whether their is a devicetree.
But Linux may not boot.

     My objective is to get alot of software - linux, GHS, and
standalone apps, to all load - from a single executables, accross
multiple different bit images on several different (though deliberately
similar) products. My Linux kernel needs to work regardless of the Pico
card and regardless of the bit image, as done my GHS kernel, and ....
And I need to do that in a severly resource constrained environment.
    I would hope that should make sense of my harping about
version/capabilities registers. If I have maybe 10 possible peices of IP
that may/maynot be present in a given FPGA and I am trying to
dynamically configure - Linux/GHS/... to adapt to whatever it encounters
and work as long as it is a viable combination. At best devicetrees are
an extremly complex way of solving that - while version registers are a
trivial way.
    As an example I know that if I have a UartLite, Keyhole, TEMAC, PIC,
... they will always be at specific addresses. We never move them.
    But I do not know for sure it they are present. A version register
provides a fairly safe very efficient means of checking that a device is
present (and establishing its version and maybe capabilites) - device
trees might do the same thing but have alot higher overhead to do so.
   
    I deal more with presence/absence issues and maybe what version is
the IP rather than hardware is the IP and what IRQ is it using.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
