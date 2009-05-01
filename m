Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id DA433DDDA9
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 19:16:45 +1000 (EST)
Date: Fri, 1 May 2009 11:18:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tim Abbott <tabbott@MIT.EDU>
Subject: Re: [PATCH v2 1/6] Add new macros for page-aligned data and bss
	sections.
Message-ID: <20090501091848.GB18326@uranus.ravnborg.org>
References: <1241121253-32341-1-git-send-email-tabbott@mit.edu>
	<1241121253-32341-2-git-send-email-tabbott@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241121253-32341-2-git-send-email-tabbott@mit.edu>
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

On Thu, Apr 30, 2009 at 03:54:08PM -0400, Tim Abbott wrote:
> This patch is preparation for replacing most uses of
> ".bss.page_aligned" and ".data.page_aligned" in the kernel with
> macros, so that the section name can later be changed without having
> to touch a lot of the kernel.
> 
> The long-term goal here is to be able to change the kernel's magic
> section names to those that are compatible with -ffunction-sections
> -fdata-sections.  This requires renaming all magic sections with names
> of the form ".data.foo".
> 
> Signed-off-by: Tim Abbott <tabbott@mit.edu>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: David Howells <dhowells@redhat.com>
> ---
>  include/asm-generic/vmlinux.lds.h |    8 ++++++++
>  include/linux/linkage.h           |    9 +++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 89853bc..3d88c87 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -116,6 +116,14 @@
>  	FTRACE_EVENTS()							\
>  	TRACE_SYSCALLS()
>  
> +#define PAGE_ALIGNED_DATA						\
> +	. = ALIGN(PAGE_SIZE);						\
> +	*(.data.page_aligned)
> +
> +#define PAGE_ALIGNED_BSS						\
> +	. = ALIGN(PAGE_SIZE);						\
> +	*(.bss.page_aligned)
> +
>  #define RO_DATA(align)							\
>  	. = ALIGN((align));						\
>  	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
> diff --git a/include/linux/linkage.h b/include/linux/linkage.h
> index fee9e59..af051fc 100644
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -22,6 +22,15 @@
>  #define __page_aligned_bss	__section(.bss.page_aligned) __aligned(PAGE_SIZE)
>  
>  /*
> + * For assembly routines.
> + *
> + * Note when using these that you must specify the appropriate
> + * alignment directives yourself
> + */
> +#define __PAGE_ALIGNED_DATA	.section ".data.page_aligned", "aw", @progbits
> +#define __PAGE_ALIGNED_BSS	.section ".bss.page_aligned", "aw", @nobits

The above will work on most architectures but fails (silently?) on arm.
arm uses %{progbits,nobits} where all other uses @{nobits,progbits}.

I know we do not use page_aligned in arm assembler code for now,
but if we do then it should work.
It is my understanding that the linker will automatically
assume nobits for section names starting with .bss and likewise
progbits for section names starting with .data - so we can leave them out?


	Sam
