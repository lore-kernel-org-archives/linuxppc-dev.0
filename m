Return-Path: <ktdann@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id AA8D567B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 14:50:09 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id a36so97325rnf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 21:50:05 -0700 (PDT)
Message-ID: <9b7ca657050412215025872ce3@mail.gmail.com>
Date: Wed, 13 Apr 2005 13:50:05 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Daniel Ann <ktdann@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050412161230.GA18567@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412161230.GA18567@gate.ebshome.net>
Subject: Re: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/13/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> You don't need any locks, just pass correct gfp_mask parameter to
> alloc_skb when it's called from IRQ context, e.g. GFP_ATOMIC.

Thing is, I'm not actually calling alloc_skb directly from my
function. I'm calling notifier_call_chain() and somehow inadvertently
it is getting called. If I was to give GFP_ATOMIC, then I'd have to
first find the code that is responsible.

Reading what John said earlier, rather than trying to find the code
that is calling alloc_skb, I should be moving the calls to my
fnuctions into process context.

So.. I'm gonna go ahead with John's suggestion.. but only problem now
is how do I move it to process context :P (May be more importantly,
how do I know that the code needs to be in process context or not?
which will prevent further headaches and possible coding a time bomb
:) )

--=20
Daniel
