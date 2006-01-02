Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7556A688EE
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jan 2006 00:15:46 +1100 (EST)
Date: Mon, 2 Jan 2006 14:15:40 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20060102131539.GA12434@suse.de>
References: <1134457283.6989.185.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1134457283.6989.185.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: Remove device_node addrs/n_addr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Dec 13, Benjamin Herrenschmidt wrote:

> The pre-parsed addrs/n_addrs fields in struct device_node are finally
> gone. Remove the dodgy heuristics that did that parsing at boot and
> remove the fields themselves since we now have a good replacement with
> the new OF parsing code. This patch also fixes a bunch of drivers to use
> the new code instead, so that at least pmac32, pseries, iseries and g5
> defconfigs build.

> +++ linux-work/include/asm-powerpc/prom.h	2005-12-13 17:51:20.000000000 +1100

> @@ -120,8 +82,6 @@ struct device_node {
>  	char	*type;
>  	phandle	node;
>  	phandle linux_phandle;
> -	int	n_addrs;
> -	struct	address_range *addrs;
>  	int	n_intrs;
>  	struct	interrupt_info *intrs;
>  	char	*full_name;

Is this patch supposed to be complete? I will find references to n_addrs
in arch/powerpc:

hydra_init, chrp_find_bridges, chrp_find_openpic, comment in
of_finish_dynamic_node.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
