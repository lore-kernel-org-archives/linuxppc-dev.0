Return-Path: <cl@linux.com>
Received: from smtp.ultrahosting.com (smtp.ultrahosting.com [74.213.174.254])
	by ozlabs.org (Postfix) with ESMTP id 83BDADDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 01:07:48 +1000 (EST)
Received: from localhost (smtp.ultrahosting.com [127.0.0.1])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 1DB1482C509
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 11:13:57 -0400 (EDT)
Received: from smtp.ultrahosting.com ([74.213.174.254])
	by localhost (smtp.ultrahosting.com [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id MywyLIk5j1I8 for <linuxppc-dev@ozlabs.org>;
	Fri,  1 May 2009 11:13:57 -0400 (EDT)
Received: from qirst.com (unknown [74.213.171.31])
	by smtp.ultrahosting.com (Postfix) with ESMTP id 4D78A82C4FE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 11:13:51 -0400 (EDT)
Date: Fri, 1 May 2009 09:52:18 -0400 (EDT)
From: Christoph Lameter <cl@linux.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 6/6] Add support for __read_mostly to linux/cache.h
In-Reply-To: <20090501094407.GD18326@uranus.ravnborg.org>
Message-ID: <alpine.DEB.1.10.0905010948140.18324@qirst.com>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu>
	<1241119956-31453-2-git-send-email-tabbott@mit.edu>
	<1241119956-31453-3-git-send-email-tabbott@mit.edu>
	<1241119956-31453-4-git-send-email-tabbott@mit.edu>
	<1241119956-31453-5-git-send-email-tabbott@mit.edu>
	<1241119956-31453-6-git-send-email-tabbott@mit.edu>
	<1241119956-31453-7-git-send-email-tabbott@mit.edu>
	<20090501094407.GD18326@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>, Greg Ungerer <gerg@uclinux.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-s390@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>, linux-am33-list@redhat.com,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	microblaze-uclinux@itee.uq.edu.au, Jeff Dike <jdike@addtoit.com>,
	Jeff Arnold <jbarnold@MIT.EDU>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Tony Luck <tony.luck@intel.com>,
	Cyrill Gorcunov <gorcunov@openvz.org>,
	Michal Simek <monstr@monstr.eu>, Waseem Daher <wdaher@MIT.EDU>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
	Tim Abbott <tabbott@MIT.EDU>, Ralf Baechle <ralf@linux-mips.org>,
	Anders Kaseorg <andersk@MIT.EDU>, Kyle McMartin <kyle@mcmartin.ca>,
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

On Fri, 1 May 2009, Sam Ravnborg wrote:

> Are there any specific reason why we do not support read_mostly on all
> architectures?

Not that I know of.

> read_mostly is about grouping rarely written data together
> so what is needed is to introduce this section in the remaining
> archtectures.
>
> Christoph - git log says you did the inital implmentation.
> Do you agree?

Yes.

There is some concern that __read_mostly is needlessly applied to
numerous variables that are not used in hot code paths. This may make
__read_mostly ineffective and actually increase the cache footprint of a
function since global variables are no longer in the same cacheline. If
such a function is called and the caches are cold then two cacheline
fetches have to be done instead of one.
