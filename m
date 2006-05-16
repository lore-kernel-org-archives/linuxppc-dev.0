Return-Path: <walt.wimer@timesys.com>
Received: from postfix.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 07657679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 03:38:34 +1000 (EST)
Subject: Re: what does this mean?
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: "Steve Iribarne (GMail)" <netstv@gmail.com>
In-Reply-To: <b4b98b690605160951o5cefddd8t6b19a91a708f0431@mail.gmail.com>
References: <b4b98b690605160951o5cefddd8t6b19a91a708f0431@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 16 May 2006 13:38:26 -0400
Message-Id: <1147801106.14881.2.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-16 at 09:51 -0700, Steve Iribarne (GMail) wrote:
> My code is hitting in sched.c ->
> 
> 	if (unlikely(in_interrupt())) {
> 		printk("Scheduling in interrupt\n");
> 		BUG();
> 	}
> It is hitting this printk.  So is this telling me I'm calling schedule
> from within an interrupt?  How can this be?  Has anyone else seen
> something like this and can anyone give me a hint as to what to look
> for.

Check to make sure that in your interrupt handler you are not calling
something that can sleep.  E.g. sleep(), usleep(), kmalloc(), vmalloc(),
etc. 


> Thanks.
> -stv


Best regards,

Walt Wimer
TimeSys Corporation
