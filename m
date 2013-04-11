Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3C2A2C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 01:27:07 +1000 (EST)
Received: by mail-ob0-f181.google.com with SMTP id wo10so1508479obc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 08:27:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130411150326.GA19978@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
Date: Thu, 11 Apr 2013 17:27:03 +0200
Message-ID: <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 5:03 PM, Willy Tarreau <w@1wt.eu> wrote:
> On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
>> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
>> the initial
>> patch (Soeren) and your proposed patch (Willy). The results show that
>> both patches
>> allow a significant increase in throughput compared to
>> netif_receive_skb (!gro, !lro)
>> alone. Having gro with lro disabled gives some 2% more throughput
>> compared to lro only.
>
> Indeed this is consistent with my memories, since Eric improved the
> GRO path, it became faster than LRO on this chip.

I don't have a strong opinion on whether Soeren's or your proposal should
be submitted. But I insist on having one of them in, as GRO significantly
improves the common use case, is enabled by default, and not as
constrained as LRO.

Sebastian
