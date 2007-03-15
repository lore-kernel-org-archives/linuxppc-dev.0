Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 7E7FFDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 00:35:12 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so291600ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 06:35:08 -0700 (PDT)
Message-ID: <528646bc0703150635g6b4c50c3g7df35dc62885c187@mail.gmail.com>
Date: Thu, 15 Mar 2007 07:35:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 2/5] mpc52xx suspend: FEC (ethernet)
In-Reply-To: <20070315104158.GC22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104158.GC22215@moe.telargo.com>
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
> Suspend and resume for FEC on MPC52xx.
>
> Note that resume is a bit different for lite5200b low-power mode.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

This of course cannot be applied until a mpc5200 ethernet driver is
actually in mainline.  :-)

Haven't tested, but I don't see anything evil here, other than the
"ugly hack"  :-)

g.

> +int mpc52xx_fec_resume(struct of_device *op)
> +{
> +       struct net_device *ndev = dev_get_drvdata(&op->dev);
> +       struct fec_priv *priv = ndev->priv;
> +       struct mpc52xx_fec *fec = priv->fec;
> +
> +       /* XXX ugly hack */
> +       /* not deep-sleep (but low-power), so re-init hw */
> +       if (*(unsigned long *)CONFIG_KERNEL_START != 0x60000000) {
> +               *(unsigned long *)CONFIG_KERNEL_START = 0x60000000; // restore

Please avoid c++ style comments; even within ugly hacks.  :-)

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
