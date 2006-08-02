Return-Path: <trini@kernel.crashing.org>
Date: Wed, 2 Aug 2006 09:17:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 4/6] bootwrapper: Add non-OF serial console support
Message-ID: <20060802161712.GH3075@smtp.west.cox.net>
References: <20060719231244.GE3887@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719231244.GE3887@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2006 at 04:12:44PM -0700, Mark A. Greer wrote:

> This patch adds support for serial I/O to the bootwrapper.
> 
> It is broken into 2 layers.  The first layer is generic serial
> operations that calls uart-specific routines to do the actual I/O.
> The second layer contains support for a 16550 compatible uart.
> 
> The division allows support for other serial devices to be easily
> added in the future (e.g., the Marvell MPSC and the Freescale CPM).

Why do we do this with indirection rather than weak defaults and then
real implementations?  The only places I see that are data are:

> +	ns16550_scd.base = NULL;
> +	ns16550_scd.reg_shift = 0;

And I imagine that on platforms where these are real, we dig them out of
the tree and set them, in your scheme, so it'd just be an empty (return
0/NULL) weak function, or the dig in the tree function.  Heck, it could
just always be a 'dig in the tree' function.

-- 
Tom Rini
