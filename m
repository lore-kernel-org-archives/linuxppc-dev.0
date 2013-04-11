Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 074D02C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 02:10:55 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id um15so936279pbc.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 09:10:54 -0700 (PDT)
Message-ID: <1365696644.3887.172.camel@edumazet-glaptop>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Date: Thu, 11 Apr 2013 09:10:44 -0700
In-Reply-To: <20130411160258.GI1910@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411153256.GH1910@1wt.eu> <1365695675.3887.165.camel@edumazet-glaptop>
 <20130411160258.GI1910@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-11 at 18:02 +0200, Willy Tarreau wrote:

> OK, that makes sense indeed, I didn't think about this case. All
> I remember was that the old call achieved a higher packet rate
> than napi_gro_receive, but it was on an older kernel and I can't
> be more specifics after several months :-/

Its probably true that the GRO handler consumes more cpu for packets
that cant be aggregated in the end.

Thats a trade off, and maybe we could add in the core stack a device
feature to instruct gro handler to do a short cut for packets with no
checksum. Or better a sysctl so that a static_branch can be used.
