Return-Path: <mgreer@mvista.com>
Date: Tue, 4 Dec 2007 17:07:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/7] powerpc: Replace ppc_md.power_off with pm_power_off
Message-ID: <20071205000752.GE18063@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
	<20071204054821.GF27862@mag.az.mvista.com>
	<1196752989.13230.265.camel@pasglop>
	<20071204180148.GA1579@mag.az.mvista.com>
	<1196798152.13230.308.camel@pasglop>
	<fa686aa40712041205o39ba4e3epcbc008ea47bd83cc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40712041205o39ba4e3epcbc008ea47bd83cc@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 01:05:46PM -0700, Grant Likely wrote:
> On 12/4/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > On Tue, 2007-12-04 at 11:01 -0700, Mark A. Greer wrote:
> > > On Tue, Dec 04, 2007 at 06:23:09PM +1100, Benjamin Herrenschmidt wrote:
> > > >
> > > > On Mon, 2007-12-03 at 22:48 -0700, Mark A. Greer wrote:
> > > > > From: Mark A. Greer <mgreer@mvista.com>
> > > > >
> > > > > The ppc_md.power_off hook performs the same function that the
> > > > > pm_power_off hook is supposed to.  However, it is powerpc-specific
> > > > > and prevents kernel drivers (e.g., IPMI) from changing how a platform
> > > > > is powered off.  So, get rid of ppc_md.power_off and replace it with
> > > > > pm_power_off.
> > > >
> > > > I'm less happy with that one... probably aesthetics :-)
> > > >
> > > > Can't we just have the generic code call pm_power_off and ppc_md and
> > > > which ever powers the machine off wins ?
> > >
> > > Yes, that would be easy to do.  Seems like duplication though.
> > > If you are sure you're okay with the duplication, I'll do that.
> >
> > Let's ask Paulus what he thinks.
> 
> We could simply have the setup code copy the ppc_md.power_off pointer
> into pm_power_off; that we retain the nice assignment in
> define_machine(), but eliminate the duplicated calls.

Hmm, yeah, that would look nice--nicer than what I have.  The only
issue I have with it is that we still have duplication and potential
for reassigning the wrong one (e.g., reassigning ppc_md.power_off instead
of pm_power_off in maple/setup.c:maple_use_rtas_reboot_and_halt_if_present()).

We could call both in machine_power_off but that's messy too (IMHO).

Paul, do you have an opinion?

Mark
