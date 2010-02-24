Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id 259EBB7CED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 07:02:48 +1100 (EST)
Message-ID: <4B8585DE.50701@neli.hopto.org>
Date: Wed, 24 Feb 2010 21:02:38 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexb@tundra.com>
Subject: Re: [PATCH 1/7] RapidIO: Add IDT CPS/TSI switches
References: <20100224151447.GA13661@kaneng01.tundra.com>
In-Reply-To: <20100224151447.GA13661@kaneng01.tundra.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org, alexandreb@tundra.com,
	thomas.moll.ext@nsn.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> @@ -369,6 +380,10 @@ static struct rio_dev __devinit *rio_set
>  			     rdev->rswitch->switchid);
>  		rio_route_set_ops(rdev);
>  
> +		if (do_enum && rdev->rswitch->clr_table)
> +			rdev->rswitch->clr_table(port, destid, hopcount,
> +						 RIO_GLOBAL_TABLE);
> +
>  		list_add_tail(&rswitch->node, &rio_switches);
>  
>  	} else

Why clear the tables here, why not in rio_enum_peer?

> +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI572, tsi57x_route_add_entry, tsi57x_route_get_entry, tsi57x_route_clr_table);
> +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI574, tsi57x_route_add_entry, tsi57x_route_get_entry, tsi57x_route_clr_table);
> +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI577, tsi57x_route_add_entry, tsi57x_route_get_entry, tsi57x_route_clr_table);
> +DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI578, tsi57x_route_add_entry, tsi57x_route_get_entry, tsi57x_route_clr_table);

Can the 568 and 578 driver be shared? Have a 5xx driver?

Micha
