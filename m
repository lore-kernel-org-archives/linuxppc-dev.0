Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 89E30DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 10:41:47 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2480898rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:41:46 -0700 (PDT)
Message-ID: <9e4733910810211641x24f4d76bn5bc614147875d250@mail.gmail.com>
Date: Tue, 21 Oct 2008 19:41:45 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	"Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Implement polling for 5200FEC to make netconsole work.
In-Reply-To: <20081018214059.1506.28013.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20081018214059.1506.28013.stgit@terra>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is anyone going to pick this up?

On Sat, Oct 18, 2008 at 5:40 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Implement polling for 5200FEC to make netconsole work. Tested on Phytec pcm030 and Efika.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
>  drivers/net/fec_mpc52xx.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index 4e4f683..aec3b97 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -401,6 +401,21 @@ static int mpc52xx_fec_hard_start_xmit(struct sk_buff *skb, struct net_device *d
>        return 0;
>  }
>
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +static void mpc52xx_fec_poll_controller(struct net_device *dev)
> +{
> +       struct mpc52xx_fec_priv *priv = netdev_priv(dev);
> +
> +       disable_irq(priv->t_irq);
> +       mpc52xx_fec_tx_interrupt(priv->t_irq, dev);
> +       enable_irq(priv->t_irq);
> +       disable_irq(priv->r_irq);
> +       mpc52xx_fec_rx_interrupt(priv->r_irq, dev);
> +       enable_irq(priv->r_irq);
> +}
> +#endif
> +
> +
>  /* This handles BestComm transmit task interrupts
>  */
>  static irqreturn_t mpc52xx_fec_tx_interrupt(int irq, void *dev_id)
> @@ -926,6 +941,9 @@ mpc52xx_fec_probe(struct of_device *op, const struct of_device_id *match)
>        ndev->tx_timeout        = mpc52xx_fec_tx_timeout;
>        ndev->watchdog_timeo    = FEC_WATCHDOG_TIMEOUT;
>        ndev->base_addr         = mem.start;
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +       ndev->poll_controller = mpc52xx_fec_poll_controller;
> +#endif
>
>        priv->t_irq = priv->r_irq = ndev->irq = NO_IRQ; /* IRQ are free for now */
>
>
>



-- 
Jon Smirl
jonsmirl@gmail.com
