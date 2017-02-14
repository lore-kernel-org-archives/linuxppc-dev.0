Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN73X4L0kzDq8t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 03:22:00 +1100 (AEDT)
Date: Tue, 14 Feb 2017 19:21:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: alistair@popple.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] powernv/opal: Convert opal message events to opal irq
 domain
Message-ID: <20170214162128.GA31029@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Alistair Popple,

The patch a295af24d0d2: "powernv/opal: Convert opal message events to
opal irq domain" from May 15, 2015, leads to the following static
checker warning:

	arch/powerpc/platforms/powernv/opal.c:297 opal_message_init()
	info: return a literal instead of 'irq'

arch/powerpc/platforms/powernv/opal.c
   286  static int __init opal_message_init(void)
   287  {
   288          int ret, i, irq;
   289  
   290          for (i = 0; i < OPAL_MSG_TYPE_MAX; i++)
   291                  ATOMIC_INIT_NOTIFIER_HEAD(&opal_msg_notifier_head[i]);
   292  
   293          irq = opal_event_request(ilog2(OPAL_EVENT_MSG_PENDING));
   294          if (!irq) {
   295                  pr_err("%s: Can't register OPAL event irq (%d)\n",
   296                         __func__, irq);
   297                  return irq;

This code doesn't really make sense.  I'm not really certain what it
should be...

   298          }
   299  
   300          ret = request_irq(irq, opal_message_notify,
   301                          IRQ_TYPE_LEVEL_HIGH, "opal-msg", NULL);
   302          if (ret) {
   303                  pr_err("%s: Can't request OPAL event irq (%d)\n",
   304                         __func__, ret);
   305                  return ret;
   306          }
   307  
   308          return 0;
   309  }

regards,
dan carpenter
