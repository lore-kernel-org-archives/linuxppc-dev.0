Return-Path: <joakim.tjernlund@transmode.se>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 5CF631A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 18:01:02 +1000 (AEST)
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "madalin.bucur@freescale.com" <madalin.bucur@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Mon, 20 Jul 2015 07:54:30 +0000
Message-ID: <1437378870.10831.12.camel@transmode.se>
References: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> This introduces the Freescale Data Path Acceleration Architecture
> (DPAA) Ethernet driver (dpaa_eth) that builds upon the DPAA QMan,
> BMan, PAMU and FMan drivers to deliver Ethernet connectivity on
> the Freescale DPAA QorIQ platforms.
>=20
> Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
> ---
....
> +	net_dev =3D alloc_etherdev_mq(sizeof(*priv), DPAA_ETH_TX_QUEUES);
> +	if (!net_dev) {
> +		dev_err(dev, "alloc_etherdev_mq() failed\n");
> +		goto alloc_etherdev_mq_failed;
> +	}
> +
> +	snprintf(net_dev->name, IFNAMSIZ, "fm%d-mac%d",
> +		 dpa_mac_fman_index_get(pdev),
> +		 dpa_mac_hw_index_get(pdev));

Should ethernet drivers dictate interface name in user space nowadays?
I would prefer if you didn't.

I am trying these patches on a custom T1042 board using Linux 4.1 but
I cannot get Fixed PHY to work:
libphy: PHY fixed-0:00 not found
fsl_dpa dpaa-ethernet.2 eth2: Could not connect to PHY fixed-0:00
fsl_dpa dpaa-ethernet.2 eth2: init_phy() =3D -19

Not sure what I have missed here, any ideas?

 Jocke

PS.
    I would really appreciate if you could add new revisions of the FMAN/DP=
AA driver(s)
    to http://git.freescale.com/git/cgit.cgi/ppc/upstream/linux.git/
