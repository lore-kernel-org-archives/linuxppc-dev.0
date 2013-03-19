Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0F762C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 01:55:14 +1100 (EST)
Received: from mail216-co1 (localhost [127.0.0.1])	by
 mail216-co1-R.bigfish.com (Postfix) with ESMTP id B4FFE4400D9	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 14:55:09 +0000 (UTC)
Received: from CO1EHSMHS031.bigfish.com (unknown [10.243.78.231])	by
 mail216-co1.bigfish.com (Postfix) with ESMTP id AE072480056	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 14:55:07 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Wood
 Scott-B07421 <B07421@freescale.com>
Subject: using request_irq_percpu()
Date: Tue, 19 Mar 2013 14:55:05 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D065F508E@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

request_irq_percpu() is defined in kernel/irq/manage.c, this takes a percpu=
 pointer which will be unique based upon on which cpu the handler executes.

So, it looks like we can use this to have multiple bottom half interrupt ha=
ndler executing at same time on different CPU and each can handle this inde=
pendently.

Flow will be like:
-- Interrupt occurs on CPU1 - handler save some context for bottom half and=
 then clears the interrupt condition, and return (in between the interrupt =
affinity will be moved to next CPU in round robin fashion).

-- CPU 1 executing its bottom half.

-- Again interrupt occurs, which will come on CPU 2

-- CPU 2 handler similar to CPU1 and so on.

This way multiple similar bottom half can run at same time on different CPU

Thanks
-Bharat
