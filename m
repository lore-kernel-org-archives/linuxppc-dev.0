Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18425.24938.332852.315571@cargo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2008 09:48:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
In-Reply-To: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Wanted to get any feedback on this initial port of the fixmap support over
> from x86.  There are a few TODOs:

I have no objection in principle, but your patch below imports a few
things that aren't (and won't be) needed on powerpc AFAICS -- for
example, we don't need FIX_VDSO, since our VDSO is mapped into user
space at the 1MB point (by default).

You have FIX_PCIE_MCFG in there too (keyed off CONFIG_PCI_MMCONFIG
which we don't have and don't want to have).  If you need to map in
PCIe config space, what's wrong with just using ioremap?  Why do you
need to have a fixed virtual address for it?

More generally, I think we need to take an overall look at what things
we are using fixed virtual addresses for, and why they need to be
fixed.  If there are indeed several such things then we can introduce
the fixmap stuff.

Paul.
