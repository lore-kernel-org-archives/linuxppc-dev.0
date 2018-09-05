Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4252hF6mqVzF36T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:14:53 +1000 (AEST)
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so3383336pfk.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 05:14:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jiri Slaby <jslaby@suse.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Matteo Croce <mcroce@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Leon Romanovsky <leonro@mellanox.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org (op)
Subject: [PATCH 0/3] tty: hvc: latency break regression fixes
Date: Wed,  5 Sep 2018 22:14:36 +1000
Message-Id: <20180905121439.23809-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Greg,

Here are fixes for a few regressions that came in with my
carelessness with the irq latency work for the hvc subsystem.
These were independently reported in 2 configurations, and I
confirmed with another.

I think those went upstream via Michael's tree, but he's away
at the moment so if you would be able to consider them for
the tty tree that would be appreciated.

Thanks,
Nick

Nicholas Piggin (3):
  tty: hvc: hvc_poll() fix read loop hang
  tty: hvc: hvc_poll() fix read loop batching
  tty: hvc: hvc_write() fix break condition

 drivers/tty/hvc/hvc_console.c | 38 ++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.18.0
