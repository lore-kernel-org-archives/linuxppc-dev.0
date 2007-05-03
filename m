Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17977.29234.367271.820951@cargo.ozlabs.ibm.com>
Date: Thu, 3 May 2007 15:25:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
In-Reply-To: <20070427220245.GC14490@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235619.GE4046@mag.az.mvista.com>
	<17969.37331.228482.225919@cargo.ozlabs.ibm.com>
	<20070427220245.GC14490@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> Well, the firmware just doesn't do all the init that's required.  And,
> some of the init that it does do is wrong.  For example, the window for
> the MPSC (serial ctlr) to access main memory isn't set up so the kernel
> mpsc driver can't dma.  There are several other examles.
> 
> All of this init should be in the firmware but its Motorola/ECC's
> firmware and I/we have no control over it.  Given that, I/we have to do
> the init somewhere.  Either in the kernel or the bootwrapper.
> I vote for the bootwrapper but then your vote is the only one that actually
> counts.  :)

How much of the setup is actually necessary for the bootwrapper to
run, and how much could be deferred to setup_arch() time in the
kernel?  If nothing else, doing it in the kernel means that the code
and data for it exist in compressed form in the zImage rather than
uncompressed form. :)

Also, how many lines of code (including definitions) would we avoid
having in the kernel by having this stuff in the bootwrapper?

Another question - is this setup something that will need to be done
differently for different boards using the mv64x60, or is the same
setup needed for all applications of the mv64x60?

Paul.
