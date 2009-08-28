Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f211.google.com (mail-gx0-f211.google.com
	[209.85.217.211])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E261FB7B7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 00:10:37 +1000 (EST)
Received: by gxk7 with SMTP id 7so2840628gxk.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 07:10:35 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <6E9D235B18CE694399D781F05D9C42E79F0C2F04@SI-MBX11.de.bosch.com>
References: <6E9D235B18CE694399D781F05D9C42E79F0C2C12@SI-MBX11.de.bosch.com>
	<20090827131151.537EC833DBD2@gemini.denx.de>
	<6E9D235B18CE694399D781F05D9C42E79F0C2F04@SI-MBX11.de.bosch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 28 Aug 2009 08:10:15 -0600
Message-ID: <fa686aa40908280710h4237f6e4s47097399a9415cd7@mail.gmail.com>
Subject: Re: LITE5200 configuration
To: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 27, 2009 at 8:14 AM, FIXED-TERM Seeh Thomas
(BEG/EMS1)<fixed-term.Thomas.Seeh@de.bosch.com> wrote:
> ------snip---------
> [ 2346.499181] VFS: Mounted root (nfs filesystem) on device 0:11.
> [ 2346.505748] Freeing unused kernel memory: 160k init
> [ 2346.865420] net eth0: FEC_IEVENT_RFIFO_ERROR
> [ 2346.871668] ------------[ cut here ]------------
> [ 2346.876434] Kernel BUG at c01ae1d0 [verbose debug info unavailable]
[...]
> Anyone an idea, what I do wrong?

Looks like an Ethernet driver problem which has been seen before.  Try
the following patch.  Also, you should enable CONFIG_KALLSYMS so that
your traceback actually shows function names.

Cheers,
g.


diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
index cc78633..6d1afb6 100644
--- a/drivers/net/fec_mpc52xx.c
+++ b/drivers/net/fec_mpc52xx.c
@@ -758,12 +758,6 @@ static void mpc52xx_fec_reset(struct net_device *dev)

        mpc52xx_fec_hw_init(dev);

-       if (priv->phydev) {
-               phy_stop(priv->phydev);
-               phy_write(priv->phydev, MII_BMCR, BMCR_RESET);
-               phy_start(priv->phydev);
-       }
-
        bcom_fec_rx_reset(priv->rx_dmatsk);
        bcom_fec_tx_reset(priv->tx_dmatsk);

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
