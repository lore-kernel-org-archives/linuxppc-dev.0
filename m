Return-Path: <stevewin@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B3B367CD2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 02:30:21 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA3FUGl6017860
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 10:30:16 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA3FUGp4251200
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 08:30:16 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA3FUGwB029738
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 08:30:16 -0700
Subject: Fw: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
To: benh@kernel.crashing.org
Message-ID: <OFCD6BEB84.DE407CA1-ON8725721B.00508624-8525721B.00552A5F@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Fri, 3 Nov 2006 10:30:15 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBF888DFC300B48f9e8a93df938690918c08BBF888DFC300B4"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=08BBF888DFC300B48f9e8a93df938690918c08BBF888DFC300B4
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable








Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 11/02/2006
05:30:25 PM:

>
> > What exactly is the intent of PPC_MULTIPLATFORM - the current desc
> > states "Generic desktop/server/laptop" - which doesn't exactly scre=
am
> > 'embedded' to me either.  I guess I saw embedded6xx as a 'catch-all=
'
> > for everything else.
>
> It's historical. It was the good old prep/chrp/pmac option, meaning t=
hat
> more than one board support can be built in the same kernel. I've mad=
e
> the policy decision with ARCH=3Dpowerpc that we should now make that
> mandatory for new boards (of course provided the CPUs are of the same=

> family) since, as Sascha rightfully pointed out, it costs nothing and=

> keeps things cleaner.
>
> Thus I'm all about getting rid of the option :)
>

OK - so in this sense PPC_MULTIPLATFORM would be used more to help
categorize (make ppc platforms depend on it in Kconfig) as opposed to
enabling different code/function? (thus some of Sascha's patches gettin=
g
rid of CONFIG_PPC_MMULTIPLATFORM ifdefs)

> > This may be slightly off topic - but one other thing I have noticed=

> > that the new boot wrapper script supports specific 'types' of zImag=
e
> > files associated w/ 'MUTIPLATFORMS' (PSERIES, CHRP, PREP etc.) and
> > uImage - which is what I think the majority of 'embedded' platforms=

> > will use by defining CONFIG_DEFAULT_UIMAGE.
>
> That is not totally clear since they have non-compatible board info.

I should have more properly said "the majority of the existing 'embedde=
d'
platforms (not PSERIES, CHRP, PREP etc.) currently implmented in /power=

seem to define CONFIG_DEFAULT_UIMAGE"

> >   For IBM boards with PIBS just 'normal' zImage ELF files get loade=
d -
> > I'm not sure if there should be another type defined/supported for
> > boards which don't fit necessarily into a PSERIES/CHRP/PREP definit=
ion
> > and also don't use uboot - CONFIG_DEFAULT_ZIMAGE?
> >
>
> Ask Paulus about the naming but pSeries is just "normal" in the sense=

> that it's "booted from a real OF" support.
>
> The problem is despite the ability to do those nice multiplatform ker=
nel
> images, we still have bootloader incompatibilities. Thus we want to m=
ove
> those to the zImage wrapper which can produce, from an already built
> vmlinux binary, any zImage that can be supported for a given firmware=

> interface.
>
> In the long run, we hope that firmwares will finally get their gears
> together and use either a real OF entry point or a direct flat
> device-tree entry point, which means that a single zImage (the "norma=
l
> one as you call it) will be able to boot everything.
>
> There's also a glitch with real OF zImages due to the fact that IBM
> pSeries OF requires a Notes section forcing OF into real mode while
> Apple OF is allergic to that (it will crash badly) so we need to keep=
 a
> separate zImage for PowerMac. However, the vmlinux are the same so if=

> you use something like yaboot, the same vmlinux cna be booted on all
> those machines.

Makes sense.  Specific to the current wrapper though - the boot Makefil=
e
currently keys off the following for the different zImage 'types'

image-$(CONFIG_PPC_PSERIES)             +=3D zImage.pseries
image-$(CONFIG_PPC_MAPLE)               +=3D zImage.pseries
image-$(CONFIG_PPC_IBM_CELL_BLADE)      +=3D zImage.pseries
image-$(CONFIG_PPC_CHRP)                +=3D zImage.chrp
image-$(CONFIG_PPC_PMAC)                +=3D zImage.pmac
image-$(CONFIG_DEFAULT_UIMAGE)          +=3D uImage

My original point really was that if I have a ppc 'embedded' board whic=
h I
don't want to classify/define as PSERIES/MAPLE/CELL_BLADE/CHRP/PMAC, an=
d I
don't want to generate a uImage, I think there needs to be another
definition, something like CONFIG_DEFAULT_ZIMAGE (similar to how
CONFIG_DEFAULT_UIMAGE is used in some of the existing /power platform d=
efs
to create a uImage) which would be used to produce a 'normal' zImage ty=
pe
(zImage.pseries?).  Basically - a definition analogous to the exisiting=

CONFIG_DEFAULT_UIMAGE, but for zImage.  It would be used in a similar w=
ay -
where any platform could select in its configuration to result in a
'normal' zImage being created (indeed, could PPC_PSERIES/MAPLE/BLADE ju=
st
select this more generic definition and the Makefile use it instead?)
=

--0__=08BBF888DFC300B48f9e8a93df938690918c08BBF888DFC300B4
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><tt>Benjamin Herrenschmidt &lt;benh@kernel.crashing.org&gt; wrote on=
 11/02/2006 05:30:25 PM:<br>
<br>
&gt; <br>
&gt; &gt; What exactly is the intent of PPC_MULTIPLATFORM - the current=
 desc<br>
&gt; &gt; states &quot;Generic desktop/server/laptop&quot; - which does=
n't exactly scream<br>
&gt; &gt; 'embedded' to me either. &nbsp;I guess I saw embedded6xx as a=
 'catch-all'<br>
&gt; &gt; for everything else.<br>
&gt; <br>
&gt; It's historical. It was the good old prep/chrp/pmac option, meanin=
g that<br>
&gt; more than one board support can be built in the same kernel. I've =
made<br>
&gt; the policy decision with ARCH=3Dpowerpc that we should now make th=
at<br>
&gt; mandatory for new boards (of course provided the CPUs are of the s=
ame<br>
&gt; family) since, as Sascha rightfully pointed out, it costs nothing =
and<br>
&gt; keeps things cleaner.<br>
&gt; <br>
&gt; Thus I'm all about getting rid of the option :)<br>
&gt; </tt><br>
<br>
<tt>OK - so in this sense PPC_MULTIPLATFORM would be used more to help =
categorize (make ppc platforms depend on it in Kconfig) as opposed to e=
nabling different code/function? (thus some of Sascha's patches getting=
 rid of CONFIG_PPC_MMULTIPLATFORM ifdefs)</tt><br>
<br>
<tt>&gt; &gt; This may be slightly off topic - but one other thing I ha=
ve noticed<br>
&gt; &gt; that the new boot wrapper script supports specific 'types' of=
 zImage<br>
&gt; &gt; files associated w/ 'MUTIPLATFORMS' (PSERIES, CHRP, PREP etc.=
) and<br>
&gt; &gt; uImage - which is what I think the majority of 'embedded' pla=
tforms<br>
&gt; &gt; will use by defining CONFIG_DEFAULT_UIMAGE.<br>
&gt; <br>
&gt; That is not totally clear since they have non-compatible board inf=
o.</tt><br>
<tt><br>
I should have more properly said &quot;the majority of the existing 'em=
bedded' platforms (not PSERIES, CHRP, PREP etc.) currently implmented i=
n /power seem to define CONFIG_DEFAULT_UIMAGE&quot;</tt><br>
<tt><br>
&gt; &gt; &nbsp; For IBM boards with PIBS just 'normal' zImage ELF file=
s get loaded -<br>
&gt; &gt; I'm not sure if there should be another type defined/supporte=
d for<br>
&gt; &gt; boards which don't fit necessarily into a PSERIES/CHRP/PREP d=
efinition<br>
&gt; &gt; and also don't use uboot - CONFIG_DEFAULT_ZIMAGE? <br>
&gt; &gt; <br>
&gt; <br>
&gt; Ask Paulus about the naming but pSeries is just &quot;normal&quot;=
 in the sense<br>
&gt; that it's &quot;booted from a real OF&quot; support.<br>
&gt; <br>
&gt; The problem is despite the ability to do those nice multiplatform =
kernel<br>
&gt; images, we still have bootloader incompatibilities. Thus we want t=
o move<br>
&gt; those to the zImage wrapper which can produce, from an already bui=
lt<br>
&gt; vmlinux binary, any zImage that can be supported for a given firmw=
are<br>
&gt; interface.<br>
&gt; <br>
&gt; In the long run, we hope that firmwares will finally get their gea=
rs<br>
&gt; together and use either a real OF entry point or a direct flat<br>=

&gt; device-tree entry point, which means that a single zImage (the &qu=
ot;normal<br>
&gt; one as you call it) will be able to boot everything.<br>
&gt; <br>
&gt; There's also a glitch with real OF zImages due to the fact that IB=
M<br>
&gt; pSeries OF requires a Notes section forcing OF into real mode whil=
e<br>
&gt; Apple OF is allergic to that (it will crash badly) so we need to k=
eep a<br>
&gt; separate zImage for PowerMac. However, the vmlinux are the same so=
 if<br>
&gt; you use something like yaboot, the same vmlinux cna be booted on a=
ll<br>
&gt; those machines.</tt><br>
<tt><br>
Makes sense. &nbsp;Specific to the current wrapper though - the boot Ma=
kefile currently keys off the following for the different zImage 'types=
'</tt><br>
<br>
<tt>image-$(CONFIG_PPC_PSERIES) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; +=3D zImage.pseries</tt><br>
<tt>image-$(CONFIG_PPC_MAPLE) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; +=3D zImage.pseries</tt><br>
<tt>image-$(CONFIG_PPC_IBM_CELL_BLADE) &nbsp; &nbsp; &nbsp;+=3D zImage.=
pseries</tt><br>
<tt>image-$(CONFIG_PPC_CHRP) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;+=3D zImage.chrp</tt><br>
<tt>image-$(CONFIG_PPC_PMAC) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;+=3D zImage.pmac</tt><br>
<tt>image-$(CONFIG_DEFAULT_UIMAGE) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;+=3D=
 uImage</tt><br>
<br>
<tt>My original point really was that if I have a ppc 'embedded' board =
which I don't want to classify/define as PSERIES/MAPLE/CELL_BLADE/CHRP/=
PMAC, and I don't want to generate a uImage, I think there needs to be =
another definition, something like CONFIG_DEFAULT_ZIMAGE (similar to ho=
w CONFIG_DEFAULT_UIMAGE is used in some of the existing /power platform=
 defs to create a uImage) which would be used to produce a 'normal' zIm=
age type (zImage.pseries?). &nbsp;Basically - a definition analogous to=
 the exisiting CONFIG_DEFAULT_UIMAGE, but for zImage. &nbsp;It would be=
 used in a similar way - where any platform could select in its configu=
ration to result in a 'normal' zImage being created (indeed, could PPC_=
PSERIES/MAPLE/BLADE just select this more generic definition and the Ma=
kefile use it instead?)</tt><br>
<tt>&nbsp;<br>
</tt></body></html>=

--0__=08BBF888DFC300B48f9e8a93df938690918c08BBF888DFC300B4--
