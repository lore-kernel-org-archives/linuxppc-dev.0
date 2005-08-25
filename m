Return-Path: <ctz001@email.mot.com>
Received: from motgate3.mot.com (motgate3.mot.com [144.189.100.103])
	by ozlabs.org (Postfix) with ESMTP id D221A68111
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 11:20:51 +1000 (EST)
Received: from il06exr03.mot.com (pobox.mot.com [129.188.137.100])
	by motgate3.mot.com (8.12.11/Motgate3) with ESMTP id j7P1YPgG024670
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 18:34:25 -0700 (MST)
Received: from ddna.labs.mot.com (pompeii.ddna.labs.mot.com [199.5.233.20])
	by il06exr03.mot.com (Motorola/il06exr03) with ESMTP id j7P1Kmpg017275
	for <linuxppc-embedded@ozlabs.org>; Wed, 24 Aug 2005 20:20:48 -0500
Date: Wed, 24 Aug 2005 20:20:48 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <20050824134404.B1DF668108@ozlabs.org>
Message-ID: <EDFB2B1ED0A1D7118A0A00065BF2490D1E3A601B@il06exm13>
References: <20050824134404.B1DF668108@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: tomz <CTZ001@email.mot.com>
Subject: Re: Source of xparameter_ml300.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 24 Aug 2005 akonovalov@ru.mvista.com wrote:
> 
> Grant Likely wrote:
> > Does anyone know the origin of xparameter_ml300.h?  The
> > Xilinx EDK generates an xparameters.h file for each design, but the
> > structure of the file changes between releases.
> >
> > I want to know if xparameters_ml300.h is the exact output produced by
> > EDK or if stuff was changed before it was submitted to the mainline
> > tree.  (ie. all the stuff under the "linux redefines" comment block)
> 
> EDK can also generate the "Linux BSP".
> In this case EDK uses the scripts from (depending on your setup)
> /opt/xilinx/edk/7.1/sw/ThirdParty/bsp/linux_v2_00_b/data/
> In particular, linux_v2_1_0.tcl adds those "linux redefines"
> and renames xparameters.h to xparameters_ml300.h.
> 
> > Also, where can I get the bitstream/systemace file that matches
> > xparameters_ml300.h?
> 
> The most reliable way is to generate both (bitstream and
> xparameters_ml300.h) by yourself. :)
> 
> But if you are speaking about the xparameters_ml300.h in the community
> trees (linuxppc-2.4 and the 2.6 one from kernel.org), this file
> is for the reference design by Xilinx:
> 
> http://www.xilinx.com/ise/embedded/edk6_2docs/ml300_edk3.zip

Also, be aware that the differences between 'xparameters.h' and
'xparameters_ml300.h' are not all you need to worry about.


MontaVista's port to the ML300 also modified various Xilinx driver source
files (the code that appears under .../ppc405_0/include and
.../ppc405_0/libsrc, at least for me).
    Starting with MV's port to the ML300, you need to figure out which IP
versions it was created for (for example, "emac_v1_00_b").  Then you need
to compare that with the IP version used in your system [NOTE 1].  They'll
probably be different, so then you need to either merge MV's changes into
the newer Xilinx code or Xilinx's changes into the MV-modified drivers.
This leaves you with software drivers that match the IP and have the chang-
es needed to work in Linux.

You'll then have to keep an eye on IP versions as your hardware engineers
release new FPGA designs, and periodically repeat the above.  [NOTE 1]
The Tcl script mentioned above may take care of the 'xparameters.h' chang-
es but that's it -- when you're faced with changed Xilinx software you
have to re-port any changed drivers every time.


In addition, MV's porting is not always complete.  For example, their port-
ed EMAC driver supports "No DMA" and "Scatter/Gather DMA" modes but *not*
"Simple DMA".  They don't check certain corner cases, and they work around
Xilinx software driver bugs with an ML300-specific hack that won't work
with other boards (we ran into this when using a different PHY than what's
on the ML300).
    None of this is not documented anywhere that I can find.  Do not assume
that all of the IP+driver functionality you plan on using is ported to Lin-
ux -- check.
    It also looks like the Xilinx software driver bugs that MV found were
not reported to Xilinx but just worked around, so those bugs are probably
still present in your design.  They were in ours...


NOTE 1:  And don't depend on Xilinx's rev numbers changing when their dri-
          ver code does.  I regularly run across situations where consecu-
          tive FPGA designs both use, say, the "gpio_v2_00_a" IP and driver
          yet the driver code has changed.  It is important that you 'diff'
          or whatever all of the driver code for changes each time you re-
          ceive a new FPGA design generated from an XPS with *any* changes
          at all (new version, patches, etc.), even if it appears that the
          patch should not affect any driver code.


In the end, MV's port of Linux is to an ML300 with an old reference design
(even though the ML300 *board* hasn't changed, if that's true).  You're
presumably using more current Xilinx tools and IP, so you'll have to update
the port.  And you'll probably have to do so repeatedly.


It's analagous to MV porting to the [non-FPGA] Acme RealCool rev A board
while you're starting with the RealCool rev C and moving to revs D, E,
etc. every few weeks or months.
    This -- the relatively rapid change of FPGA 'hardware' compared to the
typically much slower changes to a board -- is a fundamental difference be-
tween FPGA and non-FPGA-based systems that you have to deal with.  I'm not
sure MV fully comprehends the consequences of that; if they did I would ex-
pect their port to document what specific IP versions it works with (not to
mention what functionality wasn't ported, but that applies to non-FPGA
hardware as well).

Of course, even if they did that we'd still have to suffer Xilinx's tenden-
cy to release multiple versions of things without changing their rev num-
bers  :-(


I've been where you're going...
Regards, Tom

-- 
   /"\  ASCII Ribbon Campaign   |   Email to user 'CTZ001'
   \ /                          |             at 'email.mot.com'
    X        Against HTML       |
   / \     in e-mail & news     |
