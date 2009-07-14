Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B5BC5B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 23:37:18 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 3FABEDDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 23:37:18 +1000 (EST)
Date: Tue, 14 Jul 2009 17:37:16 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH RFC 1/2] Makefile: Never use -fno-omit-frame-pointer
Message-ID: <20090714133716.GC28970@oksana.dev.rtsoft.ru>
References: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 12:16:30AM +0400, Anton Vorontsov wrote:
> According to Segher Boessenkool and GCC manual, -fomit-frame-pointer
> is only the default when optimising on archs/ABIs where it doesn't
> hinder debugging and -pg. So, we do not get it by default on x86,
> not at any optimisation level.
> 
> On the other hand, *using* -fno-omit-frame-pointer causes gcc to
> produce buggy code on PowerPC targets.
> 
> If Segher and GCC manual are right, this patch should be a no-op
> for all arches except PowerPC, where the patch fixes gcc issues.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> See this thread for more discussion:
> http://osdir.com/ml/linux-kernel/2009-05/msg01754.html
> 
> p.s.
> Obviously, I didn't test this patch on anything else but PPC32. ;-)
> 
> Segher, do you know if all GCC versions that we support for
> building Linux are behaving the way that GCC manual describe?

No news is good news... Ingo, can we merge this into -tip for testing?

Thanks,

>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index ea63667..70ad1ff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -535,7 +535,7 @@ KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
>  endif
>  
>  ifdef CONFIG_FRAME_POINTER
> -KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> +KBUILD_CFLAGS	+= -fno-optimize-sibling-calls
>  else
>  KBUILD_CFLAGS	+= -fomit-frame-pointer
>  endif
> -- 
> 1.6.3.1
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
