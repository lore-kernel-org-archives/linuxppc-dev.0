Return-Path: <Geoff.Thorpe@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95AEBDE028
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:09:35 +1000 (EST)
Message-ID: <4A1C3059.40303@freescale.com>
Date: Tue, 26 May 2009 14:09:29 -0400
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
References: <1242761199-17875-1-git-send-email-timur@freescale.com>	<1242761199-17875-2-git-send-email-timur@freescale.com>	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>	<4A1C16DF.9090802@freescale.com>
	<4A1C20EA.5080603@freescale.com>
In-Reply-To: <4A1C20EA.5080603@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@freescale.com>,
	smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Geoff Thorpe wrote:
> 
>> So from this user's perspective (FWIW), it would come as a surprise if
>> the return value reflected the evaluated expression rather than what
>> happened w.r.t. the spin/timeout.
> 
> It shouldn't come as a surprise because I've thoroughly documented the behavior.  I also think returning the actual value of the expression is better than a return code.  Remember, the primary purpose of this macro is to wait for a hardware register to change.  Contrast this to wait_event_xxx, which usually queries a variable.  Therefore, the hardware register may set multiple bits.  For instance, you could do this:
> 
> ret = spin_event_timeout(in_be32(x) & 0x14, ...);
> 
> if (ret & 0x10)
> 	do something here
> 
> if (ret & 0x04)
> 	do something else here
> 
> I think the ability to do this is more important than making the code as similar as possible to wait_event_xxx.

I was just providing feedback after (recently) coming to grips with the
subtleties of similar assists in the kernel. Documentation helps when
you don't know what to expect - but if you're expecting a certain
behaviour (consistency of success==0), it's easy to misread the doc, or
just not read it at all.

BTW, your example above does not illustrate the use of the timeout, and
you'd have to infer it because the return value does not provide any
direct indication. As for access to the evaluated expression, I believe
the following is functionally equivalent;

rc = spin_event_timeout((ret = in_be32(x) & 0x14), ...);

You can ignore the return value if you don't care, which gives the same
thing as your original example, but with the 'ret' assignment inside the
spin call instead of outside it.

Anyway, just my $0.02 FWIW. I have no strongly-held opinion here,
especially as the closest precedent I know of is wait_event_timeout(),
which also does something unexpected, but it doesn't do the same
unexpected thing as your function does. :-) It's based on jiffies rather
than microseconds, and it returns zero if the timeout elapses otherwise
it returns the number of remaining jiffies when the condition evaluated
true.

Cheers,
Geoff
