Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Aug 2008 23:21:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] libfdt: Add support for using aliases in
	fdt_path_offset()
Message-ID: <20080814132142.GE32158@yookeroo.seuss>
References: <Pine.LNX.4.64.0808140750550.22943@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808140750550.22943@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 07:51:47AM -0500, Kumar Gala wrote:
> If the path doesn't start with '/' check to see if it matches some alias
> under "/aliases" and substitute the matching alias value in the path
> and retry the lookup.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Fixed the bug pointed out by David Gibson and added tests.

Glad you spotted it in the end :)

[snip[]
> diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
> index ebd1260..2f3ff48 100644
> --- a/libfdt/fdt_ro.c
> +++ b/libfdt/fdt_ro.c
> @@ -139,8 +139,25 @@ int fdt_path_offset(const void *fdt, const char *path)
> 
>  	FDT_CHECK_HEADER(fdt);
> 
> -	if (*path != '/')
> -		return -FDT_ERR_BADPATH;
> +	/* see if we have an alias */
> +	if (*path != '/') {
> +		const char *q;
> +		int aliasoffset = fdt_path_offset(fdt, "/aliases");
> +
> +		if (aliasoffset < 0)
> +			return -FDT_ERR_BADPATH;
> +
> +		q = strchr(path, '/');
> +		if (!q)
> +			q = end;
> +
> +		p = fdt_getprop_namelen(fdt, aliasoffset, path, q - p, NULL);
> +		if (!p)
> +			return -FDT_ERR_BADPATH;
> +		offset = fdt_path_offset(fdt, p);
> +
> +		p = q;
> +	}

Much better.  It would be quite nice to have an explicit way of
retreiving the aliases too, but I can factor that out easily enough in
a later patch.

[snip]
> --- /dev/null
> +++ b/tests/aliases.dts
> @@ -0,0 +1,31 @@
> +/dts-v1/;
> +
> +/memreserve/ 0xdeadbeef00000000 0x100000;
> +/memreserve/ 123456789 010000;

I'd drop these /memreserve/s, they're not relevant to the test.

> +
> +/ {
> +	compatible = "test_tree1";
> +	prop-int = <0xdeadbeef>;
> +	prop-str = "hello world";

Likewise the various prop-int and prop-str properties.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
