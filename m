Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 3379D2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 May 2013 14:04:48 +1000 (EST)
Date: Sat, 25 May 2013 21:04:41 -0700 (PDT)
Message-Id: <20130525.210441.818472895703230779.davem@davemloft.net>
To: sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address
 workaround on DT ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Wed, 22 May 2013 22:04:01 +0200

> +			memcpy((void *)p->value, reg, 6);

This cast is completely unnecessary, non-void to void pointer casts
are automatic.

If it is necessary, because p->value is const, then you are trying
to change something behind the OF layer's back and need to use
the appropriate interface to change the property contents.
