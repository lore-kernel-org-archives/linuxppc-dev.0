Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g4y34fdmzF152
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 13:40:27 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id a13-v6so20554770pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 20:40:27 -0700 (PDT)
Date: Tue, 8 May 2018 13:40:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback
 from console code
Message-ID: <20180508134013.472b7981@roar.ozlabs.ibm.com>
In-Reply-To: <87wowfbvm0.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
 <20180430145558.4308-5-npiggin@gmail.com>
 <87muxg80ga.fsf@concordia.ellerman.id.au>
 <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
 <87wowfbvm0.fsf@concordia.ellerman.id.au>
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

On Mon, 07 May 2018 20:36:39 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Fri, 04 May 2018 15:16:37 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:  
> >> Nicholas Piggin <npiggin@gmail.com> writes:  
> >> > Use the more refined and tested event polling loop from opal_put_chars
> >> > as the fallback console flush in the opal-kmsg path. This loop is used
> >> > by the console driver today, whereas the opal-kmsg fallback is not
> >> > likely to have been used for years.
> >> >
> >> > Use WARN_ONCE rather than a printk when the fallback is invoked to
> >> > prepare for moving the console flush into a common function.    
> >> 
> >> Do we want to add a WARN in that path? If we're panicking things might
> >> get worse if we WARN (which takes a trap).  
> >
> > True, probably a good idea not to... oh there's a printk_once so
> > that'll work nicely.  
> 
> Cool.
> 
> I have this series in a tree so you can send me an incremental diff if
> it's reasonably small.

It's a one liner (also moved location of message back to where it was
originally).

The next patch will clash because it moves this over into opal.c, so
you'd have to fix that by hand.

Thanks,
Nick

---
 arch/powerpc/platforms/powernv/opal-kmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
index fd2bbf4fd6dc..c610ef3541aa 100644
--- a/arch/powerpc/platforms/powernv/opal-kmsg.c
+++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
@@ -53,12 +53,12 @@ static void force_opal_console_flush(struct kmsg_dumper *dumper,
 	} else {
 		__be64 evt;
 
-		WARN_ONCE(1, "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		/*
 		 * If OPAL_CONSOLE_FLUSH is not implemented in the firmware,
 		 * the console can still be flushed by calling the polling
 		 * function while it has OPAL_EVENT_CONSOLE_OUTPUT events.
 		 */
+		printk_once(KERN_NOTICE "opal: OPAL_CONSOLE_FLUSH missing.\n");
 		do {
 			opal_poll_events(&evt);
 		} while (be64_to_cpu(evt) & OPAL_EVENT_CONSOLE_OUTPUT);
-- 
2.17.0
