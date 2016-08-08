Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s72wf5VX5zDqd1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 13:30:10 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so24215373pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:30:10 -0700 (PDT)
Date: Mon, 8 Aug 2016 13:30:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher
 Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Message-ID: <20160808133001.3ccf2153@roar.ozlabs.ibm.com>
In-Reply-To: <20160806201629.GC25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-4-git-send-email-npiggin@gmail.com>
 <20160806201629.GC25821@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 6 Aug 2016 22:16:29 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Aug 05, 2016 at 10:12:01PM +1000, Nicholas Piggin wrote:
> > Add an option for architectures to pass over modules after they are
> > linked. powerpc will use this to fix up alternate instruction patch
> > relocations.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  Documentation/kbuild/makefiles.txt | 6 ++++++
> >  Makefile                           | 1 +
> >  scripts/Makefile.modpost           | 8 ++++++++
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> > index 13f888a..f6c065b 100644
> > --- a/Documentation/kbuild/makefiles.txt
> > +++ b/Documentation/kbuild/makefiles.txt
> > @@ -952,6 +952,12 @@ When kbuild executes, the following steps are followed (roughly):
> >  	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
> >  	mode) if this option is supported by $(AR).
> >  
> > +    KBUILD_MODPOST_TOOL   Arch-specific command to run after module link
> > +
> > +        $(KBUILD_MODPOST_TOOL) is used to add an arch-specific pass over
> > +        modules after their final link. E.g., powerpc uses this to adjust
> > +        relative branches of "alternate code patching" sections.
> > +  
> 
> This needs documentation in kbuild.txt, where there is a
> nearly full lst of KBUILD_ variables.

Thanks, I missed that.

Thanks,
Nick
