Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-f49.google.com (mail-pb0-f49.google.com
 [209.85.160.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D7742C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 01:54:42 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id um15so928668pbc.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 08:54:40 -0700 (PDT)
Message-ID: <1365695675.3887.165.camel@edumazet-glaptop>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Date: Thu, 11 Apr 2013 08:54:35 -0700
In-Reply-To: <20130411153256.GH1910@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411153256.GH1910@1wt.eu>
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

On Thu, 2013-04-11 at 17:32 +0200, Willy Tarreau wrote:
> On Thu, Apr 11, 2013 at 05:27:03PM +0200, Sebastian Hesselbarth wrote:
> > I don't have a strong opinion on whether Soeren's or your proposal should
> > be submitted. But I insist on having one of them in, as GRO significantly
> > improves the common use case, is enabled by default, and not as
> > constrained as LRO.
> 
> I agree, use yours first, but we should keep an eye on this. Since you have
> everything to run a test, please try to see if you can get netperf to run
> over IPv6, I'm sure the NIC doesn't handle it.

Willy, testing the checksum in the NIC driver itself prevents the stack
doing GRO even if the NIC could not checksum the packet, as in GRE
tunneling for example.

So Sebastien patch is better IMHO : Just call the napi gro handler and
let core stack handles the details ;)
