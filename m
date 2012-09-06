Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AC702C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 18:46:33 +1000 (EST)
Date: Thu, 6 Sep 2012 10:46:19 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: fix personality handling in
 ppc64_personality()
In-Reply-To: <1346879598.19098.4.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1209061039180.23459@pobox.suse.cz>
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
 <m27gtitfv4.fsf@igel.home>
 <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
 <1346813643.2257.24.camel@pasglop>
 <alpine.LNX.2.00.1209051056060.11079@pobox.suse.cz>
 <1346879598.19098.4.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Sep 2012, Benjamin Herrenschmidt wrote:

> > actually commit 7256a5d2da56 seems to contain the correct PER_LINUX 
> > handling, so seems like you picked the right one :)
> > 
> 
> Odd, they looked different around the use of PER_MASK when I looked but

The original patch had

	personality &= ~PER_LINUX | PER_LINUX32;

Which is bogus, exactly because ~PER_LINUX is -1.

I then used

	personality = (personality & ~PER_MASK) | PER_LINUX32;

which is correct and perhaps a little bit more descriptive, and that is 
what you have merged, so all is fine.

> I was tired & jet lagged, so I might have just had a brain fail...

Probably just missed that the first patch used PER_LINUX and the second 
one PER_MASK, or whatever.

Anyway, thanks.

-- 
Jiri Kosina
SUSE Labs
