Date: Wed, 17 Dec 2003 10:51:39 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Lee Braiden <jel@ntlworld.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Would setting the CONFIG_RTC option break the powerpc kernel on your machine ?
Message-ID: <20031217095139.GC2283@iliana>
References: <20031216105656.GA5291@iliana> <1071642293.753.414.camel@gaston> <200312170717.36564.jel@ntlworld.com> <1071646057.6370.482.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1071646057.6370.482.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BTW, should this discussion not be moved to linuxppc mailing lists ?

On Wed, Dec 17, 2003 at 06:27:37PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2003-12-17 at 18:17, Lee Braiden wrote:
> > On Wednesday 17 Dec 2003 6:24 am, Benjamin Herrenschmidt wrote:
> > > CONFIG_RTC will definitely break a pmac
> >
> > I think I heard something about clock/timer problems on PPC a long time ago,
> > but could never track down an issue.  Wouldn't it be best to remove RTC on
> > PPC or document the problem with a (read help) or something?
> >
> > Is the PPC RTC (as opposed to GENERIC_RTC) stuff automatically in there, or
> > something?  Or is it this PPC_RTC that's broken?
>
> Well... CONFIG_RTC enables the "PC style" RTC driver that taps IO ports
> to look for an RTC chip of the kind found in x86 machines. Such a chip
> doesn't exist on powermac and this random IO port tapping can actually
> crash the machine.

And i guess that this PC style RTC is found on the southbridge, right ?
Let me check the VIA docs. Yep, it indeed is there, and i doubt that
there is another clock on the system. Not sure though.

> CONFIG_PPC_RTC/CONFIG_GENERIC_RTC is a different driver that provides
> the /dev/rtc interface but relies on hooks provided by the platform
> code for actually getting/setting the RTC content. The PowerMac platform
> provides hooks for the different kind of RTC chips found on Macs (that
> is basically  access to the RTC via via-cuda or via-pmu). CHRP or

Mmm, these are external via chips on mac hardware used for clocks ?

> PReP machines should provide their own hooks, it's possible that what
> CHRP provides doesn't work properly on the Pegasos, in which case we'd
> have to fix this.

Another solution would be to :

  1) build a pegasos specific config with CONFIG_RTC, but not the other
  two. <= Not good, since it would mean over one hour compil more, and
  one more binary packages. Already like that the ftp-masters are not
  happy.

  2) build all RTC stuff as modules, and let userland choose the one it
  needs.

  3) have CONFIG_RTC check the subarch or something and not work if it
  recognize hardware it doesn't know about or something.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
