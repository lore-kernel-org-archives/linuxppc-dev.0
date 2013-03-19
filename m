Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 073EE2C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 07:55:46 +1100 (EST)
Message-ID: <1363726534.8336.37.camel@jlt4.sipsolutions.net>
Subject: Re: [PATCH] powerpc: add Book E support to 64-bit hibernation
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 19 Mar 2013 21:55:34 +0100
In-Reply-To: <1363644757.27435.16@snotra>
References: <1363232178-29938-1-git-send-email-dongsheng.wang@freescale.com>
 <1363250273.4833.1.camel@jlt4.sipsolutions.net> <1363279961.28440.4@snotra>
 <1363360926.8656.5.camel@jlt4.sipsolutions.net>
 <1363644757.27435.16@snotra>
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

On Mon, 2013-03-18 at 17:12 -0500, Scott Wood wrote:

> Could you elaborate on why book3s flushes the way it does?  What's  
> special about the first 32 MiB?  If it's to cover kernel code, why  
> would that be changing from what's already there?

I was going to say I have no idea, but looking at it again ... this is
in the *resume* code, not the suspend code as I'd assumed, and on resume
I guess I felt it was safer to not assume it didn't change, since it
could be a slightly different kernel that loaded and restored the
hibernation image? It should be the same one, so I guess it should be
exactly the same code, but I guess I wanted to make sure there wasn't
anything weird there. As for why it'd be 32 MiB? No idea. Although that
really ought to flush all your possible caches anyway, I guess.

johannes
