Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47054DDE38
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:06:39 +1000 (EST)
Date: Sat, 29 Sep 2007 00:06:21 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
Message-ID: <20070929000621.2d332e86@kernel.crashing.org>
In-Reply-To: <20070928190616.GB20213@loki.buserror.net>
References: <20070928190616.GB20213@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Scott,

Looks good, only one note:

On Fri, 28 Sep 2007 14:06:16 -0500
Scott Wood wrote:

> +	im_dprambase = cpm2_immr->im_dprambase;
> +
>  	/* Attach the usable dpmem area */
>  	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
>  	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
>  	 * varies with the processor and the microcode patches activated.
>  	 * But the following should be at least safe.
>  	 */
> -	rh_attach_region(&cpm_dpmem_info, 0, r.end - r.start + 1);
> +	rh_attach_region(&cpm_dpmem_info, CPM_MAP_ADDR + CPM_DATAONLY_BASE,
> +	                 CPM_DATAONLY_SIZE);
>  }
>  
Can we have something to address upper comment? I mean,any way to have dpram beginning and size encoded in the device tree? We seem to be adding new bus, and still pulling the information from the defines. Maybe I miss something
here, but it looks a bit odd.

-- 
Sincerely, Vitaly
