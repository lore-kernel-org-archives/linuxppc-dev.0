Return-Path: <dgibson@ozlabs.org>
Date: Thu, 19 Jul 2007 15:02:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 02/11] dtc: move declaration of yyerror
Message-ID: <20070719050241.GA31131@localhost.localdomain>
References: <dtc-5-00.miltonm@bga.com> <dtc-5-02.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dtc-5-02.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 07, 2007 at 01:18:47AM -0500, Milton Miller wrote:
> yyerror() is used by both dtc-parser.y and dtc-lexer.l, so move
> the declaration to srcpos.h.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> eliminates implicit declaration warning.

Eck.  This wasn't necessary: that part of dtc-parser.y is included
into dtc-parser.tab.h which in turn is included into dtc-lexer.l.
srcpos.h is supposed to be exclusively for, well, the source position
stuff.

Please revert.

> Index: dtc/dtc-parser.y
> ===================================================================
> --- dtc.orig/dtc-parser.y	2007-06-14 23:16:18.000000000 -0500
> +++ dtc/dtc-parser.y	2007-06-14 23:16:25.000000000 -0500
> @@ -26,7 +26,6 @@
>  #include "srcpos.h"
>  
>  int yylex(void);
> -void yyerror(char const *);
>  cell_t cell_from_string(char *s, unsigned int base);
>  
>  extern struct boot_info *the_boot_info;
> Index: dtc/srcpos.h
> ===================================================================
> --- dtc.orig/srcpos.h	2007-06-14 23:16:18.000000000 -0500
> +++ dtc/srcpos.h	2007-06-14 23:16:25.000000000 -0500
> @@ -62,6 +62,7 @@ typedef struct YYLTYPE {
>  
>  
>  
> +extern void yyerror(char const *);
>  
>  extern int srcpos_filenum;
>  
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
