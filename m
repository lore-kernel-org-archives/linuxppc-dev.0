Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id E3C03679F9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 21:49:12 +1000 (EST)
Date: Thu, 27 Apr 2006 13:48:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 10/16] ehca: event queue
Message-ID: <20060427114828.GC32127@wohnheim.fh-wedel.de>
References: <4450A1AD.7040506@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450A1AD.7040506@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 12:49:17 +0200, Heiko J Schick wrote:
>
> +     	ret = hipz_h_alloc_resource_eq(shca->ipz_hca_handle,

Indentation?

> +				       &eq->pf,
> +				       type,
> +				       length,
> +				       &eq->ipz_eq_handle,
> +				       &eq->length,
> +				       &nr_pages, &eq->ist);
> +
> +	if (ret != H_SUCCESS) {

Common convention is to return 0 on success and -ESOMETHING on eror.
You might want to follow that and remove H_SUCCESS from the complete
code.

> +		if (!(vpage = ipz_qpageit_get_inc(&eq->ipz_queue))) {

I personally despise assignments in conditionals.  Not sure if this is
documented in CodingStyle, but IME most kernel hackers tend to dislike
it as well.

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
