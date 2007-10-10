Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id DE404DDFC7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 05:56:06 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so372297wag
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 12:56:05 -0700 (PDT)
Message-ID: <fa686aa40710101256q3783994dr854e2bdecddf9820@mail.gmail.com>
Date: Wed, 10 Oct 2007 13:56:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au, paulus@ozlabs.org,
	"Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] Bootwrapper: Enable debug info on boot wrapper
In-Reply-To: <20071004040501.16923.68468.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071004040501.16923.68468.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Any comments on this one?  Scott?  David?

Cheers,
g.

On 10/3/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Add '-g' to BOOTCFLAGS if CONFIG_DEBUG_INFO is set.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  arch/powerpc/boot/Makefile |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index cf80db3..9dfe79b 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -25,6 +25,10 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                  -isystem $(shell $(CROSS32CC) -print-file-name=include)
>  BOOTAFLAGS     := -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
>
> +ifdef CONFIG_DEBUG_INFO
> +BOOTCFLAGS     += -g
> +endif
> +
>  ifeq ($(call cc-option-yn, -fstack-protector),y)
>  BOOTCFLAGS     += -fno-stack-protector
>  endif
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
