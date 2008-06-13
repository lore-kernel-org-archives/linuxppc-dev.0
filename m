Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 25A2BDDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:57:33 +1000 (EST)
Date: Fri, 13 Jun 2008 18:57:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 1/2] [POWERPC] CPM2: Implement GPIO LIB API on CPM2
	Freescale SoC.
Message-ID: <20080613145730.GA27615@polina.dev.rtsoft.ru>
References: <4808D75B.9000002@scram.de>
	<200806131446.27552.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200806131446.27552.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 13, 2008 at 02:46:20PM +0200, Laurent Pinchart wrote:
> On Friday 18 April 2008 19:16, Jochen Friedrich wrote:
> > Based on earlier work by Laurent Pinchart.
> > 
> > This patch implement GPIO LIB support for the CPM2 GPIOs.
> > 
> > Signed-off-by: Jochen Friedrich <jochen@scram.de>
> > Cc: Laurent Pinchart <laurentp@cse-semaphore.com>
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> 
> Is there any showstopper or can this one be applied to powerpc-next ?

One comment below.

[...]
> > +	mm_gc->save_regs = cpm2_gpio32_save_regs;
> > +	of_gc->gpio_cells = 1;

I would strongly suggest to use gpio_cells = 2, otherwise you will not
able to pass GPIO flags (such as active-low etc) without breaking the
compatibility with older trees.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
