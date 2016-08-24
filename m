Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK79503YKzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 23:15:52 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so1245245pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 06:15:52 -0700 (PDT)
Message-ID: <1472044549.14381.73.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [PATCH 1/3] net: fs_enet: merge NAPI RX and NAPI TX
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>, Vitaly Bordug
 <vbordug@ru.mvista.com>, davem@davemloft.net, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Date: Wed, 24 Aug 2016 06:15:49 -0700
In-Reply-To: <1472044021.14381.71.camel@edumazet-glaptop3.roam.corp.google.com>
References: <cover.1472033140.git.christophe.leroy@c-s.fr>
 <c607324b1322bb5729081808b2f54f5f9da52444.1472033140.git.christophe.leroy@c-s.fr>
 <1472044021.14381.71.camel@edumazet-glaptop3.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-24 at 06:07 -0700, Eric Dumazet wrote:

> I am afraid you could live lock here on SMP.
> 
> You should make sure you do not loop forever, not assuming cpu is faster
> than NIC.

You are protected by the tx_lock spinlock, but this is fragile as you
could very well remove this spinlock in the future to get lockless
transmit, like many other drivers.
