Return-Path: <SRS0=N30B=BT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF65C433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 23:00:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F98206A2
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 23:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F98206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BPvhm3kTBzDqPM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 09:00:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=telegraphics.com.au (client-ip=98.124.60.144;
 helo=kvm5.telegraphics.com.au; envelope-from=fthain@telegraphics.com.au;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BPvfR0shszDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 08:58:54 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 07F1129B87;
 Sun,  9 Aug 2020 18:58:44 -0400 (EDT)
Date: Mon, 10 Aug 2020 08:58:43 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/9] macintosh/via-macii: Poll the device most likely to
 respond
In-Reply-To: <20200809185541.GA133779@roeck-us.net>
Message-ID: <alpine.LNX.2.23.453.2008100844450.8@nippy.intranet>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
 <5836f80886ebcfbe5be5fb7e0dc49feed6469712.1593318192.git.fthain@telegraphics.com.au>
 <20200809185541.GA133779@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 9 Aug 2020, Guenter Roeck wrote:

> Hi,
> 
> On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> > Poll the most recently polled device by default, rather than the lowest
> > device address that happens to be enabled in autopoll_devs. This improves
> > input latency. Re-use macii_queue_poll() rather than duplicate that logic.
> > This eliminates a static struct and function.
> > 
> > Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
> > Tested-by: Stan Johnson <userm57@yahoo.com>
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> With this patch applied, the qemu "q800" emulation no longer works and 
> is stuck in early boot. Any idea why that might be the case, and/or how 
> to debug it ?
> 

The problem you're seeing was mentioned in the cover letter,
https://lore.kernel.org/linux-m68k/cover.1593318192.git.fthain@telegraphics.com.au/

Since this series was merged, Linus' tree is no longer compatible with 
long-standing QEMU bugs.

The best way to fix this is to upgrade QEMU (latest is 5.1.0-rc3). Or use 
the serial console instead of the framebuffer console.

I regret the inconvenience but the alternative was worse: adding code to 
Linux to get compatibility with QEMU bugs (which were added to QEMU due to 
Linux bugs).

My main concern is correct operation on actual hardware, as always. But 
some QEMU developers are working on support for operating systems besides 
Linux.

Therefore, I believe that both QEMU and Linux should aim for compatibility 
with actual hardware and not bug compatibility with each other.
