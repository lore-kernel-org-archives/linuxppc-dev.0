Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17265.18762.905673.466214@cargo.ozlabs.ibm.com>
Date: Wed, 9 Nov 2005 11:56:42 +1100
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20051108223631.GR3839@smtp.west.cox.net>
References: <20051108223631.GR3839@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, Kumar Gala <galak@gate.crashing.org>,
	Matt Mackall <mpm@selenic.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Fix CONFIG_PRINTK=n building
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini writes:

> The following patch is needed to allow PRINTK=n to work on ppc32.
> 
> Direct calls to printk from asm files can't be magically removed so we
> have to do it manually.

Nak.  We are using arch/powerpc/kernel/fpu.S now (even for ARCH=ppc)
and it doesn't do the printk in assembler.

In general I'd prefer to move the printk calls to C code rather than
adding these ifdefs.

Paul.
