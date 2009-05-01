Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id 8B74ADDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 19:42:05 +1000 (EST)
Date: Fri, 1 May 2009 11:44:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tim Abbott <tabbott@MIT.EDU>, Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH 6/6] Add support for __read_mostly to linux/cache.h
Message-ID: <20090501094407.GD18326@uranus.ravnborg.org>
References: <1241119956-31453-1-git-send-email-tabbott@mit.edu>
	<1241119956-31453-2-git-send-email-tabbott@mit.edu>
	<1241119956-31453-3-git-send-email-tabbott@mit.edu>
	<1241119956-31453-4-git-send-email-tabbott@mit.edu>
	<1241119956-31453-5-git-send-email-tabbott@mit.edu>
	<1241119956-31453-6-git-send-email-tabbott@mit.edu>
	<1241119956-31453-7-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241119956-31453-7-git-send-email-tabbott@mit.edu>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Denys Vlasenko <vda.linux@googlemail.com>,
	Greg Ungerer <gerg@uclinux.org>, Jeff Arnold <jbarnold@mit.edu>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Waseem Daher <wdaher@mit.edu>, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-s390@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>,
	linux-am33-list@redhat.com, Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	microblaze-uclinux@itee.uq.edu.au,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jeff Dike <jdike@addtoit.com>, dev-etrax@axis.com,
	Mikael Starvik <starvik@axis.com>, Tony Luck <tony.luck@intel.com>,
	Cyrill Gorcunov <gorcunov@openvz.org>, Michal Simek <monstr@monstr.eu>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Bryan Wu <cooloney@kernel.org>,
	linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Hirokazu Takata <takata@linux-m32r.org>,
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

On Thu, Apr 30, 2009 at 03:32:36PM -0400, Tim Abbott wrote:
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> ---
>  include/linux/cache.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 97e2488..99d8a6f 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -13,7 +13,13 @@
>  #endif
>  
>  #ifndef __read_mostly
> +#ifdef CONFIG_HAVE_READ_MOSTLY_DATA
> +#define __read_mostly __attribute__((__section__(".data.read_mostly")))
> +#define __READ_MOSTLY .section ".data.read_mostly", "aw"
> +#else
>  #define __read_mostly
> +#define __READ_MOSTLY
> +#endif /* CONFIG_HAVE_READ_MOSTLY_DATA */
>  #endif

Are there any specific reason why we do not support read_mostly on all
architectures?

read_mostly is about grouping rarely written data together
so what is needed is to introduce this section in the remaining
archtectures.

Christoph - git log says you did the inital implmentation.
Do you agree?

	Sam
