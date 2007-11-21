Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18244.42181.426804.662877@cargo.ozlabs.ibm.com>
Date: Thu, 22 Nov 2007 08:36:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
In-Reply-To: <Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven writes:

> +#define WARN_EMULATE(type)						\
> +	do {								\
> +	    static unsigned int count;					\
> +	    if (count++ < 10)						\
> +		    pr_warning("%s used emulated %s instruction\n",	\
> +			       current->comm, type);			\

Thinking about this a bit more, if an instruction gets emulated 10
times then I don't care, since it's probably only cost me 10
microseconds or so.  If it gets emulated a million times then I might
want to look at it.  So in fact this approach doesn't give me the
information I need to know whether there is a real problem or not.

Paul.
