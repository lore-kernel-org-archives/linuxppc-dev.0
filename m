Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3F78A2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 06:15:06 +1100 (EST)
In-Reply-To: <1105730023.5420.58.camel@mud>
References: <1105730023.5420.58.camel@mud>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <95368204-6660-11D9-A893-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 14 Jan 2005 13:14:59 -0600
To: "Andrew May" <acmay@acmay.homeip.net>
Cc: Kumar Gala <galak@somerset.sps.mot.com>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: [PATCH] platform device driver model support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

What I have already done should be able to handle your situation,=20
assuming you can identify the two processor variants with a 32-bit=20
integer or a string.  In your board code you determine which variant=20
you are and then the device list will get registered based on that.

- kumar

On Jan 14, 2005, at 1:13 PM, Andrew May wrote:

> On Wed, 2005-01-12 at 14:14 -0700, Matt Porter wrote:
>  > On Wed, Jan 12, 2005 at 12:36:37AM -0800, Eugene Surovegin wrote:
>  > > On Wed, Jan 12, 2005 at 01:43:09AM -0600, Kumar Gala wrote:
>  > >
> > > In fact, I don't see any gain (at least for 4xx) in all these=20
> changes.
> > > It makes 4xx much more tangled IMHO, because we'll still need all
> > > those ibm405gp.c, ibm405ep.c, ibm440gp.c etc.
>  >
> > Summarizing some stuff from IRC (now that I'm caught up after time
>  > off :P), I think we can live with this on 4xx. What seems to be
>  > acceptable is that we can have an soc_specs[] and=20
> soc_platform_devices[]
> > in each 4xx SoC platform file. So, core_ocp[] can be merged and =
split
>  > into soc_specs[]/soc_platform_devices[]. The active one will be=20
> selected
> > at build time just like we do now. This is due to the static nature
>  > of the 4xx memory map (per SoC) and well as the variation in=20
> location
>  > of iomem and irq resources as well as platform_data. Our =
soc_specs[]
>  > will only have one SoC in it, since there is one per file. Doing
>  > something like 85xx will scatter info about as you point out
>  > above...and that doesn't make sense for 4xx.
>
> I would like to bring the Virtex-II Pro, into the thinking as well. It
>  is an FPGA around the 405 so it can be much more flexible on what=20
> makes
>  up the SoC.
>
> I am stuck working on 2.4 for a non-released product (so no code to
>  submit) and we have 2 of these chips on 1 board.
>
> One has only 1 UART and the other has 2. The rest of the standard
>  devices are the same, but they all have different IRQ mappings.
>
> I really don't want to build 2 different kernels just to handle this.=20=

> So
> far I have just overwritten the OCP struct at boot time to deal with=20=

> it,
>  based on a HW reg that tells me which chip I am running on. I also =
did
>  a kernel cmd line option saved in u-boot before I got the HW reg.
>
> If FPGAs start to make up more of the SoC market it don't think a=20
> simple
>  array of the devices is a good model to have. The FPGA could be =
loaded
>  differently for special modes with a very different setup.
>
> I am not sure what the trade off should be for the simple build time
>  array compared to the run time list that is built up.
>
> Would something like this be OK?
>
> struct chip_basic_features[] =3D { {}, {},....... };
>
> struct chip_ext1_features[] =3D { {}, {},....... };
>  struct chip_ext2_features[] =3D { {}, {},....... };
>
> LIST_HEAD(system_features);
>
>
>
> board_init()
>  {
>  =A0=A0=A0=A0=A0=A0=A0 list_add_tail( &system_features, =
&chip_basic_features );
>
> =A0=A0=A0=A0=A0=A0=A0 if( board1 ){
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 list_add_tail( =
&system_features, &chip_ext1_features=20
> );
>  =A0=A0=A0=A0=A0=A0=A0 }else{
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 list_add_tail( =
&system_features, &chip_ext2_features=20
> );
>  =A0=A0=A0=A0=A0=A0=A0 }
>  }
