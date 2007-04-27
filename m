Return-Path: <mgreer@mvista.com>
Date: Fri, 27 Apr 2007 15:02:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/13] powerpc: Add bootwrapper support for Marvell/mv64x60
	hostbridge
Message-ID: <20070427220245.GC14490@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070425235619.GE4046@mag.az.mvista.com>
	<17969.37331.228482.225919@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17969.37331.228482.225919@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 04:01:55PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> >  Makefile  |    2 
> >  mv64x60.c |  581 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  mv64x60.h |   70 +++++++
> >  3 files changed, 652 insertions(+), 1 deletion(-)
> 
> 650 lines just to set up a hostbridge - that seems like rather a lot.

Yes, it is.  This probably won't make you feel any better but most of
the lines are #define's or table init lines.  There's only a couple
hundred or so that are actual code.

> Why do we have to do this here?  Isn't there some firmware that should
> do this for us?

Well, the firmware just doesn't do all the init that's required.  And,
some of the init that it does do is wrong.  For example, the window for
the MPSC (serial ctlr) to access main memory isn't set up so the kernel
mpsc driver can't dma.  There are several other examles.

All of this init should be in the firmware but its Motorola/ECC's
firmware and I/we have no control over it.  Given that, I/we have to do
the init somewhere.  Either in the kernel or the bootwrapper.
I vote for the bootwrapper but then your vote is the only one that actually
counts.  :)

Mark
