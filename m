Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C57DB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 08:57:11 +1100 (EST)
Received: by qyk34 with SMTP id 34so3688851qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 13:57:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291379651-8822-7-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
	<1291379651-8822-5-git-send-email-leoli@freescale.com>
	<1291379651-8822-6-git-send-email-leoli@freescale.com>
	<1291379651-8822-7-git-send-email-leoli@freescale.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Mon, 13 Dec 2010 15:56:36 -0600
Message-ID: <AANLkTikMSBwxeeA35RmGjE5qxG7Ymei3e3CmwT9M4mSB@mail.gmail.com>
Subject: Re: [PATCH 7/7] P2020ds: add event button handler
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 3, 2010 at 6:34 AM, Li Yang <leoli@freescale.com> wrote:
> This can be used as a wakeup source for power management.

This patch doesn't actually add wake-up support.

This patch should probably be split up, since you're adding generic
functionality for the IRQ that applies to all 85xx boards, but you
only update the device tree for one board.

> +static irqreturn_t event_isr(int irq, void *dev_id)
> +{
> +
> + =A0 =A0 =A0 printk(KERN_INFO "MPC85xxDS: Event button been pushed.\n");
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}

Would it make sense to have this be a weak function, so that it would
be easier to implement board-specific support?

> +
> +static int __init p2020ds_ngpixis_init(void)

You're adding a function called "p2020ds_ngpixis_init" to the file
"mpc85xx_ds.c".  mpc85xx_ds.c supports more than just the P2020DS.

> +{
> + =A0 =A0 =A0 int event_irq, ret;
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,p2020ds-fpg=
a");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 event_irq =3D irq_of_parse_and_map(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(event_irq, event_isr, 0=
, "event", NULL);

You should probably choose a less generic name than "event".

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Can't requ=
est board event int\n");

Use pr_err()

--=20
Timur Tabi
Linux kernel developer at Freescale
