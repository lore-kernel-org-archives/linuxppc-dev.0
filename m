Return-Path: <nenolod@atheme.org>
Received: from osiris.atheme.org (osiris.atheme.org [69.60.119.211])
	by ozlabs.org (Postfix) with ESMTP id 364C4DDE3A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 23:08:04 +1000 (EST)
Date: Thu, 5 Apr 2007 08:45:27 -0400 (EDT)
From: William Pitcock <nenolod@atheme.org>
To: Tony Vroon <chainsaw@gentoo.org>
Subject: Re: [PATCH 2.6.22] [resend] Allow PMU LED control on PowerMac 7, 2
	and 7, 3
In-Reply-To: <20070318201110.181165B80F1@ganymede.vroon.org>
Message-ID: <Pine.LNX.4.64.0704050843440.27254@osiris.atheme.org>
References: <20070318201110.181165B80F1@ganymede.vroon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

This patch also works on PowerMac3,5. It is also confirmed to work on the 
iMac "Flower Power" model, but I do not have the specific model ID for 
that on me at the moment.

William

On Sun, 18 Mar 2007, Tony Vroon wrote:

> The previous patch was not the correct file and would not have compiled. Apologies.
>
> This allows the PMU LED on both a PowerMac 7,2 (Dual G5 2.0GHz, June 2003)
> and a PowerMac 7,3 (Dual G5 2.0GHz, June 2004) to be controlled.
> The physical LED is never off, unlike an iBook/PowerBook LED.
> It is rather dim ("off") or very bright ("on").
> A patch to add a LED trigger to the libata core has been sent to Jeff Garzik.
>
> Signed-off-by: Tony Vroon <chainsaw@gentoo.org>
>
> --- linux-2.6/drivers/macintosh/via-pmu-led.c.orig	2007-03-09 22:38:31.000000000 +0000
> +++ linux-2.6/drivers/macintosh/via-pmu-led.c	2007-03-18 19:46:27.000000000 +0000
> @@ -124,7 +124,9 @@
> 	if (model == NULL)
> 		return -ENODEV;
> 	if (strncmp(model, "PowerBook", strlen("PowerBook")) != 0 &&
> -	    strncmp(model, "iBook", strlen("iBook")) != 0) {
> +	    strncmp(model, "iBook", strlen("iBook")) != 0 &&
> +	    strncmp(model, "PowerMac7,2", strlen("PowerMac7,2")) != 0 &&
> +	    strncmp(model, "PowerMac7,3", strlen("PowerMac7,3")) != 0) {
> 		of_node_put(dt);
> 		/* ignore */
> 		return -ENODEV;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
