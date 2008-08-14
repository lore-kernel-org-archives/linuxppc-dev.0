Return-Path: <scottwood@freescale.com>
Date: Thu, 14 Aug 2008 12:43:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] libfdt: Add support for using aliases in
	fdt_path_offset()
Message-ID: <20080814174348.GA19488@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 08:28:19AM -0500, Kumar Gala wrote:
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

Can we limit the recursion depth to avoid falling off the stack if an
alias points to itself?  Or if aliases pointing to aliases are
disallowed, check for a leading '/' before recursively calling
fdt_path_offset.

-Scott
