Return-Path: <olecom@flower.upol.cz>
Received: from raven.upol.cz (raven.upol.cz [158.194.120.4])
	by ozlabs.org (Postfix) with ESMTP id A05ADDDED1
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:37:13 +1100 (EST)
Date: Thu, 8 Feb 2007 14:45:34 +0100
To: David Miller <davem@davemloft.net>
Subject: final (Re: Kbuild change breaks the ppc64 build)
Message-ID: <20070208134534.GV22699@flower.upol.cz>
References: <17867.1342.763881.188430@cargo.ozlabs.ibm.com>
	<20070208124756.GU22699@flower.upol.cz>
	<20070208.051706.112290704.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070208.051706.112290704.davem@davemloft.net>
From: Oleg Verych <olecom@flower.upol.cz>
Cc: torvalds@linux-foundation.org, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Date: Feb 08, 2007 at 05:17:06AM -0800
From: David Miller

> From: Oleg Verych <olecom@flower.upol.cz>
> Date: Thu, 8 Feb 2007 13:47:56 +0100
> 
[]
> > As i have refactored some CC checking code in Kbuild.include, it
> > turned, that some versions of `make' after calling nested functions,
> > add (or leave) prefix whitespace to result, thus ifeq[0] fails:
> 
> That's not it, did you see my fix for this problem posted
> already?

Yes, i did. Thanks, David, for fix and for comprehencive approach.

Kudos to everyone, who was forced to deal with this cr@p. Sorry for my
confusion, that fast commit was a bit of stress.

> The issue is the leading spaces on the first line of the define for
> checker-shell.  Those propagate into the callers, although they are
> reduced down to a single space.

Yes, defines leave spaces/tabs as is, it's known thing, but again,
sorry.

> This will give you spaces in the result on any version of
> make.
> 
> Here is my fix again for your reference.
> 
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 8d7eabf..a1880e8 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -60,16 +60,15 @@ endef
>  # Usage: option = $(call checker-shell,$(CC)...-o $$OUT,option-ok,otherwise)
>  # Exit code chooses option. $$OUT is safe location for needless output.
>  define checker-shell
> - $(strip
   ^
Roland had no space here in his patch ;)

> -  $(shell set -e; \
> -    DIR=$(KBUILD_EXTMOD); \
> -    cd $${DIR:-$(objtree)}; \
> -    OUT=$$PWD/.$$$$.null; \
> -    if $(1) >/dev/null 2>&1; \
> -      then echo "$(2)"; \
> -      else echo "$(3)"; \
> -    fi; \
> -    rm -f $$OUT))
> +$(shell set -e; \
> +  DIR=$(KBUILD_EXTMOD); \
> +  cd $${DIR:-$(objtree)}; \
> +  OUT=$$PWD/.$$$$.null; \
> +  if $(1) >/dev/null 2>&1; \
> +    then echo "$(2)"; \
> +    else echo "$(3)"; \
> +  fi; \
> +  rm -f $$OUT)
>  endef
>  
>  # as-option
>
> 

Thanks!
____
