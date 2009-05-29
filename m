Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bw0-f171.google.com (mail-bw0-f171.google.com
	[209.85.218.171]) by ozlabs.org (Postfix) with ESMTP id A2C52DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 20:56:15 +1000 (EST)
Received: by bwz19 with SMTP id 19so6122464bwz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 03:56:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090528123311.GA3112@pengutronix.de>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl> <20090528123311.GA3112@pengutronix.de>
Date: Fri, 29 May 2009 12:56:13 +0200
Message-ID: <1ba63b520905290356l5d519e64w3bd852d8fc4032be@mail.gmail.com>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27- "no_irq_chip"
	error
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FYI. The same applies to mpc8xx targets: No default host interrupt controll=
er.
The following patch was needed for our target:
---
diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_=
pic.c
index 5d2d552..92b2b66 100644
--- a/arch/powerpc/sysdev/mpc8xx_pic.c
+++ b/arch/powerpc/sysdev/mpc8xx_pic.c
@@ -186,6 +186,7 @@ int mpc8xx_pic_init(void)
                ret =3D -ENOMEM;
                goto out;
        }
+        irq_set_default_host(mpc8xx_pic_host);
        return 0;

 out:
---
Maybe setting a default host ought to be mandatory? Or is doing the
mapping manually
(without device tree descriptions) considered being a hack?

Frank


On Thu, May 28, 2009 at 2:33 PM, Wolfram Sang <w.sang@pengutronix.de> wrote=
:
>> this is an example of how a simple 8313 Periodic Interval Timer (PIT) ke=
rnel driver
>> registers for the PIT IRQ (Interrupt ID 65)
>>
>> #define PIT_IRQ 65
>>
>> =A0 =A0 virq =3D irq_create_mapping(NULL, PIT_IRQ);
>> =A0 =A0 set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
>>
>> =A0 =A0 if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (vo=
id *)0)) {
>> =A0 =A0 =A0 =A0 printk(KERN_ERR "request_irq() returned error for irq=3D=
%d virq=3D%d\n", PIT_IRQ, virq);
>> =A0 =A0 }
>
> It is some time ago, but when I did something similar I needed the
> following patch in order to use NULL for irq_create_mapping(). Have a
> try, and if it is still needed (as it looks from a glimpse), then maybe
> we should get it merged?
>
> =3D=3D=3D
>
> From: Wolfram Sang <w.sang@pengutronix.de>
> Subject: [PATCH] powerpc/cpm2: make cpm2_pic the default host
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> =A0arch/powerpc/sysdev/cpm2_pic.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pi=
c.c
> index 78f1f7c..7a7d4e5 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -272,4 +272,5 @@ void cpm2_pic_init(struct device_node *node)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "CPM2 PIC: failed to alloc=
ate irq host!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 irq_set_default_host(cpm2_pic_host);
> =A0}
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAkoehIYACgkQD27XaX1/VRsAygCePysW72eSPbW0rdM5DZ6lJS+7
> lEwAoItsU+K2CO9Eqfrwj64TgwEskB85
> =3D+3mh
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
