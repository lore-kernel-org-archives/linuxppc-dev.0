Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C4BC52C0085
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Sep 2012 12:48:10 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Sun, 2 Sep 2012 02:48:01 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708019E97@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2012 at 5:40 AM, Joakim Tjernlund
<Joakim.Tjernlund@transmode.se> wrote:

> -       mpc_i2c_stop(i2c);
> +       mpc_i2c_stop(i2c); /* Initiate STOP */
> +       orig_jiffies =3D jiffies;
> +       /* Wait until STOP is seen, allow up to 1 s */
> +       while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> +               if (time_after(jiffies, orig_jiffies + HZ)) {
> +                       u8 status =3D readb(i2c->base + MPC_I2C_SR);
> +
> +                       dev_dbg(i2c->dev, "timeout\n");
> +                       if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) !=
=3D 0) {
> +                               writeb(status & ~CSR_MAL,
> +                                      i2c->base + MPC_I2C_SR);
> +                               mpc_i2c_fixup(i2c);
> +                       }
> +                       return -EIO;
> +               }
> +               cond_resched();
> +       }

Shouldn't the while-loop be inside mpc_i2c_stop() itself?

--=20
Timur Tabi
Linux kernel developer at Freescale=
