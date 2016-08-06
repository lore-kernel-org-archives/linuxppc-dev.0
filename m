Return-Path: <sam@ravnborg.org>
Received: from asavdk4.altibox.net (asavdk4.altibox.net [109.247.116.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6FLp65d8zDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 06:16:34 +1000 (AEST)
Date: Sat, 6 Aug 2016 22:16:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Message-ID: <20160806201629.GC25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-4-git-send-email-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470399123-8455-4-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 05, 2016 at 10:12:01PM +1000, Nicholas Piggin wrote:
> Add an option for architectures to pass over modules after they are
> linked. powerpc will use this to fix up alternate instruction patch
> relocations.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Documentation/kbuild/makefiles.txt | 6 ++++++
>  Makefile                           | 1 +
>  scripts/Makefile.modpost           | 8 ++++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 13f888a..f6c065b 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -952,6 +952,12 @@ When kbuild executes, the following steps are followed (roughly):
>  	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
>  	mode) if this option is supported by $(AR).
>  
> +    KBUILD_MODPOST_TOOL   Arch-specific command to run after module link
> +
> +        $(KBUILD_MODPOST_TOOL) is used to add an arch-specific pass over
> +        modules after their final link. E.g., powerpc uses this to adjust
> +        relative branches of "alternate code patching" sections.
> +

This needs documentation in kbuild.txt, where there is a
nearly full lst of KBUILD_ variables.

	Sam
