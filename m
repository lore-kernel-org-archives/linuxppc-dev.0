Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 21C032C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 02:01:04 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id fa10so922888pad.27
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 May 2013 09:01:03 -0700 (PDT)
Message-ID: <1367424059.11020.61.camel@edumazet-glaptop>
Subject: RE: [PATCH v2 net-next] af_unix: fix a fatal race with bit fields
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>
Date: Wed, 01 May 2013 09:00:59 -0700
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B721C@saturn3.aculab.com>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
 <20130501.033650.703182794549888825.davem@davemloft.net>
 <1367421843.11020.43.camel@edumazet-glaptop>
 <AE90C24D6B3A694183C094C60CF0A2F6026B721C@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ambrose@google.com, paulus@samba.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-01 at 16:53 +0100, David Laight wrote:
> Why not just change gc_candidate and gc_maybe_cycle to
> unsigned char?
> It might reduce the number of pad bytes somewhat.

You didn't quite follow the discussion.

I used bytes on V1, and we are not 100% sure its safe on all arches.

unsigned long is guaranteed to be safe. We absolutely rely on this.

Better use more bytes on a socket (with no impact on real memory use),
than spending hours to debug some strange issues.
