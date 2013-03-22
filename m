Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C606D2C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 21:58:55 +1100 (EST)
Message-ID: <1363949917.8238.25.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 22 Mar 2013 11:58:37 +0100
In-Reply-To: <1363731391.16671.32@snotra>
References: <1363731391.16671.32@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-03-19 at 17:16 -0500, Scott Wood wrote:

> > > I wonder about kernel modules, though flushing 32 MiB wouldn't be
> > > adequate there.
> > 
> > Good question, but would they be running? You have to have everything
> > built in that you need to load the image? Or maybe not, with the
> > userspace image restoration that became possible at some point...
> 
> Is that all that's being restored in this step, or would we be loading  
> all modules that were loaded before suspend (as they're normally not  
> swappable)?  I'm not too familiar with what gets saved where.

Yes, they would be restored since full memory is restored, but the
kernel doing the restore hasn't typically had a chance to load modules.
Although with uswsusp there probably are ways it can already have.

> > Maybe there's a way to completely flush the (i)cache? :-)
> 
> There is, but it's platform-dependent, and not pleasant on our chips  
> (need a displacement flush for L1, and sometimes errata are involved  
> for L2).

:-)

I'll be the last one to tell you what to do, and I really don't remember
for sure why I did the flushing this way. It may very well be wrong for
what I thought I was doing, but it doesn't matter because I didn't need
to be doing it, I can't say any more now, too long ago. Sorry. May you
should ask Rafael what he thinks about flushing.

johannes
