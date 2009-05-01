Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 49967DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 19:03:04 +1000 (EST)
Date: Fri, 1 May 2009 11:04:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tim Abbott <tabbott@MIT.EDU>
Subject: Re: [PATCH v2 0/6] macros for section name cleanup
Message-ID: <20090501090455.GA18326@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Greg Ungerer <gerg@uclinux.org>, Jeff Arnold <jbarnold@mit.edu>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Waseem Daher <wdaher@mit.edu>, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	microblaze-uclinux@itee.uq.edu.au,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jeff Dike <jdike@addtoit.com>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Cyrill Gorcunov <gorcunov@openvz.org>,
	Michal Simek <monstr@monstr.eu>, Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Anders Kaseorg <andersk@mit.edu>,
	Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
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

On Thu, Apr 30, 2009 at 03:54:07PM -0400, Tim Abbott wrote:
> (this patch series differs from v1 only in the CC list; some of the
> architecture lists I sent the previous one to are moderated against
> non-members; all replies should go to this version).
> 
> Here are the architecture-independent macro definitions needed for
> to clean up the kernel's section names.  The overall diffstat from
> this section name cleanup project is:
> 
>  96 files changed, 261 insertions(+), 503 deletions(-)
> 
> The decrease results from removing a lot of redundancy in the linker
> scripts.
> 
> The long-term goal here is to add support for building the kernel with
> -ffunction-sections -fdata-sections.  This requires renaming all the
> magic section names in the kernel of the form .text.foo, .data.foo,
> .bss.foo, and .rodata.foo to not have collisions with sections
> generated for code like:
> 
> static int nosave = 0; /* -fdata-sections places in .data.nosave */
> static void head(); /* -ffunction-sections places in .text.head */
> 
> Sam Ravnborg proposed that rather than just renaming all the sections
> outright, we should start by first getting more control over the
> section names used in the kernel so that we can later rename sections
> without touching too many files.  These patch series implement that
> cleanup.  Later, there will be another patch series to actually rename
> the sections.
> 
> I'm hoping we can get just these macro definitions into 2.6.30 so that
> the arch maintainers don't have to grab the macro definitions for
> their trees while reviewing the patches for 2.6.31.
> 
> Shortly, I'm going to send one patch series for each of the
> architectures updating those architectures to use these new macros
> (and otherwise cleaning up section names on those architectures).

Hi Tim.

We agreed to get the common stuff and one architecture done before
proceeding with the rest.
Please stick to that plan so we avoid patch-bombing lkml + maintainers.

When we have this ready it will be a simple one-patch-per-arch to cover
the rest.

I will comment on your common patches for now.

	Sam
