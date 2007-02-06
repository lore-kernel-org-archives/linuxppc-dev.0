Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id A8CC3DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Feb 2007 03:32:19 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Conditions for mydriver_probe to be called
Date: Tue, 6 Feb 2007 17:32:17 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E6237F2@aquib01a>
In-Reply-To: <20070206192307.71d41f03@vitb.ru.mvista.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Note that for 8xx, spi normally resides on scc, so you'll have to use
...set_func and >...device_enable() stuff (see in ppc_sys.c for exact
prototypes) to have foo-bar-scc:spi or=20
> alike registered on bus.

In my MPC880 the SPI is a standalone device not an SCC.=20

I found my problem, and I'm sorry that I disturbed the community for a
stupid mistake. Anyway I'm answering because someone could meet the same
problem.

In mpc8xx_devices.c I addedd the following:

        [MPC8xx_CPM_SPI] =3D {
                .name =3D "fsl-cpm-spi",
                .id     =3D 1,
                .num_resources  =3D 3,
                .resource =3D (struct resource[]) {
                        {
                                .name   =3D "regs",
                                .start  =3D 0xaa0,
                                .end    =3D 0xab1,
                                .flags  =3D IORESOURCE_MEM,
                        },
                        {
                                .name   =3D "pram",
                                .start  =3D 0x3d80,
                                .end    =3D 0x3daf,
                                .flags  =3D IORESOURCE_MEM,

                        },
                        {
                                .name   =3D "interrupt",
                                .start  =3D MPC8xx_INT_SPI,
                                .end    =3D MPC8xx_INT_SPI,
                                .flags  =3D IORESOURCE_IRQ,
                        },
                },
        },

But by mistake I registered mydriver with fsl_cpm_spi (with underscores
instead of -). The driver name should match the name in platform_device
structure or at least the default match function should be overriden.

I'm a newbie don't trust me completely (wait for an expert
confirmation).=20

Bye and thank you,
Antonio.
