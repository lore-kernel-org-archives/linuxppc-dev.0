Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F01C7B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:39:38 +1100 (EST)
Subject: Re: [PATCH] mpc836x: fix failed phy detection for ucc ethernet on MDS
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1330345501-24949-1-git-send-email-paul.gortmaker@windriver.com>
Date: Fri, 16 Mar 2012 14:36:33 -0500
Message-Id: <329E382B-6DB2-4AC0-BC79-59296633FE9E@kernel.crashing.org>
References: <1330345501-24949-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: afleming@freescale.com, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 27, 2012, at 6:25 AM, Paul Gortmaker wrote:

> The mpc836x_mds platform has been broken since the commit
> 6fe3264945ee63292cdfb27b6e95bc52c603bb09
> 
>  "netdev/phy: Use mdiobus_read() so that proper locks are taken"
> 
> which caused the fsl_pq_mdio TBI autoprobe to oops.  The oops
> was "fixed" in commit 28d8ea2d568534026ccda3e8936f5ea1e04a86a1
> 
>  "fsl_pq_mdio: Clean up tbi address configuration"
> 
> by simply removing the the autoscan code, and making tbi nodes
> mandatory.  Some of the newer reference platforms were updated
> to have tbi nodes in 220669495bf8b68130a8218607147c7b74c28d2b
> 
>  "powerpc: Add TBI PHY node to first MDIO bus"
> 
> but the older mpc836x didn't get one and hence was just failing
> with -EBUSY as follows:
> 
> fsl-pq_mdio: probe of e0102120.mdio failed with error -16
>   ...
> net eth0: Could not attach to PHY
> eth0: Cannot initialize PHY, aborting.
> 
> Add a TBI node and use the 1st free address for it.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

applied

- k
