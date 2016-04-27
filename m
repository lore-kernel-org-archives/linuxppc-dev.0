Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvgsL57TJzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 10:32:38 +1000 (AEST)
Received: by mail-pa0-x22f.google.com with SMTP id bt5so12558858pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:32:38 -0700 (PDT)
Date: Wed, 27 Apr 2016 09:34:09 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 4/4] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160427003409.GA4782@swordfish>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-5-git-send-email-pmladek@suse.com>
 <20160423034924.GA535@swordfish>
 <20160426142157.GK2749@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426142157.GK2749@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (04/26/16 16:21), Petr Mladek wrote:
[..]
> > move printk_nmi_flush_on_panic() to printk.c, and place it next to
> > printk_flush_on_panic() (so we will have two printk "flush-on-panic"
> > functions sitting together). /* printk_nmi_flush() is in printk.h,
> > so it's visible to printk anyway */
> > 
> > it also will let us keep logbuf_lock static, it's a bit too internal
> > to printk to expose it, I think.
> > 
> > IOW, something like this?
> 
> It is rather cosmetic change. I 

oh yes, it is. just to keep similar functionality (flush, zap locks)
in one place (printk).

	-ss
