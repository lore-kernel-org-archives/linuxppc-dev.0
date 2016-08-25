Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKlmg2CJFzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 23:45:22 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 17218203DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 13:45:20 +0000 (UTC)
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com
 [209.85.213.169])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3DE51203B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 13:45:18 +0000 (UTC)
Received: by mail-yb0-f169.google.com with SMTP id a7so15331355ybi.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 06:45:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471918019-19472-4-git-send-email-haokexin@gmail.com>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
 <1471918019-19472-4-git-send-email-haokexin@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 25 Aug 2016 08:44:56 -0500
Message-ID: <CAL_JsqK42T1M3MO26p46K0zTuvGUAdMWAf4FHGVpAJgDa+SudQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] of/platform: introduce a generic way to declare a
 platform bus
To: Kevin Hao <haokexin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 22, 2016 at 9:06 PM, Kevin Hao <haokexin@gmail.com> wrote:
> The specific buses which need to be probed at boot time are different
> between platforms. Instead of put all the buses into the default
> of_default_bus_match_table[] match tables, this patch introduces a
> general way to declare a platform bus.

I'd prefer to not do this with linker sections if possible. Doesn't
PPC have machine descriptors that you could add the match table to? If
that table exists then arch_want_default_of_probe could return a
pointer to it.

Are there any platforms that work with the default match table? I'd be
fine with adding some strings to the default if that helps.

{ .type = "soc", },

device_type is deprecated for FDT, so this shouldn't be needed except
for really old stuff.

{ .compatible = "soc", },

Doesn't appear in kernel dts files. Could be out of tree or old ones?

{ .compatible = "simple-bus" },

Already handled.

{ .compatible = "gianfar" },

Seems like the children of this should be probed by the gianfar driver.

{ .compatible = "gpio-leds", },

I don't think this is needed.

{ .type = "qe", },

Again, deprecated.

{ .compatible = "fsl,qe", },

No issue to add this. Though, you could also probe it from mpc85xx_qe_init().

Rob
