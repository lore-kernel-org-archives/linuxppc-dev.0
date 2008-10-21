Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 532C5DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 10:33:10 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2478180rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 16:33:09 -0700 (PDT)
Date: Tue, 21 Oct 2008 17:33:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: [PATCH] powerpc: Add del_node function to allow early boot
	code to prune inapplicable devices.
Message-ID: <20081021233306.GA2108@secretlab.ca>
References: <48F7E1E6.4040701@consentry.com>
	<20081017012604.GA22213@yookeroo.seuss> <48FE4A6D.5@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48FE4A6D.5@consentry.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 21, 2008 at 02:32:29PM -0700, Mike Ditto wrote:
> Reposting in proper format...
> 
> Some platforms have variants that can share most of a flat device tree but need
> a few devices selectively pruned at boot time.  This adds del_node() to ops.h
> to allow access to the existing fdt_del_node().
> 
> Signed-off-by: Mike Ditto <mditto@consentry.com>

Looks good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> 
> Index: arch/powerpc/boot/ops.h
> ===================================================================
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 ops.h
> --- arch/powerpc/boot/ops.h	11 Oct 2008 02:51:35 -0000	1.1.1.1
> +++ arch/powerpc/boot/ops.h	18 Oct 2008 02:06:45 -0000
> @@ -40,6 +40,7 @@
>  			const int buflen);
>  	int	(*setprop)(const void *phandle, const char *name,
>  			const void *buf, const int buflen);
> +	int (*del_node)(const void *phandle);
>  	void *(*get_parent)(const void *phandle);
>  	/* The node must not already exist. */
>  	void *(*create_node)(const void *parent, const char *name);
> @@ -124,6 +125,11 @@
>  		return dt_ops.setprop(devp, name, buf, strlen(buf) + 1);
> 
>  	return -1;
> +}
> +
> +static inline int del_node(const void *devp)
> +{
> +	return dt_ops.del_node ? dt_ops.del_node(devp) : -1;
>  }
> 
>  static inline void *get_parent(const char *devp)
> Index: arch/powerpc/boot/libfdt-wrapper.c
> ===================================================================
> retrieving revision 1.1.1.1
> diff -u -r1.1.1.1 libfdt-wrapper.c
> --- arch/powerpc/boot/libfdt-wrapper.c	11 Oct 2008 02:51:35 -0000	1.1.1.1
> +++ arch/powerpc/boot/libfdt-wrapper.c	17 Oct 2008 22:08:44 -0000
> @@ -105,6 +105,11 @@
>  	return check_err(rc);
>  }
> 
> +static int fdt_wrapper_del_node(const void *devp)
> +{
> +	return fdt_del_node(fdt, devp_offset(devp));
> +}
> +
>  static void *fdt_wrapper_get_parent(const void *devp)
>  {
>  	return offset_devp(fdt_parent_offset(fdt, devp_offset(devp)));
> @@ -173,6 +178,7 @@
>  	dt_ops.create_node = fdt_wrapper_create_node;
>  	dt_ops.find_node_by_prop_value = fdt_wrapper_find_node_by_prop_value;
>  	dt_ops.find_node_by_compatible = fdt_wrapper_find_node_by_compatible;
> +	dt_ops.del_node = fdt_wrapper_del_node;
>  	dt_ops.get_path = fdt_wrapper_get_path;
>  	dt_ops.finalize = fdt_wrapper_finalize;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
