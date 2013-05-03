Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16A852C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 01:02:47 +1000 (EST)
Received: by mail-pd0-f182.google.com with SMTP id 3so958899pdj.27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 May 2013 08:02:45 -0700 (PDT)
Message-ID: <1367593356.29805.37.camel@edumazet-glaptop>
Subject: RE: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 03 May 2013 08:02:36 -0700
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7226@saturn3.aculab.com>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7226@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ambrose Feinstein <ambrose@google.com>, Paul Mackerras <paulus@samba.org>,
 netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-03 at 15:29 +0100, David Laight wrote:
> > > Could ppc64 experts confirm using byte is safe, or should we really add
> > > a 32bit hole after the spinlock ? If so, I wonder how many other places
> > > need a change...
> ...
> > Also I'd be surprised if ppc64 is the only one with that problem... what
> > about sparc64 and arm64 ?
> 
> Even x86 could be affected.
> The width of the memory cycles used by the 'bit set and bit clear'
> instructions isn't documented. They are certainly allowed to do
> RMW on adjacent bytes.
> I don't remember whether they are constrained to only do
> 32bit accesses, but nothing used to say that they wouldn't
> do 32bit misaligned ones! (although I suspect they never have).

x86 is not affected (or else we would have found the bug much earlier)

Setting 1-bit field to one/zero uses OR/AND instructions.

orb  $4,724(%reg)

doesn't load/store 64bits but 8bits.
