Return-Path: <carcadiz@hotmail.com>
Received: from bay0-omc2-s12.bay0.hotmail.com (bay0-omc2-s12.bay0.hotmail.com
	[65.54.246.148]) by ozlabs.org (Postfix) with ESMTP id 74A24DDE19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 00:31:07 +1000 (EST)
Message-ID: <BLU106-W2F7B9895D3B2F6669E4A4CAB90@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] phy: export phy_mii_ioctl
Date: Wed, 19 Sep 2007 16:31:05 +0200
In-Reply-To: <9e4733910709190656w3e979191mcd0d0776d46283cf@mail.gmail.com>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070902074143.GB2642@nd47.coderock.org>
	<fa686aa40709030857j6c36c87ek60215f812864ee0f@mail.gmail.com>
	<20070915121444.GA19857@nd47.coderock.org>
	<20070917095334.GA4546@powerlinux.fr>
	<20070917202140.GB2642@nd47.coderock.org>
	<9e4733910709171508s76c842c8hca236249617cbb44@mail.gmail.com>
	<20070918151622.GD32628@nd47.coderock.org>
	<9e4733910709181229m4afe7ecr56e2411f52a84232@mail.gmail.com>
	<BLU106-W49D16A32DDFE2611E15371CAB90@phx.gbl>
	<9e4733910709190656w3e979191mcd0d0776d46283cf@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On 9/19/07, Jon Smirl  wrote:

>On 9/19/07, Pedro Luis D. L.  wrote:
>>
>> Hello Jon,
>> I=B4m also working with a Phytec pcm030, but I can=B4t get it booted...
>> Which kernel are you using?
>> I tried to apply the 7 bestcomm patches from Sylvain and patch over thes=
e with this new ones that Domen released.
>> The base kernel I=B4m using is 2.6.22.6 from kernel.org.
>> Although I used the patch that creates pcm030.c in arch/platforms/52xx/ =
and compiled using this file, it gets halted at booting time.
>>
>> Bytes transferred =3D 5091 (13e3 hex)
>> ## Booting image at 00500000 ...
>>    Image Name:   Linux-2.6.22.6
>>    Created:      2007-09-19   8:53:02 UTC
>>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>>    Data Size:    1196911 Bytes =3D  1.1 MB
>>    Load Address: 00000000
>>    Entry Point:  00000000
>>    Verifying Checksum ... OK
>>    Uncompressing Kernel Image ... OK
>>    Booting using flat device tree at 0x400000
>>
>> (No more output and boot is halted)
>=20
=20

I checked that and both are the same:

In pcm030.c:

static int __init pcm030_probe(void)
{
	unsigned long node =3D of_get_flat_dt_root();

	if (!of_flat_dt_is_compatible(node, "pcm030"))
		return 0;

	return 1;
}

define_machine(pcm030) {
	.name 		=3D "pcm030",
	.probe 		=3D pcm030_probe,
	.setup_arch 	=3D pcm030_setup_arch,
	.restart	=3D mpc52xx_restart,
	.init           =3D pcm030_init,
	.init_IRQ 	=3D mpc52xx_init_irq,
	.get_irq 	=3D mpc52xx_get_irq,
	.show_cpuinfo	=3D pcm030_show_cpuinfo,
	.calibrate_decr	=3D generic_calibrate_decr,
};


in pcm030.dts:

	model =3D "pcm030";
	compatible =3D "pcm030\0mpc5200b\0mpc52xx";
	#address-cells =3D ;
	#size-cells =3D ;

And it still doesn=B4t boot...
I know it sounds hard, but... Can I skip the "if (!of_flat_dt_is_compatible=
(node, "pcm030"))" line?

This pcm030.c and pcm030.dts files work and boot with 2.6.20 kernel...

Pedro Dominguez


=20
_________________________________________________________________
Consigue el nuevo Windows Live Messenger
http://get.live.com/messenger/overview=
