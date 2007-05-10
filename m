Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE2D6DDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 00:35:58 +1000 (EST)
In-Reply-To: <8496f91a0705100157j6760e667w11e011b544bb7bf9@mail.gmail.com>
References: <8496f91a0705100157j6760e667w11e011b544bb7bf9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <16295789-8F7D-43C2-A027-92B3CB65946D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] phy_ethtool_{sset,gset} -- check phydev for NULL
Date: Thu, 10 May 2007 09:35:09 -0500
To: matvejchikov@gmail.com
Cc: Jeff Garzik <jeff@garzik.org>,
	"linux-ppc-embedded \(\(\(\(E-Mail\)\)\)\)" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 10, 2007, at 3:57 AM, Matvejchikov Ilya wrote:

> Good Day!
>
> The command 'brctl addbr br0 eth0' brings the kernel oops if the eth0
> has PHY, but the phydev is NULL (for ex., ifconfig eth0 0.0.0.0 was
> not issued firstly)
>
> Call Trace:
> [C02CFBD0] [7FFFFFFF] 0x7fffffff (unreliable)
> [C02CFBE0] [C0109634] dev_ethtool+0x1b0/0xfac
> [C02CFCD0] [C0155EF0] port_cost+0x5c/0x130
> [C02CFD40] [C01561FC] br_add_if+0x17c/0x308
> [C02CFD70] [C01569E0] add_del_if+0x70/0xa0
> [C02CFD90] [C0156A58] br_dev_ioctl+0x48/0x9fc
> [C02CFE10] [C0106FCC] dev_ifsioc+0x144/0x3ac
> [C02CFE30] [C01080D8] dev_ioctl+0x3b8/0x4c8
> [C02CFEB0] [C00F9BC0] sock_ioctl+0x78/0x260
> [C02CFED0] [C006889C] do_ioctl+0x38/0x84
> [C02CFEE0] [C006896C] vfs_ioctl+0x84/0x3d8
> [C02CFF10] [C0068D00] sys_ioctl+0x40/0x74
> [C02CFF40] [C000EF48] ret_from_syscall+0x0/0x38
>
> The following patch fixes the problem.
>
> Signed-off-by: Matvejchikov Ilya <matvejchikov <at> gmail.com>

while you're patch looks reasonable, this is best sent to the netdev  
list and jeff garzik as its not ppc specific at all.

- k

>
> ===================================================================
> diff -purN linux-2.6.21-clean/drivers/net/phy/phy.c
> linux-2.6.21/drivers/net/phy/phy.c
> --- linux-2.6.21-clean/drivers/net/phy/phy.c	2007-04-26  
> 07:08:32.000000000 +0400
> +++ linux-2.6.21/drivers/net/phy/phy.c	2007-05-04  
> 08:22:01.000000000 +0400
> @@ -245,6 +245,9 @@ EXPORT_SYMBOL(phy_sanitize_settings);
>   */
>   int phy_ethtool_sset(struct phy_device *phydev, struct  
> ethtool_cmd *cmd)
>  {
> +	if (unlikely(NULL == phydev))
> +		return -EINVAL;

Would -ENODEV; make more sense?

> +
>   	if (cmd->phy_address != phydev->addr)
>   		return -EINVAL;
>
> @@ -289,6 +292,9 @@ EXPORT_SYMBOL(phy_ethtool_sset);
>
>   int phy_ethtool_gset(struct phy_device *phydev, struct  
> ethtool_cmd *cmd)
>  {
> +	if (unlikely(NULL == phydev))
> +		return -EINVAL;
> +

Would -ENODEV; make more sense?


>   	cmd->supported = phydev->supported;
>
>   	cmd->advertising = phydev->advertising;
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
