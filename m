Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sxqFh3nrWzDvHV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Oct 2016 05:13:12 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
 Tejun Heo <tj@kernel.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Jiri Slaby <jslaby@suse.cz>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ivan Delalande <colona@arista.com>, Thierry Reding <treding@nvidia.com>,
 Borislav Petkov <bp@suse.de>, Jan Kara <jack@suse.com>,
 Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank Rowand <frowand.list@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] console: Don't prefer first registered if DT specifies
 stdout-path
References: <20160809125010.14150-1-paul.burton@imgtec.com>
 <20160809151937.26118-1-paul.burton@imgtec.com>
Date: Sun, 16 Oct 2016 20:07:18 +0200
In-Reply-To: <20160809151937.26118-1-paul.burton@imgtec.com> (Paul Burton's
 message of "Tue, 9 Aug 2016 16:19:37 +0100")
Message-ID: <87bmyk88x5.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Aug 09 2016, Paul Burton <paul.burton@imgtec.com> wrote:

> Fix this by not automatically preferring the first registered console if
> one is specified by the device tree. This allows consoles to be
> registered but not enabled, and once the driver for the console selected
> by stdout-path calls of_console_check() the driver will be added to the
> list of preferred consoles before any other console has been enabled.
> When that console is then registered via register_console() it will be
> enabled as expected.

This breaks the console on PowerMac.  There is no output and it panics
eventually.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
