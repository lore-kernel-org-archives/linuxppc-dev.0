Return-Path: <trini@kernel.crashing.org>
Date: Wed, 27 Oct 2004 09:39:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20041027163927.GD4979@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB95@ismail.innsys.innovsys.com>
	<20041026143514.GQ25154@smtp.west.cox.net>
	<417F39EB.5010907@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <417F39EB.5010907@intracom.gr>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 27, 2004 at 09:02:19AM +0300, Pantelis Antoniou wrote:
> Tom Rini wrote:
> 
> >On Fri, Oct 22, 2004 at 05:01:54PM -0500, Rune Torgersen wrote:
> >
> >>>From: Tom Rini [mailto:trini@kernel.crashing.org] 
> >>>On Thu, Oct 21, 2004 at 04:57:56PM -0500, Rune Torgersen wrote:
> >>>
> >>>>BTW..
> >>>>What are the device node numbers for ttyCPM[0..5] ?
> >>>>
> >>>204 42...45 (devices.txt in linuxppc-2.5, Pantelis ever 
> >>>figure out what to do about the device # conflict with the 
> >>>i.MX driver so we can push that small bit upstream ?)
> >>>
> >>Aparently not that simple.... I looked in the source, and it depends if 
> >>an 8250 stype serial port is defined or not...
> >>
> >>#ifndef CONFIG_SERIAL_8250
> >>#define SERIAL_CPM_MAJOR	TTY_MAJOR
> >>#define SERIAL_CPM_MINOR	64
> >>#else
> >>#define SERIAL_CPM_MAJOR	204
> >>#define SERIAL_CPM_MINOR	42
> >>#endif
> >>
> >>Urgh...
> >>
> >
> >That doesn't make sense.  Pantelis?
> >
> >
> Well, it sure doesn't.
> 
> We should really try to find a generic solution to this
> problem, i.e. that SoC like processors almost always have a number of serial
> ports, and every single one ends up being of a different major/minor number.

I disagree, at least in the sense that this needs to involve the kernel.
What Rune found is a real bug, in that sometimes we steal the
major/minors of ttyS, and sometimes we don't.  What we need to do is to
always use our own major/minor.

> IMHO the best solution would be to allocate a single major number, and
> then map to the minors in order, the possible serial ports.

This isn't neccessary.  One could handle this rather trivially with udev
so that /dev/ttyC[0-N], to use your names are just symlinks to ttyCPM0,
ttyCPM1, ttyS0, ttyS1, and so on.

-- 
Tom Rini
http://gate.crashing.org/~trini/
