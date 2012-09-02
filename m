Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AEA492C008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2012 00:22:06 +1000 (EST)
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B708019E97@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <6AE080B68D46FC4BA2D2769E68D765B708019E97@039-SN2MPN1-022.039d.mgd.msft.net>
Subject: Re: [PATCH] i2c-mpc: Wait for STOP to hit the bus
To: Tabi Timur-B04825 <B04825@freescale.com>
Message-ID: <OF0ACFB3FB.F2667AE9-ONC1257A6D.004E0ADE-C1257A6D.004EEB75@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 2 Sep 2012 16:22:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
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

Tabi Timur-B04825 <B04825@freescale.com> wrote on 2012/09/02 04:48:01:
> On Thu, Aug 30, 2012 at 5:40 AM, Joakim Tjernlund
> <Joakim.Tjernlund@transmode.se> wrote:
>
> > -       mpc_i2c_stop(i2c);
> > +       mpc_i2c_stop(i2c); /* Initiate STOP */
> > +       orig_jiffies = jiffies;
> > +       /* Wait until STOP is seen, allow up to 1 s */
> > +       while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
> > +               if (time_after(jiffies, orig_jiffies + HZ)) {
> > +                       u8 status = readb(i2c->base + MPC_I2C_SR);
> > +
> > +                       dev_dbg(i2c->dev, "timeout\n");
> > +                       if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) != 0) {
> > +                               writeb(status & ~CSR_MAL,
> > +                                      i2c->base + MPC_I2C_SR);
> > +                               mpc_i2c_fixup(i2c);
> > +                       }
> > +                       return -EIO;
> > +               }
> > +               cond_resched();
> > +       }
>
> Shouldn't the while-loop be inside mpc_i2c_stop() itself?

Possibly but I choosed to do it this way as there is a similar loop in the beginning of mpc_xfer().
I figured it has better visibility if it is in the same function.

 Jocke
