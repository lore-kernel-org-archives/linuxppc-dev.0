Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from mail.csclub.uwaterloo.ca (mail.csclub.uwaterloo.ca
 [129.97.134.52]) by ozlabs.org (Postfix) with ESMTP id 909DE2C02E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 07:12:37 +1100 (EST)
From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 6 Feb 2013 15:05:04 -0500
To: Li Yang <leoli@freescale.com>
Subject: ethtool occationally fails to communicate with with ucc_geth
Message-ID: <20130206200504.GJ30788@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Len Sorensen <lsorense@csclub.uwaterloo.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are occationally seeing ethtool fail to communicate with ucc_geth.
I think I have tracked down why it happens, but I don't see a good way
to fix it.

When the phy state changes, adjust_link() checks if the state has changed
and if the link is up.  If it is it does:

                if (new_state) {
                        /*
                         * To change the MAC configuration we need to disable
                         * the controller. To do so, we have to either grab
                         * ugeth->lock, which is a bad idea since 'graceful
                         * stop' commands might take quite a while, or we can
                         * quiesce driver's activity.
                         */
                        ugeth_quiesce(ugeth);
                        ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);

                        out_be32(&ug_regs->maccfg2, tempval);
                        out_be32(&uf_regs->upsmr, upsmr);

                        ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
                        ugeth_activate(ugeth);
                }

The problem I believe is that ugeth_quiesce() does netif_device_detach
which clears __LINK_STATE_PRESENT, and hence makes dev_ethtool fail
due to:

        if (!dev || !netif_device_present(dev))
                return -ENODEV;

So if ethtool happens to be run between ugeth_quiesce() and
ugeth_activate(), it fails as if the device simply doesn't exist, which
is of course not true, it's just temporarily disabled.

I don't see any obvious way to make the ethtool requests block while the
adjust_link does it's business.  It seems that that making the device
disappear is the wrong thing to do though.

I am able to make it happen if I do:

'while ethtool ifname; do :; done' while plugging and unplugging the
cable for a few minutes.

Any suggestions?

-- 
len Sorensen
