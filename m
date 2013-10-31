Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07C562C03AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 13:08:39 +1100 (EST)
Message-ID: <1383185307.5117.74.camel@pasglop>
Subject: Re: [PATCH] offb: make the screen properties endian safe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Date: Thu, 31 Oct 2013 13:08:27 +1100
In-Reply-To: <1383149647-15500-1-git-send-email-clg@fr.ibm.com>
References: <1383149647-15500-1-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-30 at 17:14 +0100, Cédric Le Goater wrote:
> @@ -552,25 +552,25 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
>  	if (pp == NULL)
>  		pp = of_get_property(dp, "depth", &len);
>  	if (pp && len == sizeof(u32))
> -		depth = *pp;
> +		depth = be32_to_cpu(*pp);

This is usually written as

		depth = be32_to_cpup(pp);

It used to be that the latter generated better code but that might not
be the case anymore, however it's still a better alternative.

Cheers,
Ben.
