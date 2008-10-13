Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A22C3DDDD4
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:46:06 +1100 (EST)
Subject: Re: [PATCH 7/16] xics: initialization cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <patch-xics-7@bga.com>
References: <patch-xics-7@bga.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 11:55:04 +1100
Message-Id: <1223859304.8157.207.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  static void __init xics_init_one_node(struct device_node *np,
> @@ -700,8 +694,10 @@ void __init xics_init_IRQ(void)
>  
>  	for_each_node_by_type(np, "PowerPC-External-Interrupt-Presentation") {
>  		found = 1;
> -		if (firmware_has_feature(FW_FEATURE_LPAR))
> +		if (firmware_has_feature(FW_FEATURE_LPAR)) {
> +			of_node_put(np);
>  			break;
> +			}

Little tab damage up here... no big deal.

>  		xics_init_one_node(np, &indx);
>  	}
>  	if (found == 0
