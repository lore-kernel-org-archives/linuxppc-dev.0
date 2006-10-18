Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 1004C67C44
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 00:52:11 +1000 (EST)
Subject: Re: [PATCH -rt] powerpc update
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061018143318.GB25141@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
	<20061018072858.GA29576@elte.hu>
	<1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<20061018143318.GB25141@elte.hu>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 07:52:08 -0700
Message-Id: <1161183128.23082.43.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-18 at 16:33 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Wed, 2006-10-18 at 09:28 +0200, Ingo Molnar wrote:
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > Pay close attention to the fasteoi interrupt threading. I added usage 
> > > > of mask/unmask instead of using level handling, which worked well on 
> > > > PPC.
> > > 
> > > this is wrong - it should be doing mask+ack.
> > 
> > The main reason I did it this way is cause the current threaded eoi 
> > expected the line to be masked. So if you happen to have a eoi that's 
> > threaded you get a warning then the interrupt hangs.
> 
> does that in fact happen on -rt6? If yes, could you send the warning 
> that is produced?
> 
> 	Ingo

The warning was the WARN_ON_ONCE from the section below (which is gone
is -rt6)

        if (redirect_hardirq(desc)) {
-               WARN_ON_ONCE(1);
+               mask_ack_irq(desc, irq);
                goto out_unlock;
        }
+

I haven't tried it, but I'd think it will work. That's assuming you have
an "ack" which I hear some PowerPC don't (Benjamin Herrenschmidt talked
about having no "ack" when discussing fasteoi a few month back).

Daniel
