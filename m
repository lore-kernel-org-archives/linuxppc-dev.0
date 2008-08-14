Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Aug 2008 14:15:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] libfdt: Add support for using aliases in fdt_path_offset()
Message-ID: <20080814041557.GE18344@yookeroo.seuss>
References: <Pine.LNX.4.64.0808132251340.29599@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808132251340.29599@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 13, 2008 at 10:52:26PM -0500, Kumar Gala wrote:
> If the path doesn't start with '/' check to see if it matches some alias
> under "/aliases" and substitute the matching alias value in the path
> and retry the lookup.

Kumar, this is broken.  If you match an alias you only follow the path
one level down from there.  i.e. you will correctly resolve
'somealias' and 'somealias/foo', but not 'somealias/foo/bar'.  

> diff --git a/libfdt/fdt_ro.c b/libfdt/fdt_ro.c
> index ebd1260..74b8153 100644
> --- a/libfdt/fdt_ro.c
> +++ b/libfdt/fdt_ro.c
> @@ -139,8 +139,29 @@ int fdt_path_offset(const void *fdt, const char *path)
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
> +
> +		aliasoffset = fdt_path_offset(fdt, p);

You should set 'offset' here instead of 'aliasoffset'..

> +		if (*q == '\0')
> +			return aliasoffset;
> +
> +		q++;
> +		return fdt_subnode_offset(fdt, aliasoffset, q);
> +	}

..drop the rest of this if block..
> 
>  	while (*p) {
>  		const char *q;

..and then the loop that's already here will follow the remaining path
components starting from the node that's the target of the alias.

Plus you need a testcase or three.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
