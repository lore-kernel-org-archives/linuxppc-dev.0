Return-Path: <geert@linux-m68k.org>
Received: from witte.sonytel.be (witte.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id D5A5568A3D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 00:54:24 +1100 (EST)
Date: Wed, 25 Jan 2006 13:28:51 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@sonycom.com
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
In-Reply-To: <20060125113446.GF18584@miraclelinux.com>
Message-ID: <Pine.LNX.4.62.0601251323420.19174@pademelon.sonytel.be>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113446.GF18584@miraclelinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	Russell King <rmk@arm.linux.org.uk>, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jan 2006, Akinobu Mita wrote:
> If the arechitecture is
> - BITS_PER_LONG == 64
> - struct thread_info.flag 32 is bits
> - second argument of test_bit() was void *
> 
> Then compiler print error message on test_ti_thread_flags()
> in include/linux/thread_info.h
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> ---
>  thread_info.h |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: 2.6-git/include/linux/thread_info.h
> ===================================================================
> --- 2.6-git.orig/include/linux/thread_info.h	2006-01-25 19:07:12.000000000 +0900
> +++ 2.6-git/include/linux/thread_info.h	2006-01-25 19:14:26.000000000 +0900
> @@ -49,7 +49,7 @@
>  
>  static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
>  {
> -	return test_bit(flag,&ti->flags);
> +	return test_bit(flag, (void *)&ti->flags);
>  }

This is not safe. The bitops are defined to work on unsigned long only, so
flags should be changed to unsigned long instead, or you should use a
temporary.

Affected platforms:
  - alpha: flags is unsigned int
  - ia64, sh, x86_64: flags is __u32

The only affected 64-platforms are little endian, so it will silently work
after your change, though...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
