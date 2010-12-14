Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f171.google.com (mail-gx0-f171.google.com
	[209.85.161.171]) by ozlabs.org (Postfix) with ESMTP id 7D1E9B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Dec 2010 03:49:42 +1100 (EST)
Received: by gxk8 with SMTP id 8so530515gxk.16
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Dec 2010 08:49:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimFpONZzSBjXJmDsX2-iYH+YgY_sANYtYq2j5x1@mail.gmail.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
	<1291379651-8822-5-git-send-email-leoli@freescale.com>
	<1291379651-8822-6-git-send-email-leoli@freescale.com>
	<1291379651-8822-7-git-send-email-leoli@freescale.com>
	<AANLkTikMSBwxeeA35RmGjE5qxG7Ymei3e3CmwT9M4mSB@mail.gmail.com>
	<AANLkTimFpONZzSBjXJmDsX2-iYH+YgY_sANYtYq2j5x1@mail.gmail.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 14 Dec 2010 10:49:09 -0600
Message-ID: <AANLkTimJSp8X+zO8_z8JiA1w3CGacCgKTMxpRNUMT=DZ@mail.gmail.com>
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

On Mon, Dec 13, 2010 at 10:24 PM, Li Yang <leoli@freescale.com> wrote:

> Any enabled IRQ is a valid wake-up source for standby. =A0The patch
> enables a board specific interrupt for the purpose of wakeup.

Oh, right.  I should have realized that.

>> This patch should probably be split up, since you're adding generic
>> functionality for the IRQ that applies to all 85xx boards, but you
>> only update the device tree for one board.
>
> The IRQ is a board specific one from GPIO which not applicable on all
> 85xx boards.

Doesn't the device tree take care of that?  If the node exists, the
IRQ number is specified.  Otherwise, the feature is not enabled.

>>> +static irqreturn_t event_isr(int irq, void *dev_id)
>>> +{
>>> +
>>> + =A0 =A0 =A0 printk(KERN_INFO "MPC85xxDS: Event button been pushed.\n"=
);
>>> + =A0 =A0 =A0 return IRQ_HANDLED;
>>> +}
>>
>> Would it make sense to have this be a weak function, so that it would
>> be easier to implement board-specific support?
>
> It's already a board-specific one.

Hmmm.... I guess technically it is, but I wonder if it should be.

>>> +
>>> +static int __init p2020ds_ngpixis_init(void)
>>
>> You're adding a function called "p2020ds_ngpixis_init" to the file
>> "mpc85xx_ds.c". =A0mpc85xx_ds.c supports more than just the P2020DS.
>
> I'm not sure if other DS boards covered by this file has the same functio=
nality.

Well, either it does or it doesn't, but you can't add a p2020-specific
function to mpc85xx_ds.c.  You should just rename the function,
because I see no reason why it can't work on other DS boards.

The problem is the compatible string.  Each pixis implementation is
different, but they share several common traits.  I wonder if we need
to have a generic compatible string for the FPGA node.

>> You should probably choose a less generic name than "event".
>
> Well, it's the name suggested by the board manual. =A0We may change it
> to "event_button" if not too long.

I was thinking something like "fsl-fpga-event".

--=20
Timur Tabi
Linux kernel developer at Freescale
