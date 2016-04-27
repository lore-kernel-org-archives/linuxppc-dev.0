Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvvvV6tMvzDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 19:35:18 +1000 (AEST)
Date: Wed, 27 Apr 2016 10:34:38 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Chris Metcalf <cmetcalf@ezchip.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Miller <davem@davemloft.net>
Subject: Re: [PATCH v5 2/4] printk/nmi: warn when some message has been lost
 in NMI context
Message-ID: <20160427093438.GK19428@n2100.arm.linux.org.uk>
References: <1461239325-22779-1-git-send-email-pmladek@suse.com>
 <1461239325-22779-3-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461239325-22779-3-git-send-email-pmladek@suse.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2016 at 01:48:43PM +0200, Petr Mladek wrote:
> @@ -64,8 +65,10 @@ static int vprintk_nmi(const char *fmt, va_list args)
>  again:
>  	len = atomic_read(&s->len);
>  
> -	if (len >= sizeof(s->buffer))
> +	if (len >= sizeof(s->buffer)) {
> +		atomic_inc(&nmi_message_lost);

This should be fine - I think its reasonable to expect that no one is
using a spinlock implementation for their atomic ops for this...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
