Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94665DE08B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 16:49:55 +1100 (EST)
Subject: Re: [PATCH] powerpc/pseries failed reconfig notifier chain call
	cleanup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <49B02DB5.7020301@austin.ibm.com>
References: <49B02DB5.7020301@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 16:47:47 +1100
Message-Id: <1236750467.7086.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-03-05 at 13:53 -0600, Nathan Fontenot wrote:
> The return code from invoking the notifier chain when updating the
> ibm,dynamic-memory property is not handled properly. In failure
> cases (rc == NOTIFY_BAD) we should be restoring the original value
> of the property.  In success (rc == NOTIFY_OK) we should be returning
> zero from the calling routine.

This is actually not clear to me ... if the memory has been added or
removed, we must make sure the device-tree is up to date... ie, we can't
tell the firmware that we failed can we ?

Ben.

> Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/reconfig.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/powerpc/platforms/pseries/reconfig.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/pseries/reconfig.c	2008-10-23 22:29:24.000000000 -0500
> +++ linux-2.6/arch/powerpc/platforms/pseries/reconfig.c	2009-03-05 13:20:00.000000000 -0600
> @@ -468,9 +468,13 @@
>  
>  		rc = blocking_notifier_call_chain(&pSeries_reconfig_chain,
>  						  action, value);
> +		if (rc == NOTIFY_BAD) {
> +			rc = prom_update_property(np, oldprop, newprop);
> +			return -ENOMEM;
> +		}
>  	}
>  
> -	return rc;
> +	return 0;
>  }
>  
>  /**
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
