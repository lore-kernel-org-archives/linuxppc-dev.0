Return-Path: <bhutchings@solarflare.com>
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "WEBMAIL.SOLARFLARE.COM",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6124C2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 08:14:24 +1100 (EST)
Message-ID: <1360184912.2659.27.camel@bwh-desktop.uk.solarflarecom.com>
Subject: Re: ethtool occationally fails to communicate with with ucc_geth
From: Ben Hutchings <bhutchings@solarflare.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Wed, 6 Feb 2013 21:08:32 +0000
In-Reply-To: <20130206200504.GJ30788@csclub.uwaterloo.ca>
References: <20130206200504.GJ30788@csclub.uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-02-06 at 15:05 -0500, Lennart Sorensen wrote:
> We are occationally seeing ethtool fail to communicate with ucc_geth.
> I think I have tracked down why it happens, but I don't see a good way
> to fix it.
> 
> When the phy state changes, adjust_link() checks if the state has changed
> and if the link is up.  If it is it does:
> 
>                 if (new_state) {
>                         /*
>                          * To change the MAC configuration we need to disable
>                          * the controller. To do so, we have to either grab
>                          * ugeth->lock, which is a bad idea since 'graceful
>                          * stop' commands might take quite a while, or we can
>                          * quiesce driver's activity.
>                          */
>                         ugeth_quiesce(ugeth);
>                         ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
> 
>                         out_be32(&ug_regs->maccfg2, tempval);
>                         out_be32(&uf_regs->upsmr, upsmr);
> 
>                         ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
>                         ugeth_activate(ugeth);
>                 }
> 
> The problem I believe is that ugeth_quiesce() does netif_device_detach
> which clears __LINK_STATE_PRESENT, and hence makes dev_ethtool fail
> due to:
> 
>         if (!dev || !netif_device_present(dev))
>                 return -ENODEV;
> 
> So if ethtool happens to be run between ugeth_quiesce() and
> ugeth_activate(), it fails as if the device simply doesn't exist, which
> is of course not true, it's just temporarily disabled.
[...]
> Any suggestions?

This seems to be a workaround for a bug in phylib: phy_state_machine()
calls netif_carrier_on() before adjust_link(), so the TX scheduler can
start immediately even though the MAC has not been configured.

A better workaround would be to use netif_carrier_{off,on}() in
ugeth_{quiesce,activate}() respectively instead of
netif_device_{detach,attach}().  But I think phylib really ought to be
fixed.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
