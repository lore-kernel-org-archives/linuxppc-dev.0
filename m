Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id 8990DB7CF5
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 11:49:32 +1000 (EST)
Date: Sun, 11 Apr 2010 10:47:51 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: A better way to sequence driver initialization?
Message-ID: <20100411014751.GB16099@linux-sh.org>
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
	<4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
	<k2ufa686aa41004101647md1e8cfbfw85c5b98b9613cd2d@mail.gmail.com>
	<4BC12701.7000208@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BC12701.7000208@billgatliff.com>
Cc: linux-embedded <linux-embedded@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 10, 2010 at 08:33:53PM -0500, Bill Gatliff wrote:
> Grant Likely wrote:
> > On Sat, Apr 10, 2010 at 5:39 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> >   
> >> In cases where you can specifically note that dependencies, doing so will
> >> save you a world of pain. Despite that, it's simply not possible to do
> >> this as a free-for-all. Devices or busses that can tolerate multi-threaded
> >> probing need to be converted over one at a time, but even then you still
> >> need the dependency tracking for those that depend on link order today.
> >>     
> 
> Who's to say a function like gpio_request_wait_for_it(GPIO_NUMBER,
> "dependent-driver") isn't the way to do the dependency tracking?  I
> can't even implement that without a context that can sleep...
> 
In some cases that might be valid, but there are many cases where drivers
can reconfigure their capability sets based on which GPIOs are and aren't
available. Just because a pin isn't available doesn't make it a
show-stopper for the probe path..
