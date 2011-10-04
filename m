Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 678D1B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Oct 2011 20:25:20 +1100 (EST)
Received: by wyg36 with SMTP id 36so290258wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 04 Oct 2011 02:25:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE0145F8@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE0145F8@HYD-MKD-MBX4.wipro.com>
Date: Tue, 4 Oct 2011 14:55:10 +0530
Message-ID: <CAGn8SbzOMPsUgUVsAc_qnosuT8qkznxpgdC4rjtZ56Avk-X7EA@mail.gmail.com>
Subject: Re: Request_irq fails for IRQ2
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: smitha.vanga@wipro.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Smitha,

Do you have the entry of this device node in your DTS file?
if yes, then is the device is getting registered properly?

If you are writing platform driver then you can use 'platform_get_irq'
it returns the irq number,
which you can pass in the 'request_irq'. If it is a simple character
driver then to determine the
virtual irq number you can use 'ioremap', in this call you can pass
the HW IRQ number e.g. 20
and then pass in the 'request_irq'.

But in both cases you have to have this device node in your device
tree and should be registered,
otherwise it should be returning error and no virtual irq will be allocated=
.

As per your return value it seems the device node is not getting
registered, perhaps the entry is
missing in DTS file. Try with just ioremap and see if virtual irq is
returned properly.

Kind Regards,
Vijay Nikam

On Mon, Oct 3, 2011 at 7:57 PM,  <smitha.vanga@wipro.com> wrote:
>
> Hi Scott,
>
> I try to request an IRQ (IRQ2 and IRQ3 which are ineterrupt no 20 and 21 =
in
> mpc8247)in my driver . The
> Call fails in setup_irq in Manage.c at /kernel/irq.
>
> Setup _irq returns -ENOSYS
>
> if (desc->irq_data.chip =3D=3D &no_irq_chip)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOSYS;
>
>
> I found that I need to pass the virtual interrupt number instead of hardw=
are
> interrupt number.
> So I added below piece of code
>
> Below is the call to request irq in my driver.
>
> virq =3D irq_create_mapping(NULL, CPLD1_INTERRUPT);
>
>
>
>
> =A0=A0 if ((ret =3D request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PATH,
> NULL))!=3D0)
> =A0=A0 {
> =A0=A0=A0=A0=A0 printk(KERN_ERR "gpio_init: Could not grab IRQ line for C=
PLD ret =3D
> %d\n",ret);
> =A0=A0=A0=A0=A0=A0=A0 =A0 goto err1;
> =A0=A0 }
>
>
> Now it fails in irq_create_mapping=A0=A0 with NO_IRQ error.
>
> if (controller =3D=3D NULL)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host =3D irq_default_host;
> else
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 host =3D irq_find_host(cont=
roller);
> if (host =3D=3D NULL) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_WARNING "irq: n=
o irq host found for %s !\n",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0 controll=
er->full_name);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NO_IRQ;
> =A0=A0=A0=A0=A0=A0=A0 }
>
>
> I just don't know what I should pass for host , also when I pass NULL for
> host . I see the default host is NULL..
> Could you please help me. My project delivery is near , I need=A0 help so=
on.
>
>
> Regards,
> Smitha
>
>
>
> Please do not print this email unless it is absolutely necessary.
>
> The information contained in this electronic message and any attachments =
to
> this message are intended for the exclusive use of the addressee(s) and m=
ay
> contain proprietary, confidential or privileged information. If you are n=
ot
> the intended recipient, you should not disseminate, distribute or copy th=
is
> e-mail. Please notify the sender immediately and destroy all copies of th=
is
> message and any attachments.
>
> WARNING: Computer viruses can be transmitted via email. The recipient sho=
uld
> check this email and any attachments for the presence of viruses. The
> company accepts no liability for any damage caused by any virus transmitt=
ed
> by this email.
>
> www.wipro.com
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
