Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s72hl2dF9zDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 13:19:51 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so24200754pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:19:51 -0700 (PDT)
Date: Mon, 8 Aug 2016 13:19:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann
 <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool
 <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160808131941.27541a33@roar.ozlabs.ibm.com>
In-Reply-To: <20160807144054.GA14682@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
 <20160807144054.GA14682@ravnborg.org>
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

On Sun, 7 Aug 2016 16:40:54 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> > Hi Sam,
> > 
> > On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:  
> > >
> > > Did you by any chance evalue the use of INPUT in linker files.
> > > Stephen back then (again based on proposal from Alan Modra),
> > > also made an implementation using INPUT.  
> > 
> > The problem with that idea was that (at least for some versions of
> > binutils in use at the time) we hit a static limit to the number of
> > object files and ld just stopped at that point. :-(  
> 
> The ld bug was caused by opening too many linked definitions files.
> We can workaround this by expanding the files.
> I gave this a quick spin - see below.
> 
> Note - I have no idea if using thin archived or this method is better.
> But it seems just wrong to me that we convert to thin archives when
> we really do not need to do so.
> 
> Note - this was a quick spin. It build fine here and thats it.

Is there a reason to prefer using linker scripts rather than thin
archives? I thought the former was possibly a bit less robust, and
the latter a smaller change for scripts and toolchain in terms
of "almost behaving like an object file".

I don't have a strong preference although do have a couple of
(out of tree) scripts that expect objdump to work on built-in.o

Thanks,
Nick
