Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Feb 2007 21:25:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: platform_ops.malloc() vs. realloc()
Message-ID: <20070222102553.GA11014@localhost.localdomain>
References: <Pine.LNX.4.62.0702221112010.22848@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0702221112010.22848@pademelon.sonytel.be>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 22, 2007 at 11:14:36AM +0100, Geert Uytterhoeven wrote:
> 
> arch/powerpc/boot/ops.h has:
> 
> | /* Platform specific operations */
> | struct platform_ops {
> |         void    (*fixups)(void);
> |         void    (*image_hdr)(const void *);
> |         void *  (*malloc)(u32 size);
> |         void    (*free)(void *ptr);
> |         void *  (*realloc)(void *ptr, unsigned long size);
> |         void    (*exit)(void);
> | };
> 
> Is there a specific reason why the size parameters of malloc() and realloc()
> differ in type?

Not as far as I'm aware, I believe it's just a wart.  The zImage is
always compiler 32-bit, so they're actually the same thing.  I'm
actually hoping to get rid of malloc() and realloc() at some point.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
