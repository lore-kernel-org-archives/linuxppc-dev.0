Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE001.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 95936DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 04:04:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
Date: Wed, 14 May 2008 11:03:58 -0700
In-Reply-To: <fa686aa40805140835v14b9ff85od01e74985e8e3586@mail.gmail.com>
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
	<fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
	<20080512191025.67682630064@mail160-dub.bigfish.com>
	<fa686aa40805121246i68c42867k150c5f9e0082598f@mail.gmail.com>
	<20080512195905.8DD2717B805C@mail2-dub.bigfish.com>
	<fa686aa40805140835v14b9ff85od01e74985e8e3586@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080514180400.21D9316E0068@mail90-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Wednesday, May 14, 2008 8:35 AM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; git-dev
> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507
dvi core.
>=20
> On Mon, May 12, 2008 at 1:59 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf
Of
> > Grant Likely
> >> Sent: Monday, May 12, 2008 12:46 PM
> >> To: Stephen Neuendorffer
> >> Cc: linuxppc-dev@ozlabs.org; git-dev
> >> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for
ml507
> > dvi core.
> >>
> >> On Mon, May 12, 2008 at 1:10 PM, Stephen Neuendorffer
> >> <stephen.neuendorffer@xilinx.com> wrote:
> >> >
> >> >  The best possibility that I see is glopping the compatibility
> >> >  information about what cores are compatible with which drivers
and
> >> >  generating something.  This is moderately better than blindly
> > treating
> >> >  all cores with the same major version as interface compatible,
but
> > still
> >> >  has the potential to blindly declare that core versions are
> > compatible
> >> >  when they are not really compatible.
> >>
> >> That's okay, the device tree conventions provide for that
uncertainty.
> >>  If compatible includes both the *exact* version and the oldest
known
> >> *compatible* version (the one the drivers know about) then we're in
> >> the situation where 99% of the time it just works.  For the 1% of
the
> >> time when mistakes are made we still have the necessary information
to
> >> write exceptions in the code to work around bad data.  This means
code
> >> only needs to changes when mistakes are discovered, not for every
IP
> >> core uprev.
> >
> > My argument was that we should do this by truncating the major
version,
> > which is also an established standard that cores *should* follow,
but
> > you didn't like that. :)  It makes at least as much sense as
expressing
> > the compatibility of the driver in the tree in terms of
compatibility
> > with some other random driver.  In the case of the tft core in
> > particular, there *is* no other driver AFAIK.
>=20
> The whole point of compatible is to describe software interfaces...
> *if* a device is register level backwards compatible with an older
> already supported device, *then* it is appropriate to claim
> compatibility with it.  True, the TFT core is not the same as the VGA
> core.  But (as your patch suggests) the register interface is
> backwards compatible.

Certainly... I don't think the question is how to do it, I think the
question is how to systematically get this information from the people
who build the cores, rather than having it put in on a case-by-case
basis somewhere down the line.  This is as much a Xilinx organizational
issue as anything.  If we *can't* get it in a systematic way, then I see
nothing better than putting it explicitly in the compatible list.  The
current answer that I've gotten from the IP group is that the systematic
way to represent this information is through the major/minor version.
Specifically:

"The brief summary is that in a <major>.<minor>.<letter> version string:
- a change of the <letter> guarantees complete backward compatibility
- a change of the <minor> is new or modified behavior.  The register
interface should remain compatible, although new features may be added.
I wouldn't say this guarantees backward compatibility, though, because
default values can change or behavior in general can change.
- a change of the <major> is quite likely to lose backward
compatibility."

> As for truncating the major version; you're right, I don't like it,
> but that doesn't mean I cannot be swayed.  Best argument is to
> analogize it with a similar SoC situation.  A particular SoC (let's
> say the MPC8349) will have several revisions to it, but none of that
> is reflected in the device tree.  It's just referred to as
> "fsl,mpc8349".  Actual silicon revision is obtainable by software from
> the PVR/SVR if it *really* needs it.  The counter example is the
> MPC5200/MPC5200b where the 'b' version is explicitly specified in the
> compatible list (see arch/powerpc/boot/dts/lite5200b.dts).  The 5200b
> is 99% compatible with the original 5200, with only a couple of on
> chip peripherals not being register level compatible.  I'm still not
> completely certain that "fsl,mpc5200b-<blah>" was the right decision,
> but by being conservative early on means that I can still drop most of
> the 'b' specifiers at some point in the future without breaking board
> support.
>=20
> What makes me nervous about FPGA IP cores is that the potential for
> change is much higher than for an SoC.  SoC vendors get very angry
> customers if a silicon uprev breaks their drivers; especially
> considering that they could very easily have boards with both the old
> and new silicon.  It does not seem to me like there is quite the same
> level of pressure too keep the register level interface 100%
> compatible.  So this is the pressure point to apply if you want to
> change my mind.  How confident are you that the major (or minor)
> revision will remain register level compatible?

I'd actually turn it around: In most cases users of an FPGA device have
*much* more control over these versions than in a microprocessor
situation.  Generally speaking, if there is a letter-version increment,
EDK generally forces you to accept the version increment when moving
from one version of EDK (with one set of IP versions) to another.  If
there is a minor-version increment, then EDK asks you if you want to
change.  If there is a major-version increment, then EDK notifies you of
the change, but doesn't do anything automatically.  You certainly can't
do that in an SoC.

> n>> >  I *really* don't want to put this into the device tree
generator on
> > a
> >> >  case-by-case basis, so unless there is something that can be
> > generated
> >> >  from whatever meta-information EDK has, I think we're going to
have
> > to
> >> >  just have the explicit versions in the drivers for the time
being.
> >>
> >> Can we post process the generated device tree with a table of known
> >> compatibility strings (or regexps) for adding the older compatible
> >> values?  I don't expect the list will be particularly long or hard
to
> >> maintain and the code to do so should be trivial.
> >
> > Ug, that's just pushing the problem around.
> > This seems as much like an argument for putting wildcards in the
> > compatible bindings in the kernel as anything...
>=20
> Not quite.  There is a difference between method used to generate the
> data, and how the data is interpreted by the kernel (the boundary
> being what data is actually passed to the kernel).  If the tool
> generates bad/inaccurate data, then it is a bug and it should be
> fixed.  Even better, it is a bug that will be found quickly because
> the device simply won't work if it binds to the wrong driver.  I do
> not want to load knowledge of all those permutation into the kernel
> image.
>
> (But I do agree that my suggestion was rather smelly)

HA!  Well, I guess I was trying to be polite.. :)  The much bigger
problem than binding to the wrong driver is not binding to the right
driver, particularly for anything having to do with the console.

So, what I hear is that you might be accepting of using compatible
strings of the form:

xlnx,opb-hwicap-1   (saving ~5 compatible entries in the current xilinx
git tree)
or=20
xlnx,opb-hwicap-1.00  (saving ~4 more)

Steve

arch/powerpc/boot/serial.c:     else if (dt_is_compatible(devp,
"xlnx,opb-uartlite-1.00.b") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,xps-uartlite-1.00.a"))
arch/powerpc/boot/serial.c:     else if (dt_is_compatible(devp,
"xlnx,opb-uart16550-1.00.c") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,opb-uart16550-1.00.d") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,opb-uart16550-1.00.e") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,plb-uart16550-1.00.c") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,xps-uart16550-1.00.a") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,xps-uart16550-2.00.a") ||
arch/powerpc/boot/serial.c:              dt_is_compatible(devp,
"xlnx,xps-uart16550-2.00.b"))
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,plb-v46-1.00.a", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,plb-v46-1.02.a", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,plb-v34-1.01.a", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,plb-v34-1.02.a", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,opb-v20-1.10.c", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D
"xlnx,dcr-v29-1.00.a", },
arch/powerpc/platforms/44x/virtex.c:    { .compatible =3D "xlnx,compound",
},
arch/powerpc/platforms/44x/virtex.c:    if
(!of_flat_dt_is_compatible(root, "xlnx,virtex"))
arch/powerpc/sysdev/xilinx_intc.c:      for_each_compatible_node(np,
NULL, "xlnx,opb-intc-1.00.c") {
arch/powerpc/sysdev/xilinx_intc.c:
for_each_compatible_node(np, NULL, "xlnx,xps-intc-1.00.a") {
arch/microblaze/kernel/platform.c:      { .compatible =3D
"xlnx,plb-v46-1.00.a", },
arch/microblaze/kernel/platform.c:      { .compatible =3D
"xlnx,plb-v34-1.01.a", },
arch/microblaze/kernel/platform.c:      { .compatible =3D
"xlnx,plb-v34-1.02.a", },
arch/microblaze/kernel/platform.c:      { .compatible =3D
"xlnx,opb-v20-1.10.c", },
arch/microblaze/kernel/platform.c:      { .compatible =3D
"xlnx,dcr-v29-1.00.a", },
arch/microblaze/kernel/platform.c:      { .compatible =3D "xlnx,compound",
},
drivers/block/xsysace.c:        { .compatible =3D
"xlnx,opb-sysace-1.00.b", },
drivers/block/xsysace.c:        { .compatible =3D
"xlnx,opb-sysace-1.00.c", },
drivers/block/xsysace.c:        { .compatible =3D
"xlnx,xps-sysace-1.00.a", },
drivers/char/xilinx_hwicap/xilinx_hwicap.c:     { .compatible =3D
"xlnx,opb-hwicap-1.00.b", .data =3D &buffer_icap_config},
drivers/char/xilinx_hwicap/xilinx_hwicap.c:     { .compatible =3D
"xlnx,xps-hwicap-1.00.a", .data =3D
&fifo_icap_config},drivers/i2c/algos/xilinx_iic/i2c-algo-xilinx.c: {
.compatible =3D "xlnx,xps-iic-2.00.a", },
drivers/input/serio/xilinx_ps2/xps2_linux.c:    { .compatible =3D
"xlnx,opb-ps2-dual-ref-1.00.a", },
drivers/input/serio/xilinx_ps2/xps2_linux.c:    { .compatible =3D
"xlnx,xps-ps2-1.00.a", },
drivers/net/xilinx_emac/xemac_linux.c:  { .compatible =3D
"xlnx,opb-ethernet-1.01.a", },
drivers/net/xilinx_emac/xemac_linux.c:  { .compatible =3D
"xlnx,opb-ethernet-1.02.a", },
drivers/net/xilinx_emac/xemac_linux.c:  { .compatible =3D
"xlnx,opb-ethernet-1.04.a", },
drivers/net/xilinx_emac/xemac_linux.c:  { .compatible =3D
"xlnx,plb-ethernet-1.00.a", },
drivers/net/xilinx_emac/xemac_linux.c:  { .compatible =3D
"xlnx,plb-ethernet-1.01.a", },
drivers/net/xilinx_emaclite/adapter.c:  { .compatible =3D
"xlnx,opb-ethernetlite-1.01.a", },
drivers/net/xilinx_emaclite/adapter.c:  { .compatible =3D
"xlnx,opb-ethernetlite-1.01.b", },
drivers/net/xilinx_emaclite/adapter.c:  { .compatible =3D
"xlnx,xps-ethernetlite-1.00.a", },
drivers/net/xilinx_emaclite/adapter.c:  { .compatible =3D
"xlnx,xps-ethernetlite-2.00.a", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-fifo-1.00.a", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-fifo-1.00.b", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,ll-dma-1.00.a", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-temac-1.00.a", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-temac-1.00.b", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-temac-1.01.a", },
drivers/net/xilinx_lltemac/xlltemac_main.c:     { .compatible =3D
"xlnx,xps-ll-temac-1.01.b", },
drivers/serial/uartlite.c:      { .compatible =3D
"xlnx,opb-uartlite-1.00.b", },
drivers/serial/uartlite.c:      { .compatible =3D
"xlnx,xps-uartlite-1.00.a", },
drivers/video/xilinxfb.c:       { .compatible =3D
"xlnx,plb-tft-cntlr-ref-1.00.a", },
drivers/video/xilinxfb.c:       { .compatible =3D
"xlnx,plbv46-tft-cntlr-1.00.a", },
drivers/video/xilinxfb.c:       { .compatible =3D
"xlnx,plb-dvi-cntlr-ref-1.00.c", },



This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be=
 proprietary, privileged or copyrighted under applicable law. If you are=
 not the intended recipient, do not read, copy, or forward this email=
 message or any attachments. Delete this email message and any attachments=
 immediately.
