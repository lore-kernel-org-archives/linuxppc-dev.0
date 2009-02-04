Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B74DDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:26:33 +1100 (EST)
Date: Wed, 4 Feb 2009 22:26:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090204212612.GN22608@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090204150835.GA30027@oksana.dev.rtsoft.ru>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This patch gives arches more freedom on overwriting CFLAGS, specifically
> on PowerPC we want to remove -fno-omit-frame-pointer flag.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7715b2c..d1ba93f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -525,8 +525,6 @@ else
>  KBUILD_CFLAGS	+= -O2
>  endif
>  
> -include $(srctree)/arch/$(SRCARCH)/Makefile
> -
>  ifneq (CONFIG_FRAME_WARN,0)
>  KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
>  endif
> @@ -555,6 +553,8 @@ ifdef CONFIG_DEBUG_SECTION_MISMATCH
>  KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
>  endif
>  
> +include $(srctree)/arch/$(SRCARCH)/Makefile
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  CHECKFLAGS     += $(NOSTDINC_FLAGS)
> -- 

this patch is really for Sam to judge - Cc:-ed him.

	Ingo
