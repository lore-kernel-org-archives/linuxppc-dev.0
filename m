Return-Path: <SRS0=kAy7=4D=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDKBm1VtNzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 00:31:28 +1000 (AEST)
Date: Thu, 27 Apr 2017 10:31:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Russell
 King <rmk+kernel@arm.linux.org.uk>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>, Ingo Molnar
 <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Metcalf
 <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Jan Kara <jack@suse.cz>, Ralf Baechle
 <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, David Miller
 <davem@davemloft.net>
Subject: Re: [PATCH v5 1/4] printk/nmi: generic solution for safe printk in NMI
Message-ID: <20170427103118.56351d30@gandalf.local.home>
In-Reply-To: <20170427133819.GW3452@pathway.suse.cz>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-2-git-send-email-pmladek@suse.com>
 <20170419131341.76bc7634@gandalf.local.home>
 <20170420033112.GB542@jagdpanzerIV.localdomain>
 <20170420131154.GL3452@pathway.suse.cz>
 <20170421015724.GA586@jagdpanzerIV.localdomain>
 <20170421120627.GO3452@pathway.suse.cz>
 <20170424021747.GA630@jagdpanzerIV.localdomain>
 <20170427133819.GW3452@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 27 Apr 2017 15:38:19 +0200
Petr Mladek <pmladek@suse.com> wrote:

> > by the way,
> > does this `nmi_print_seq' bypass even fix anything for Steven?  
> 
> I think that this is the most important question.
> 
> Steven, does the patch from
> https://lkml.kernel.org/r/20170420131154.GL3452@pathway.suse.cz
> help you to see the debug messages, please?

You'll have to wait for a bit. The box that I was debugging takes 45
minutes to reboot. And I don't have much more time to play on it before
I have to give it back. I already found the bug I was looking for and
I'm trying not to crash it again (due to the huge bring up time).

When I get a chance, I'll see if I can insert a trigger to crash the
kernel from NMI on another box and see if this patch helps.

Thanks,

-- Steve
