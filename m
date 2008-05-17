Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18478.30398.757109.444930@cargo.ozlabs.ibm.com>
Date: Sat, 17 May 2008 16:10:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC v2] Add a comment about the Book-e tophys/tovirt
	macros
In-Reply-To: <Pine.LNX.4.64.0805161419430.7053@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161419430.7053@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> +/*
> + * We use addis to ensure compatiblity with the "classic" ppc versions
> + * of these macros that might have rs as 0, which means a value of 0
> + * not r0
> + */
>  #define tophys(rd,rs)				\
>  	addis	rd,rs,0

Still seems clear as mud.  I think you're trying to say that some
callers use rs = 0 to get the tophys offset in rd, rather than
converting the address in r0, and so this version has to do that too
(i.e. set register rd to 0 when rs == 0)?

Paul.
