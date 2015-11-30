Return-Path: <yalin.wang2010@gmail.com>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B6091A0075
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 03:42:20 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so189746060pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 08:42:18 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
From: yalin wang <yalin.wang2010@gmail.com>
In-Reply-To: <1448622572-16900-6-git-send-email-pmladek@suse.com>
Date: Mon, 30 Nov 2015 08:42:04 -0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org
Message-Id: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
To: Petr Mladek <pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> 
> Testing has shown that the backtrace sometimes does not fit
> into the 4kB temporary buffer that is used in NMI context.
> 
> The warnings are gone when I double the temporary buffer size.
> 
> Note that this problem existed even in the x86-specific
> implementation that was added by the commit a9edc8809328
> ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> Nobody noticed it because it did not print any warnings.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> kernel/printk/nmi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> index 8af1e4016719..6111644d5f01 100644
> --- a/kernel/printk/nmi.c
> +++ b/kernel/printk/nmi.c
> @@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
> struct nmi_seq_buf {
> 	atomic_t		len;	/* length of written data */
> 	struct irq_work		work;	/* IRQ work that flushes the buffer */
> -	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> +	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
> 				       sizeof(struct irq_work)];
> };
> 

why not define like this:

union {
struct {atomic_t		len;	
	struct irq_work		work;
}
unsigned char		buffer[PAGE_SIZE * 2] ;
}

we can make sure the union is 2 PAGE_SIZE .

Thanks
