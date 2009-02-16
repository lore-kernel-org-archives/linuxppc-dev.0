Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 72C42DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 03:08:27 +1100 (EST)
Date: Mon, 16 Feb 2009 19:08:24 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090216160824.GA1616@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090216142001.GA27869@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090216142001.GA27869@oksana.dev.rtsoft.ru>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2009 at 05:20:01PM +0300, Anton Vorontsov wrote:
[...]
> But then, this commit reverted things back (w/o your Ack):
> 
> commit bef5b54bd7bf8117c75cb943d64549134c6d9a1f
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed Jul 16 13:02:24 2008 +0100
> 
>     Fix MIPS cross-compile problem
>     [...]
>     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> [...]
> --- a/Makefile
> +++ b/Makefile
> @@ -508,6 +508,8 @@ else
>  KBUILD_CFLAGS  += -O2
>  endif
>  
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -516,8 +518,6 @@ endif
>  # Arch Makefiles may override this setting
>  KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS  += -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else

Btw, I wonder if x86's CONFIG_CC_STACKPROTECTOR is a no-op since
v2.6.27-rc1? Seems like it is.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
