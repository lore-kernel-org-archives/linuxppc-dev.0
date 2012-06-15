Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
 [151.189.21.45])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "mx.arcor.de", Issuer "Thawte SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83E34B7083
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 22:58:16 +1000 (EST)
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net
 [151.189.8.29]) by mx.arcor.de (Postfix) with ESMTP id A92149A258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 14:58:10 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net
 [151.189.21.55])
 by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 9B9F21DF17A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 14:58:10 +0200 (CEST)
Received: from webmail13.arcor-online.net (webmail13.arcor-online.net
 [151.189.8.66])
 by mail-in-15.arcor-online.net (Postfix) with ESMTP id 96B2D1276C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 14:58:10 +0200 (CEST)
Date: Fri, 15 Jun 2012 14:58:10 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: linuxppc-dev@lists.ozlabs.org
Message-ID: <1751605717.59698.1339765090606.JavaMail.ngmail@webmail13.arcor-online.net>
Subject: [MPC5200] using GPT's for interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I currently try to use a MPC5200B GPT as interrupt source, which according to the comment at the start of arch/powerpc/platforms/52xx/mpc52xx_gpt.c is possible if the "interrupt-controller" and "#interrupt-cells = < 1 >" properties are added to the device tree node.

Apparently, /some/ work is done during startup, as I can see in the boot log:

[    0.438623] gpiochip_find_base: found new base at 251
[    0.444202] mpc52xx-gpt f0000650.timer: mpc52xx_gpt_irq_setup() complete. virq=78

In my driver, I identify the GPT node, call irq_of_parse_and_map() to get the irq number (which succeeds, with the same number as above), but unfortunately request_irq() or devm_request_irq() for this irq fail with error -22.  I tracked the failed call down to request_threaded_irq() which ejects because irq_settings_can_request(desc) returns false.

Before digging deeper into the code, maybe someone can tell me what I missed...  I'm using kernel 3.2.16.

Thanks in advance,
Albrecht.
