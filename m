Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18603.47874.394343.506908@cargo.ozlabs.ibm.com>
Date: Wed, 20 Aug 2008 16:34:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 4/5] powerpc: Make the 64-bit kernel as a
	position-independent executable
In-Reply-To: <Pine.LNX.4.64.0808191816450.25348@vixen.sonytel.be>
References: <18594.14443.340604.693747@cargo.ozlabs.ibm.com>
	<18594.15027.214064.283433@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0808191816450.25348@vixen.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven writes:

> This part broke ppc32:
> 
> | arch/powerpc/kernel/prom.c: In function 'early_init_devtree':
> | arch/powerpc/kernel/prom.c:1166: error: '__end_interrupts' undeclared (first use in this function)
> | arch/powerpc/kernel/prom.c:1166: error: (Each undeclared identifier is reported only once
> | arch/powerpc/kernel/prom.c:1166: error: for each function it appears in.)

I'm not totally surprised I broke ppc32 somewhere along the line
there. :)  I think we will end up with having to have a #ifdef
CONFIG_RELOCATABLE in there or maybe a test on PHYSICAL_START.  It
will depend a bit on whether we want to make relocatable 32-bit
kernels as PIEs as well.

Paul.
