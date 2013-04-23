Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C0152C0149
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 10:16:40 +1000 (EST)
Message-ID: <1366676147.2886.2.camel@pasglop>
Subject: Re: [PATCH v3 1/12] Create a powerpc update_devicetree interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 10:15:47 +1000
In-Reply-To: <517581D4.7020104@linux.vnet.ibm.com>
References: <51757951.2080007@linux.vnet.ibm.com>
 <517581D4.7020104@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-04-22 at 13:30 -0500, Nathan Fontenot wrote:

> This patch exposes a method for updating the device tree via
> ppc_md.update_devicetree that takes a single 32-bit value as a parameter.
> For pseries platforms this is the existing pseries_devicetree_update routine
> which is updated to take the new parameter which is a scope value
> to indicate the the reason for making the rtas calls. This parameter is
> required by the ibm,update-nodes/ibm,update-properties RTAS calls, and
> the appropriate value is contained within the RTAS event for PRRN
> notifications. In pseries_devicetree_update() it was previously
> hard-coded to 1, the scope value for partition migration.

I think that's too much abstraction.... (see below)

Also you add this helper:

> Index: powerpc/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/kernel/rtas.c	2013-03-08 19:23:06.000000000 -0600
> +++ powerpc/arch/powerpc/kernel/rtas.c	2013-04-17 13:02:29.000000000 -0500
> @@ -1085,3 +1085,13 @@
>  	timebase = 0;
>  	arch_spin_unlock(&timebase_lock);
>  }
> +
> +int update_devicetree(s32 scope)
> +{
> +	int rc = 0;
> +
> +	if (ppc_md.update_devicetree)
> +		rc = ppc_md.update_devicetree(scope);
> +
> +	return rc;
> +}

But then don't use it afaik (you call directly ppc_md.update_... from
prrn_work_fn().

In the end, the caller (PRRN stuff), while in rtasd, is really pseries
specific and the resulting update_device_tree() as well, so I don't
think we need the ppc_md. hook in the middle with that "oddball" scope
parameter which is not defined outside of pseries specific areas.

In this case, it might be better to make sure the PRRN related stuff in
rtasd is inside an ifdef CONFIG_PPC_PSERIES and have it call directly
into pseries_update_devicetree().

It makes the code somewhat easier to follow and I doubt anybody else
will ever use that specific hook, at least not in its current form. If
we need an abstraction later, we can add one then.

Cheers,
Ben.
