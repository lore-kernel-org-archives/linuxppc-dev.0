Return-Path: <pku.leo@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 92BE0B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 15:24:43 +1100 (EST)
Received: by iye19 with SMTP id 19so122176iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Dec 2010 20:24:41 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <AANLkTikMSBwxeeA35RmGjE5qxG7Ymei3e3CmwT9M4mSB@mail.gmail.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
	<1291379651-8822-5-git-send-email-leoli@freescale.com>
	<1291379651-8822-6-git-send-email-leoli@freescale.com>
	<1291379651-8822-7-git-send-email-leoli@freescale.com>
	<AANLkTikMSBwxeeA35RmGjE5qxG7Ymei3e3CmwT9M4mSB@mail.gmail.com>
Date: Tue, 14 Dec 2010 12:24:41 +0800
Message-ID: <AANLkTimFpONZzSBjXJmDsX2-iYH+YgY_sANYtYq2j5x1@mail.gmail.com>
Subject: Re: [PATCH 7/7] P2020ds: add event button handler
From: Li Yang <leoli@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 14, 2010 at 5:56 AM, Timur Tabi <timur.tabi@gmail.com> wrote:
> On Fri, Dec 3, 2010 at 6:34 AM, Li Yang <leoli@freescale.com> wrote:
>> This can be used as a wakeup source for power management.
>
> This patch doesn't actually add wake-up support.

Any enabled IRQ is a valid wake-up source for standby.  The patch
enables a board specific interrupt for the purpose of wakeup.

>
> This patch should probably be split up, since you're adding generic
> functionality for the IRQ that applies to all 85xx boards, but you
> only update the device tree for one board.

The IRQ is a board specific one from GPIO which not applicable on all
85xx boards.

>
>> +static irqreturn_t event_isr(int irq, void *dev_id)
>> +{
>> +
>> + =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "MPC85xxDS: Event button been pu=
shed.\n");
>> + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
>> +}
>
> Would it make sense to have this be a weak function, so that it would
> be easier to implement board-specific support?

It's already a board-specific one.

>
>> +
>> +static int __init p2020ds_ngpixis_init(void)
>
> You're adding a function called "p2020ds_ngpixis_init" to the file
> "mpc85xx_ds.c". =C2=A0mpc85xx_ds.c supports more than just the P2020DS.

I'm not sure if other DS boards covered by this file has the same functiona=
lity.

>
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 int event_irq, ret;
>> + =C2=A0 =C2=A0 =C2=A0 struct device_node *np;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,p=
2020ds-fpga");
>> + =C2=A0 =C2=A0 =C2=A0 if (np) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_irq =3D irq_of_=
parse_and_map(np, 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D request_irq(e=
vent_irq, event_isr, 0, "event", NULL);
>
> You should probably choose a less generic name than "event".

Well, it's the name suggested by the board manual.  We may change it
to "event_button" if not too long.

- Leo
