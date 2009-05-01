Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 41243DDDB6
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 19:19:13 +1000 (EST)
Date: Fri, 1 May 2009 11:21:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tim Abbott <tabbott@MIT.EDU>
Subject: Re: [PATCH v2 2/6] Add new NOSAVE_DATA linker script macro.
Message-ID: <20090501092114.GC18326@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
	<1241121253-32341-3-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241121253-32341-3-git-send-email-tabbott@mit.edu>
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

On Thu, Apr 30, 2009 at 03:54:09PM -0400, Tim Abbott wrote:
> This patch is preparation for replacing most ".data.nosave" in the
> kernel with macros, so that the section name can later be changed
> without having to touch a lot of the kernel.
> 
> The long-term goal here is to be able to change the kernel's magic
> section names to those that are compatible with -ffunction-sections
> -fdata-sections.  This requires renaming all magic sections with names
> of the form ".data.foo".
> 
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  include/asm-generic/vmlinux.lds.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 3d88c87..f5ebd2b 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -124,6 +124,13 @@
>  	. = ALIGN(PAGE_SIZE);						\
>  	*(.bss.page_aligned)
>  
> +#define NOSAVE_DATA							\
> +	. = ALIGN(PAGE_SIZE);						\
> +	__nosave_begin = .;						\
> +	*(.data.nosave)							\
> +	. = ALIGN(PAGE_SIZE);						\
> +	__nosave_end = .;
> +

You need to use:
	VMLINUX_SYMBOL(__nosave_begin) = .;

Otherwise architectures such as m68k wil break as they
add a leading underscore.

See other symbols that is defined inside vmlinux.lds.h

	Sam
