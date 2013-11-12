Return-Path: <Shaohui.Xie@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4851E2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 23:31:03 +1100 (EST)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: "shh.xie@gmail.com" <shh.xie@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] phylib: Add Clause 45 read/write functions
Date: Tue, 12 Nov 2013 12:30:48 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C915117378@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
In-Reply-To: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Shruti Kanetkar <Shruti@freescale.com>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added more people and list.

Best Regards,=20
Shaohui Xie


> -----Original Message-----
> From: shh.xie@gmail.com [mailto:shh.xie@gmail.com]
> Sent: Monday, November 11, 2013 7:04 PM
> To: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Cc: Bucur Madalin-Cristian-B32716; Kanetkar Shruti-B44454; Xie Shaohui-B2=
1989
> Subject: [PATCH 1/4] phylib: Add Clause 45 read/write functions
>=20
> From: Andy Fleming
>=20
> You need an extra parameter to read or write Clause 45 PHYs, so we need a
> different API with the extra parameter.
>=20
> Signed-off-by: Andy Fleming
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
>  include/linux/phy.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/include/linux/phy.h b/include/linux/phy.h index 64ab823..684=
925a
> 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -498,6 +498,21 @@ static inline int phy_read(struct phy_device *phydev=
, u32
> regnum)  }
>=20
>  /**
> + * phy_read_mmd - Convenience function for reading a register
> + *   from an MMD on a given PHY.
> + * @phydev: The phy_device struct
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + *
> + * Same rules as for phy_read();
> + */
> +static inline int phy_read_mmd(struct phy_device *phydev, int devad,
> +u32 regnum) {
> +	return mdiobus_read(phydev->bus, phydev->addr,
> +		MII_ADDR_C45 | (devad << 16) | (regnum & 0xffff)); }
> +
> +/**
>   * phy_write - Convenience function for writing a given PHY register
>   * @phydev: the phy_device struct
>   * @regnum: register number to write
> @@ -533,6 +548,24 @@ static inline bool phy_is_internal(struct phy_device
> *phydev)
>  	return phydev->is_internal;
>  }
>=20
> +/**
> + * phy_write_mmd - Convenience function for writing a register
> + *   on an MMD on a given PHY.
> + * @phydev: The phy_device struct
> + * @devad: The MMD to read from
> + * @regnum: The register on the MMD to read
> + * @val: value to write to @regnum
> + *
> + * Same rules as for phy_write();
> + */
> +static inline int phy_write_mmd(struct phy_device *phydev, int devad,
> +		u32 regnum, u16 val)
> +{
> +	regnum =3D MII_ADDR_C45 | ((devad & 0x1f) << 16) | (regnum & 0xffff);
> +
> +	return mdiobus_write(phydev->bus, phydev->addr, regnum, val); }
> +
>  struct phy_device *phy_device_create(struct mii_bus *bus, int addr, int =
phy_id,
>  		bool is_c45, struct phy_c45_device_ids *c45_ids);  struct
> phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
> --
> 1.8.4.1
