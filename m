Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17910.12015.508991.966593@cargo.ozlabs.ibm.com>
Date: Tue, 13 Mar 2007 15:56:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
In-Reply-To: <200703122254.27087.sr@denx.de>
References: <200703122254.27087.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese writes:

> +config PPC_PAGE_SHIFT
> +	int "Page size (12=>4KB; 16=>64KB)"
> +	default "12"
> +	range 12 16
> +	help
> +	  The PAGE_SIZE definition. Increasing the page size may 
> +	  improve the system performance in some dedicated cases.
> +
> +	  If unsure, set it to 12 (4KB).

[snip]

> +#else
> +#error "Unsupported PAGE_SIZE"
> +#endif

If you only support 4k and 64k page sizes, why do you let the user
choose 13, 14 or 15 for PPC_PAGE_SHIFT?  Why not just have a "64k
pages" boolean option like 64-bit powerpc does?

Paul.
