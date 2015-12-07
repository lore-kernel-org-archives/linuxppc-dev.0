Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B2E11A0E5A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 01:16:53 +1100 (AEDT)
Date: Mon, 7 Dec 2015 15:16:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 5/5] printk/nmi: Increase the size of the temporary
 buffer
Message-ID: <20151207141646.GF20935@pathway.suse.cz>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-6-git-send-email-pmladek@suse.com>
 <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <81211733-2484-40A9-9D4A-644AA27FBC73@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 2015-11-30 08:42:04, yalin wang wrote:
> 
> > On Nov 27, 2015, at 19:09, Petr Mladek <pmladek@suse.com> wrote:
> > 
> > Testing has shown that the backtrace sometimes does not fit
> > into the 4kB temporary buffer that is used in NMI context.
> > 
> > The warnings are gone when I double the temporary buffer size.
> > 
> > Note that this problem existed even in the x86-specific
> > implementation that was added by the commit a9edc8809328
> > ("x86/nmi: Perform a safe NMI stack trace on all CPUs").
> > Nobody noticed it because it did not print any warnings.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> > kernel/printk/nmi.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/printk/nmi.c b/kernel/printk/nmi.c
> > index 8af1e4016719..6111644d5f01 100644
> > --- a/kernel/printk/nmi.c
> > +++ b/kernel/printk/nmi.c
> > @@ -42,7 +42,7 @@ atomic_t nmi_message_lost;
> > struct nmi_seq_buf {
> > 	atomic_t		len;	/* length of written data */
> > 	struct irq_work		work;	/* IRQ work that flushes the buffer */
> > -	unsigned char		buffer[PAGE_SIZE - sizeof(atomic_t) -
> > +	unsigned char		buffer[2 * PAGE_SIZE - sizeof(atomic_t) -
> > 				       sizeof(struct irq_work)];
> > };
> > 
> 
> why not define like this:
> 
> union {
> struct {atomic_t		len;	
> 	struct irq_work		work;
> }
> unsigned char		buffer[PAGE_SIZE * 2] ;
> }
> 
> we can make sure the union is 2 PAGE_SIZE .

IMHO, this would add more confusion. It would just move the
computation somewhere else. The union will have 2*PAGE_SIZE
but the beginning of "buffer" will be shared with "len"
and "work". Therefore, we would need to skip the beginning
of the buffer when storing the data. By other words, we still
will be able to use only (sizeof(buffer) - sizeof(atomic_t) -
sizeof(struct irq_work)] of the "buffer".

Or did I miss something, please?

Best Regards,
Petr
