Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 4E7C8B7C8C
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 07:15:49 +1100 (EST)
Received: by ewy6 with SMTP id 6so5438398ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 12:15:47 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.OSX.2.00.0911171715450.371@silk.local>
References: <alpine.OSX.2.00.0911031502250.483@silk.local>
	<1258423421.2140.555.camel@pasglop>
	<alpine.OSX.2.00.0911171715450.371@silk.local>
Date: Wed, 23 Dec 2009 21:15:46 +0100
Message-ID: <10f740e80912231215m2868aec3qb3c9a419f3635bef@mail.gmail.com>
Subject: Re: [PATCH 10/13] mac68k: start CUDA early, take 2
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 10:03, Finn Thain <fthain@telegraphics.com.au> wrot=
e:
> The valkyriefb driver needs the CUDA to work in order to set the video
> mode at boot. So initialise the device earlier, and bring the m68k code
> closer to the powermac code.
>
> Take 2 was changed as per Benjamin Herrenschmidt's review.

Ben, OK for you?

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
> =C2=A0arch/m68k/mac/config.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +++
> =C2=A0drivers/macintosh/adb.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 ++-
> =C2=A0drivers/macintosh/via-cuda.c | =C2=A0 74 +++++++++++++++++++++++---=
-----------------
> =C2=A03 files changed, 51 insertions(+), 35 deletions(-)
>
> Index: linux-2.6.31/arch/m68k/mac/config.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/arch/m68k/mac/config.c =C2=A0 =C2=A02009-11-17 17:1=
1:47.000000000 +1100
> +++ linux-2.6.31/arch/m68k/mac/config.c 2009-11-17 17:11:47.000000000 +11=
00
> @@ -23,6 +23,8 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/vt_kern.h>
> =C2=A0#include <linux/platform_device.h>
> +#include <linux/adb.h>
> +#include <linux/cuda.h>
>
> =C2=A0#define BOOTINFO_COMPAT_1_0
> =C2=A0#include <asm/setup.h>
> @@ -889,6 +891,10 @@ static void __init mac_identify(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0oss_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0psc_init();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0baboon_init();
> +
> +#ifdef CONFIG_ADB_CUDA
> + =C2=A0 =C2=A0 =C2=A0 find_via_cuda();
> +#endif
> =C2=A0}
>
> =C2=A0static void __init mac_report_hardware(void)
> Index: linux-2.6.31/drivers/macintosh/via-cuda.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/macintosh/via-cuda.c =C2=A0 =C2=A0 =C2=A020=
09-11-17 17:07:58.000000000 +1100
> +++ linux-2.6.31/drivers/macintosh/via-cuda.c =C2=A0 2009-11-17 17:11:47.=
000000000 +1100
> @@ -89,7 +89,6 @@ static int cuda_fully_inited;
>
> =C2=A0#ifdef CONFIG_ADB
> =C2=A0static int cuda_probe(void);
> -static int cuda_init(void);
> =C2=A0static int cuda_send_request(struct adb_request *req, int sync);
> =C2=A0static int cuda_adb_autopoll(int devs);
> =C2=A0static int cuda_reset_adb_bus(void);
> @@ -107,17 +106,42 @@ int cuda_request(struct adb_request *req
>
> =C2=A0#ifdef CONFIG_ADB
> =C2=A0struct adb_driver via_cuda_driver =3D {
> - =C2=A0 =C2=A0 =C2=A0 "CUDA",
> - =C2=A0 =C2=A0 =C2=A0 cuda_probe,
> - =C2=A0 =C2=A0 =C2=A0 cuda_init,
> - =C2=A0 =C2=A0 =C2=A0 cuda_send_request,
> - =C2=A0 =C2=A0 =C2=A0 cuda_adb_autopoll,
> - =C2=A0 =C2=A0 =C2=A0 cuda_poll,
> - =C2=A0 =C2=A0 =C2=A0 cuda_reset_adb_bus
> + =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D "CUDA",
> + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D cuda_probe,
> + =C2=A0 =C2=A0 =C2=A0 .send_request =3D cuda_send_request,
> + =C2=A0 =C2=A0 =C2=A0 .autopoll =C2=A0 =C2=A0 =3D cuda_adb_autopoll,
> + =C2=A0 =C2=A0 =C2=A0 .poll =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D cuda_poll,
> + =C2=A0 =C2=A0 =C2=A0 .reset_bus =C2=A0 =C2=A0=3D cuda_reset_adb_bus,
> =C2=A0};
> =C2=A0#endif /* CONFIG_ADB */
>
> -#ifdef CONFIG_PPC
> +#ifdef CONFIG_MAC
> +int __init find_via_cuda(void)
> +{
> + =C2=A0 =C2=A0struct adb_request req;
> + =C2=A0 =C2=A0int err;
> +
> + =C2=A0 =C2=A0if (macintosh_config->adb_type !=3D MAC_ADB_CUDA)
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +
> + =C2=A0 =C2=A0via =3D via1;
> + =C2=A0 =C2=A0cuda_state =3D idle;
> +
> + =C2=A0 =C2=A0err =3D cuda_init_via();
> + =C2=A0 =C2=A0if (err) {
> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "cuda_init_via() failed\n");
> + =C2=A0 =C2=A0 =C2=A0 via =3D NULL;
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0/* enable autopoll */
> + =C2=A0 =C2=A0cuda_request(&req, NULL, 3, CUDA_PACKET, CUDA_AUTOPOLL, 1)=
;
> + =C2=A0 =C2=A0while (!req.complete)
> + =C2=A0 =C2=A0 =C2=A0 cuda_poll();
> +
> + =C2=A0 =C2=A0return 1;
> +}
> +#else
> =C2=A0int __init find_via_cuda(void)
> =C2=A0{
> =C2=A0 =C2=A0 struct adb_request req;
> @@ -175,7 +199,7 @@ int __init find_via_cuda(void)
> =C2=A0 =C2=A0 vias =3D NULL;
> =C2=A0 =C2=A0 return 0;
> =C2=A0}
> -#endif /* CONFIG_PPC */
> +#endif /* !defined CONFIG_MAC */
>
> =C2=A0static int __init via_cuda_start(void)
> =C2=A0{
> @@ -184,14 +208,14 @@ static int __init via_cuda_start(void)
>
> =C2=A0#ifdef CONFIG_MAC
> =C2=A0 =C2=A0 cuda_irq =3D IRQ_MAC_ADB;
> -#else /* CONFIG_MAC */
> +#else
> =C2=A0 =C2=A0 cuda_irq =3D irq_of_parse_and_map(vias, 0);
> =C2=A0 =C2=A0 if (cuda_irq =3D=3D NO_IRQ) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "via-cuda: can't map interrupt=
s for %s\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vias->full_name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> =C2=A0 =C2=A0 }
> -#endif /* CONFIG_MAC */
> +#endif
>
> =C2=A0 =C2=A0 if (request_irq(cuda_irq, cuda_interrupt, 0, "ADB", cuda_in=
terrupt)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ERR "via-cuda: can't request irq %=
d\n", cuda_irq);
> @@ -216,28 +240,10 @@ cuda_probe(void)
> =C2=A0#else
> =C2=A0 =C2=A0 if (macintosh_config->adb_type !=3D MAC_ADB_CUDA)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> - =C2=A0 =C2=A0via =3D via1;
> =C2=A0#endif
> - =C2=A0 =C2=A0return 0;
> -}
> -
> -static int __init
> -cuda_init(void)
> -{
> -#ifdef CONFIG_PPC
> =C2=A0 =C2=A0 if (via =3D=3D NULL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;
> =C2=A0 =C2=A0 return 0;
> -#else
> - =C2=A0 =C2=A0int err =3D cuda_init_via();
> - =C2=A0 =C2=A0if (err) {
> - =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "cuda_init_via() failed\n");
> - =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> - =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from=
 SR */
> -
> - =C2=A0 =C2=A0return via_cuda_start();
> -#endif
> =C2=A0}
> =C2=A0#endif /* CONFIG_ADB */
>
> @@ -430,9 +436,11 @@ cuda_poll(void)
> =C2=A0 =C2=A0 /* cuda_interrupt only takes a normal lock, we disable
> =C2=A0 =C2=A0 =C2=A0* interrupts here to avoid re-entering and thus deadl=
ocking.
> =C2=A0 =C2=A0 =C2=A0*/
> - =C2=A0 =C2=A0disable_irq(cuda_irq);
> + =C2=A0 =C2=A0if (cuda_irq)
> + =C2=A0 =C2=A0 =C2=A0 disable_irq(cuda_irq);
> =C2=A0 =C2=A0 cuda_interrupt(0, NULL);
> - =C2=A0 =C2=A0enable_irq(cuda_irq);
> + =C2=A0 =C2=A0if (cuda_irq)
> + =C2=A0 =C2=A0 =C2=A0 enable_irq(cuda_irq);
> =C2=A0}
>
> =C2=A0static irqreturn_t
> @@ -446,7 +454,7 @@ cuda_interrupt(int irq, void *arg)
>
> =C2=A0 =C2=A0 spin_lock(&cuda_lock);
>
> - =C2=A0 =C2=A0/* On powermacs, this handler is registered for the VIA IR=
Q. But it uses
> + =C2=A0 =C2=A0/* On powermacs, this handler is registered for the VIA IR=
Q. But they use
> =C2=A0 =C2=A0 =C2=A0* just the shift register IRQ -- other VIA interrupt =
sources are disabled.
> =C2=A0 =C2=A0 =C2=A0* On m68k macs, the VIA IRQ sources are dispatched in=
dividually. Unless
> =C2=A0 =C2=A0 =C2=A0* we are polling, the shift register IRQ flag has alr=
eady been cleared.
> Index: linux-2.6.31/drivers/macintosh/adb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.31.orig/drivers/macintosh/adb.c =C2=A0 2009-11-17 17:07:58.=
000000000 +1100
> +++ linux-2.6.31/drivers/macintosh/adb.c =C2=A0 =C2=A0 =C2=A0 =C2=A02009-=
11-17 17:11:47.000000000 +1100
> @@ -317,9 +317,11 @@ static int __init adb_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 if ((adb_controller =3D=3D NULL) || adb_controller=
->init()) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_WARNING "W=
arning: no ADB interface detected\n");
> + =C2=A0 =C2=A0 =C2=A0 if (adb_controller !=3D NULL && adb_controller->in=
it &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adb_controller->init())
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adb_controller =3D=
 NULL;
> + =C2=A0 =C2=A0 =C2=A0 if (adb_controller =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_WARNING "W=
arning: no ADB interface detected\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0#ifdef CONFIG_PPC
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (machine_is_com=
patible("AAPL,PowerBook1998") ||
>



--=20
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
