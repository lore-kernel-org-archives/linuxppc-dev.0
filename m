Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jul 2007 12:11:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/15] boot: record header bytes in gunzip_start
Message-ID: <20070719021138.GE20458@localhost.localdomain>
References: <boot-6-00.miltonm@bga.com> <boot-6-02.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-6-02.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 05:08:05PM -0500, Milton Miller wrote:
> 
> Record the number of header bytes skipped in the total bytes read field.
> 
> This is needed for the initramfs parsing code to find the end of the zip file.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Ok... I assume you've checked that this is actually the correct
semantics for that field of the zlib structure?

> Index: work.git/arch/powerpc/boot/gunzip_util.c
> ===================================================================
> --- work.git.orig/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:44:41.000000000 -0500
> +++ work.git/arch/powerpc/boot/gunzip_util.c	2007-07-10 03:47:35.000000000 -0500
> @@ -78,6 +78,7 @@ void gunzip_start(struct gunzip_state *s
>  			fatal("inflateInit2 returned %d\n\r", r);
>  	}
>  
> +	state->s.total_in = hdrlen;
>  	state->s.next_in = src + hdrlen;
>  	state->s.avail_in = srclen - hdrlen;
>  }
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
