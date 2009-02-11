Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.tu-cottbus.de
	[141.43.120.68]) by ozlabs.org (Postfix) with ESMTP id 30674DDDB5
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 01:43:19 +1100 (EST)
Message-ID: <4992DD86.1030607@s5r6.in-berlin.de>
Date: Wed, 11 Feb 2009 15:15:34 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH] ehea: Fix: Remove adapter from adapter list in error path
References: <200902111329.02954.hannes.hering@linux.vnet.ibm.com>
In-Reply-To: <200902111329.02954.hannes.hering@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: jeff@garzik.org, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> Remove adapter from adapter list before freeing data structure in error path.
...
> --- linux-2.6.29-rc4/drivers/net/ehea/ehea_main.c	2009-02-11 13:13:47.812542928 +0100
> +++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-02-11 13:14:04.197540184 +0100
> @@ -3448,6 +3448,7 @@ out_kill_eq:
>  	ehea_destroy_eq(adapter->neq);
>  
>  out_free_ad:
> +	list_del(&adapter->list);
>  	kfree(adapter);
>  
>  out:

On a related note, ehea_set_mac_addr()/ehea_update_bcmc_registrations()
accesses adapter_list without serialization by ehea_fw_handles.lock and
thus apparently unsafely.

There may be other unsafe accesses of adapter_list; that's just the
first one which I spotted.
-- 
Stefan Richter
-=====-==--= --=- -=-==
http://arcgraph.de/sr/
