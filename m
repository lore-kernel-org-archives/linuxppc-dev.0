Subject: Re: Disable cache on 74xx
From: Gary Thomas <gary@mlbassoc.com>
To: Brian Waite <waite@skycomputers.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200302200855.12224.waite@skycomputers.com>
References: <200302191552.01911.waite@skycomputers.com>
	<1045688879.12534.80.camel@zion.wanadoo.fr>
	<1045694930.22231.6567.camel@hermes.chez-thomas.org>
	<200302200855.12224.waite@skycomputers.com>
Content-Type: text/plain
Date: 20 Feb 2003 07:01:39 -0700
Message-Id: <1045749699.18487.7532.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-02-20 at 06:55, Brian Waite wrote:
> According to The User's Manual, the data cache instructions become no-ops if
> the data cache is disabled.
>

There are "User Manuals" and then there is "Real Life".  My
experience has been that trying to execute these instructions
with the cache disabled was treated like an invalid instruction
(hence causing a trap).  Maybe this isn't always true with all
PowerPC processors, but I was just pointing out that you might
run into trouble with it.

> Thanks
> Brian
> On Wednesday 19 February 2003 5:48 pm, Gary Thomas wrote:
> > On Wed, 2003-02-19 at 14:07, Benjamin Herrenschmidt wrote:
> > > On Wed, 2003-02-19 at 21:52, Brian Waite wrote:
> > > > Hi all,
> > > > 	I am trying to hunt down a memory controller configuration problem and
> > > > I have been asked to disable all caching so as to remove it from the
> > > > equation. I can easl disable L2 but when I start ucking with the WIMG
> > > > bits to set cache inhibit, The kernel panics with stack overflows. Does
> > > > anyone know where or what I have to set to disable caching?
> > >
> > > Hrm... set L2 and L3 off, then hack HID0 to disable L1 ?
> >
> > There are other problems with this.  With the caches disabled
> > (via HID0) all data cache instructions (like DCBF) will fail.
> > There are some of these in the kernel itself, but beware that
> > GLIBC has it's own set.
> >
> > ... totally disabling the data CACHE with Linux is non-trivial.
--
------------------------------------------------------------
Gary Thomas                 |
MLB Associates              |  Consulting for the
+1 (970) 229-1963           |    Embedded world
http://www.mlbassoc.com/    |
email: <gary@mlbassoc.com>  |
gpg: http://www.chez-thomas.org/gary/gpg_key.asc
------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
