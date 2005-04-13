Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0EB8E67B58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 15:13:29 +1000 (EST)
Date: Tue, 12 Apr 2005 22:13:26 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Daniel Ann <ktdann@gmail.com>
Message-ID: <20050413051326.GA12632@gate.ebshome.net>
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412161230.GA18567@gate.ebshome.net>
	<9b7ca657050412215025872ce3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9b7ca657050412215025872ce3@mail.gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Trying to understand alloc_skb()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2005 at 01:50:05PM +0900, Daniel Ann wrote:
> On 4/13/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> > You don't need any locks, just pass correct gfp_mask parameter to
> > alloc_skb when it's called from IRQ context, e.g. GFP_ATOMIC.
> 
> Thing is, I'm not actually calling alloc_skb directly from my
> function. I'm calling notifier_call_chain() and somehow inadvertently
> it is getting called. If I was to give GFP_ATOMIC, then I'd have to
> first find the code that is responsible.

Then do it. It should be trivial to unwind the stack and much simpler 
than moving this code to process context.

> Reading what John said earlier, rather than trying to find the code
> that is calling alloc_skb, I should be moving the calls to my
> fnuctions into process context.

I think it's a bad idea. You are trying to workaround a problem 
instead of fixing it. My experience shows that sooner or later it'll 
come back and hit you anyway :).

-- 
Eugene
