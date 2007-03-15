Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id CA3AADDE19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 00:24:53 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so288334ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 06:24:51 -0700 (PDT)
Message-ID: <528646bc0703150624i2bac5ce4n7beebc88d8acbafe@mail.gmail.com>
Date: Thu, 15 Mar 2007 07:24:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 3/5] mpc52xx suspend: USB
In-Reply-To: <20070315104228.GD22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104228.GD22215@moe.telargo.com>
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

On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Trivial suspend and resume OF OHCI.
> On MPC52xx turn off and on power to ports.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Nak; see below

>
> Index: grant.git/drivers/usb/host/ohci-ppc-of.c
> ===================================================================
> --- grant.git.orig/drivers/usb/host/ohci-ppc-of.c
> +++ grant.git/drivers/usb/host/ohci-ppc-of.c
> @@ -214,6 +214,32 @@ MODULE_DEVICE_TABLE(of, ohci_hcd_ppc_of_
>  #endif
>
>
> +#ifdef CONFIG_PM
> +static u32 descr_a;
> +static int ohci_hcd_ppc_soc_drv_suspend(struct of_device *op,
> +               pm_message_t state)
> +{
> +       struct usb_hcd *hcd = dev_get_drvdata(&op->dev);
> +#ifdef CONFIG_PPC_MPC52xx
> +       struct ohci_hcd *ohci = hcd_to_ohci(hcd);
> +
> +       descr_a = in_be32(&ohci->regs->roothub.a);
> +       out_be32(&ohci->regs->roothub.a, (descr_a & ~0x200) | 0x100);
> +#endif
> +       return 0;
> +}

#ifdef blocks are a bad idea.  It is now possible to boot one kernel
image on multiple platforms.  Chip model should be determined ahead of
time from the device tree and choose the code path accordingly at
runtime.



-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
