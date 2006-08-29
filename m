Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17652.49904.419167.448821@cargo.ozlabs.ibm.com>
Date: Wed, 30 Aug 2006 08:42:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: undefined reference to pci_io_base
In-Reply-To: <44F47ABE.7080602@am.sony.com>
References: <44F47ABE.7080602@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> I'm trying to understand the intended design of the inb()
> and outb() macros in asm-powerpc/io.h. They are causing
> me some grief when I set CONFIG_PCI=n:
> 
>   drivers/built-in.o: undefined reference to `pci_io_base'
> 
> This is coming from drivers/char/mem.c, which is always
> built in, and is referencing pci_io_base through inb()
> and outb().

Hmmm.  inb and outb are designed for accessing PCI I/O space.  I guess
we could turn them into BUG() when CONFIG_PCI=n.

Paul.
