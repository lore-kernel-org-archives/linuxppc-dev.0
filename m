Return-Path: <cpclark@xmission.com>
Received: from mgr2.xmission.com (mgr2.xmission.com [198.60.22.202])
	by ozlabs.org (Postfix) with ESMTP id 2E738679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:06:34 +1000 (EST)
Date: Tue, 10 May 2005 04:34:16 -0600 (MDT)
From: cpclark@xmission.com
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050510042828.GA8398@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.63.0505100420380.8140@xmission.xmission.com>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
	<b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
	<20050510042828.GA8398@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 10 May 2005, Sam Ravnborg wrote:

> On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> > 
> > On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> > 
> > >On Fri, 6 May 2005, Kumar Gala wrote:
> > > > I tried the following w/o success:
> > > >
> > > > $(obj)/uImage: $(obj)/vmlinux.gz
> > > >         $(Q)rm -f $@
> > > >         $(call if_changed,uimage)
> > > >         @echo ' Image: $@' $(shell if [ -f $@ ]; then echo 'is ready'; else echo 'not made'; fi)
> > >
> > >Couldn't you eliminate the ($shell ..) construct altogether, like this?:
> > >
> > >$(obj)/uImage: $(obj)/vmlinux.gz
> > >        $(Q)rm -f $@
> > >        $(call if_changed,uimage)
> > >        @echo -n '? Image: $@'
> > >        @if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
> > 
> > Yes, and this seems to actually work.
> > 
> > Sam, does this look reasonable to you.  If so I will work up a patch.
>
> Looks ok - but I do not see why use of $(shell ...) did not work out.

As I understand it, the $(shell ...) construct doesn't "work" in the case 
cited above because make evaluates/expands the $(shell ...) stuff while it 
is parsing the makefile and building the command list--i.e. before it has 
issued any commands to build anything.  What seems to be desired in this 
case is a file-existence test which runs "inline" with respect to the 
preceding commands.  The use of $(shell ...) inside a command 
subverts/preempts that natural sequence.  I think. :-)

Chris
