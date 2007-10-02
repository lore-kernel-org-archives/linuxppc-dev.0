Return-Path: <eha@doredevelopment.dk>
Received: from bq8.dotserv.com (bq8.dotserv.com [193.201.35.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8BC4DDED5
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 17:10:26 +1000 (EST)
From: "Esben Haabendal" <eha@doredevelopment.dk>
To: "'Scott Wood'" <scottwood@freescale.com>
References: <20070920220043.GA28769@loki.buserror.net>
	<20070920220121.GF28784@loki.buserror.net>
In-Reply-To: <20070920220121.GF28784@loki.buserror.net>
Subject: RE: [PATCH 6/9] fs_enet: Be an of_platform device
	when	CONFIG_PPC_CPM_NEW_BINDING is set.
Date: Tue, 2 Oct 2007 09:10:05 +0200
Message-ID: <003601c804c3$4556f640$d004e2c0$@dk>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

A minor error handling bug

> +	const u32 *data = of_get_property(np, "phy-handle", &len);
> +	if (!data || len != 4)
> +		return -EINVAL;
> +
> +	phynode = of_find_node_by_phandle(*data);
> +	if (!phynode)
> +		return -EINVAL;
> +
> +	mdionode = of_get_parent(phynode);
> +	if (!phynode)

if (!mdionode)

> +		goto out_put_phy;

Best regards,
Esben
