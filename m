Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id F240ADDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 09:19:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx devicetrees
Date: Mon, 26 Nov 2007 16:19:40 -0600
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333F0A58EE@XMBIL132.northgrum.com>
In-Reply-To: <474B37C9.8020405@dlasystems.com>
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<474B37C9.8020405@dlasystems.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "David H. Lynch Jr." <dhlii@dlasystems.com>
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

=20
>> I don't know if packaging the device tree with the bitstream is the=20
>> best way to go. It's possible that it could lead to headaches for=20
>> certain systems that have security restrictions.
>    Make it an option. Where are the systems with security restrictions
going to get their hardware information ?
>    Besides - though I am not aware off the top of my head of a
bitstream decompliler, still if you have access to the bitstream you
have access to
> the information about the device. We deal with alot of high security
applications. Security restrictions have to make sense.
>    blocking devicetrees for security reasons is like telling somebody
they can have the manual in computer readable form, but not on paper.
>    Further if you are going to boot an OS that requires devicetrees
then the devicetree must be somewhere - whether it is appended to the
bitstream,
> appended to the kernel, compiled into the kernel, in a separate file,
it still has to be present.

The devicetree itself is not the security concern, but the retrieval of
it from the bitstream. If it is stored in the FPGA, it may be that
accessing that stored information may not be probable at run-time.

>> The worst that one can say is:
>> SN> 1) I need several KB additional non volatile storage.  Given the
>> size of the FPGA bitstream, this can't be a huge constraint.
>>  =20
>       Several KB is NOT happening. The bitstream is in flash. Flash is
not a limited reasorce for  us.
>       FPGA cells, and BRAM are precious as gold. The more we use the
less our clients have.

Which is why I'm proposing that it be an "extra" file that can be stored
however. For one system, it could be stored in the FPGA using BRAM and
it could be automatically available to kernel. For another system, it
could be stored in FLASH and the bootloader may have to copy the data
from FLASH to RAM.

>> I do agree that using more FPGA resources is not a solution to the=20
>> problem. I'm already hitting 80% usage on a FX60 and trying to
squeeze=20
>> more real estate for storage of the device tree seems silly.=20
>> Especially since that would require that every image have this extra=20
>> hardware built into it just to support booting a Linux kernel. Why=20
>> should I have to have different hardware to boot linux, versus=20
>> non-kernel, xilkernel, or other (GHS, LynxOS, etc..)?
>>  =20
>    One of the problems is that neither devicetrees, nor any of the
ways of tracking them are one size fits all solutions.
>    I do GHS work, it would be nice if GHS supported devicetrees and
maybe it will.
>    bound to the kernel, in a separate file, appended to the bitstream
and in the FPGA fabric all have pluses and minuses.
>    One reason I am harping on version registers is they are extremely
cost cheap, can easily be made optional, and can be fairly easily
incorporated > into any OS (or no OS - we do that too). They are not a
replacement for devicetrees. But they still have very important uses in
many environments.

>
>> SN> Certainly..  But in a sense, these are all intermediate files on=20
>> SN> the
>> path to the image on the board.
>    Unless we are going to teach linux to read and interpret .bit files
while loading, then devicetrees are intermediate in an entirely
different
> sense.
>    The hardware works fine regardless of whether their is a
devicetree.
> But Linux may not boot.

You are correct, but I think a single self-contained file that has all
of the hardware descriptions is much preferred to many header files, and
#ifdef macro's to make sense of what is actually available at run-time.

>     My objective is to get alot of software - linux, GHS, and
standalone apps, to all load - from a single executables, accross
multiple different
> bit images on several different (though deliberately
> similar) products. My Linux kernel needs to work regardless of the
Pico card and regardless of the bit image, as done my GHS kernel, and
....
> And I need to do that in a severly resource constrained environment.
>    I would hope that should make sense of my harping about
version/capabilities registers. If I have maybe 10 possible peices of IP
that may/maynot
> be present in a given FPGA and I am trying to dynamically configure -
Linux/GHS/... to adapt to whatever it encounters and work as long as it
is a
> viable combination. At best devicetrees are an extremly complex way of
solving that - while version registers are a trivial way.
>    As an example I know that if I have a UartLite, Keyhole, TEMAC,
PIC, ... they will always be at specific addresses. We never move them.
>    But I do not know for sure it they are present. A version register
provides a fairly safe very efficient means of checking that a device is
> present (and establishing its version and maybe capabilites) - device
trees might do the same thing but have alot higher overhead to do so.

For your system, yes, you never move the location of the devices. But
for others, we may add other pieces or multiple pieces and require them
in multiple/different places. That's the beauty of the device tree. You
*can* create that one monolithic kernel that has support for ANY type of
hardware, and at boot-time a device tree is provided to the kernel that
defines all of the devices that are physically available in your FPGA.

I'm not trying to argue for/against the version registers. Just that a
version register is short-sighted with regards to the larger FPGA-based
view. Version registers work wonderfully when everything is staticly
located, like in your image builds or a SoC like 440GX. For general
usage for others creating their own FPGA images with varying hardware
setups, statically defined location version register checking is not
feasible.

The device tree approach can "easily" be adapted to other systems, such
as GHS, through adaptors in your corresponding BSP.

-- Mike
