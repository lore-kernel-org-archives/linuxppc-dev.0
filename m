Date: Mon, 15 Mar 2004 13:38:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Caching in the MPC107, linux 2.6
Message-ID: <20040315203849.GA13167@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt> <20040313170708.GA20738@smtp.west.cox.net> <1079380996.1677.2.camel@newt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1079380996.1677.2.camel@newt>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 15, 2004 at 08:03:16PM +0000, Adrian Cox wrote:

> On Sat, 2004-03-13 at 17:07, Tom Rini wrote:
>
> > Instead do:
> > BEGIN_FTR_SECTION
> > 	ori	r8,r8,_PAGE_COHERENT
> > END_FTR_SECTION_IFSET(CPU_FTR_745X_MPC107)
> >
> > And have the code that sets SPEC7450 also check for an MPC107.
>
> Something like this?

Actually, I was thinking that having an extra nop there on the !SMP &&
!(745x && MPC107) case wouldn't hurt much / at all, and having this
feature bit be done unconditionally.  But in cpu_setup_6xx.S we would
compare the host bridge vendor / device ID to that of an mpc107.  Or am
I not thinking right, and doing that comparison at that time would be a
bad idea?  If so, I can live with it being an unconditional option, iff
it's only required when MPC10X_STORE_GATHERING is enabled.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
