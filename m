Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0FCFD2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 08:22:22 +1100 (EST)
Message-ID: <1363728127.8336.39.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 19 Mar 2013 22:22:07 +0100
In-Reply-To: <1363727445.16671.30@snotra>
References: <1363727445.16671.30@snotra>
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

On Tue, 2013-03-19 at 16:10 -0500, Scott Wood wrote:

> > I was going to say I have no idea, but looking at it again ... this is
> > in the *resume* code, not the suspend code as I'd assumed, and on  
> > resume
> > I guess I felt it was safer to not assume it didn't change, since it
> > could be a slightly different kernel that loaded and restored the
> > hibernation image?
> 
> Wouldn't that be doomed for other reasons?

Most likely, yeah.

> I wonder about kernel modules, though flushing 32 MiB wouldn't be  
> adequate there.

Good question, but would they be running? You have to have everything
built in that you need to load the image? Or maybe not, with the
userspace image restoration that became possible at some point...

> > It should be the same one, so I guess it should be
> > exactly the same code, but I guess I wanted to make sure there wasn't
> > anything weird there. As for why it'd be 32 MiB? No idea. Although  
> > that
> > really ought to flush all your possible caches anyway, I guess.
> 
> It's not a displacement flush (i.e. you don't do a separate load pass  
> first) -- it just flushes lines if they happen to be present, and  
> leaves alone anything outside that range.  Given that you just finished  
> copying a bunch of data, most likely what's in the cache is the last  
> bit of data you copied.

Oops, good point.

Maybe there's a way to completely flush the (i)cache? :-)

johannes
