Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18799.7994.553829.470138@cargo.ozlabs.ibm.com>
Date: Thu, 15 Jan 2009 22:34:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/4] powerpc: Add ppc_progress() wrapper
In-Reply-To: <3922453a668745466cb291f889d2c067932e4894.1232001793.git.michael@ellerman.id.au>
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
	<3922453a668745466cb291f889d2c067932e4894.1232001793.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> There's quite a lot of code that does:
> 
> if (ppc_md.progress)
> 	ppc_md.progress(...)
> 
> So move that idiom into a wrapper. Having a wrapper also allows us
> to have a fallback to printk if no progress routine is specified.

It certainly used to be the case on ppc32 (and may still be) that
ppc_md.progress was called very very early, in some cases before the
MMU was set up, so we don't want to call printk from it.  Falling back
to udbg_printf would be more appropriate.

The idea of ppc_md.progress was that if you need to debug very early
boot and you have something that you can poke with absolutely minimal
setup and observe externally, you can hook that up to ppc_md.progress
and get an idea where the system is dying.  Once you get to the point
where printk works then you can just use printk.

Paul.
