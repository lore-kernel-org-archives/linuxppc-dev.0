Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 320BADDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 03:42:52 +1000 (EST)
Date: Fri, 1 May 2009 19:44:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss
	sections.
Message-ID: <20090501174457.GA26559@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
	<20090501091848.GB18326@uranus.ravnborg.org>
	<alpine.DEB.1.10.0905010951100.3955@vinegar-pot.mit.edu>
	<49FB2449.1010301@zytor.com>
	<20090501171717.GA26401@uranus.ravnborg.org>
	<49FB2EDC.9050300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49FB2EDC.9050300@zytor.com>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>, Tim Abbott <tabbott@MIT.EDU>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	Jeff Arnold <jbarnold@MIT.EDU>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Cyrill Gorcunov <gorcunov@openvz.org>,
	Michal Simek <monstr@monstr.eu>, Waseem Daher <wdaher@MIT.EDU>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Anders Kaseorg <andersk@MIT.EDU>,
	Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 01, 2009 at 10:18:20AM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> > On Fri, May 01, 2009 at 09:33:13AM -0700, H. Peter Anvin wrote:
> >> Tim Abbott wrote:
> >>> On Fri, 1 May 2009, Sam Ravnborg wrote:
> >>>
> >>>> On Thu, Apr 30, 2009 at 03:54:08PM -0400, Tim Abbott wrote:
> >>>>> +#define __PAGE_ALIGNED_DATA	.section ".data.page_aligned", "aw", @progbits
> >>>>> +#define __PAGE_ALIGNED_BSS	.section ".bss.page_aligned", "aw", @nobits
> >>>> It is my understanding that the linker will automatically
> >>>> assume nobits for section names starting with .bss and likewise
> >>>> progbits for section names starting with .data - so we can leave them out?
> >>> I believe that is correct.
> >>>
> >> ... but that doesn't mean it's the right thing to do.
> >>
> >> It's better to be fully explicit when macroizing this kind of stuff.
> >> This is part of why macroizing it is good: it means we end up with *one*
> >> place that determines this stuff, not some magic heuristics in the linker.
> > 
> > Do you know if we can use % in place of @?
> > I could see that gas supports both - at least in trunk in cvs.
> > 
> 
> I think it might depend on the architecture(!)... but it would
> definitely have to be an issue with testing a bunch of different versions.
> 
> What's wrong with @?
arm does not support it :-(
I recall it denote a comment in arm assembler.

I could do some magic to detect the ARM case but I'm reluctant to do so.
I could also ignore the arm issue for now as it is not used by arm,
but that strikes me as the wrong approach.


	Sam
