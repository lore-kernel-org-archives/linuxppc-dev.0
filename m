Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 27743B7232
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2011 05:07:11 +1100 (EST)
Received: from mail34-db3 (localhost [127.0.0.1])	by mail34-db3-R.bigfish.com
 (Postfix) with ESMTP id 7B3B658009B	for <linuxppc-dev@ozlabs.org>;
 Fri, 18 Nov 2011 18:06:50 +0000 (UTC)
Received: from DB3EHSMHS017.bigfish.com (unknown [10.3.81.245])	by
 mail34-db3.bigfish.com (Postfix) with ESMTP id 62507340226	for
 <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 18:06:50 +0000 (UTC)
Date: Fri, 18 Nov 2011 12:06:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-ID: <20111118180651.GC28562@schlenkerla.am.freescale.net>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
 <20111117213733.GC14736@schlenkerla.am.freescale.net>
 <4EC586B2.5060604@freescale.com>
 <20111117222515.GA18827@schlenkerla.am.freescale.net>
 <4EC58AA0.2070905@freescale.com>
 <20111117224558.GA18848@schlenkerla.am.freescale.net>
 <4EC68F14.9020206@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4EC68F14.9020206@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2011 at 11:00:04AM -0600, Timur Tabi wrote:
> Scott Wood wrote:
> >> > How do I update the device tree from platform code?
> 
> > prom_update_property()
> 
> I assume this needs to be called after the DT has been unflattened,
> since it takes a device_node* as a parameter.  Is there any way I can
> modify the tree before it's unflattened?  I'd like to fixup the tree in
> an early_param() function.

What's wrong with doing it in setup_arch()?

Modifying a flat device tree is a more complicated task, and the kernel's
code is read-only.  It's not worth bringing libfdt or similar complexity
in for this, when there are other alternatives.

If it really needs to be done early, consider doing it from U-Boot.  The
bootwrapper would be a decent place as well, but we probably shouldn't
require its use just for this.

-Scott
