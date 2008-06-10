Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-130.bluehost.com (outbound-mail-130.bluehost.com
	[67.222.38.30]) by ozlabs.org (Postfix) with SMTP id 9D749DE196
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 05:20:27 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 10 Jun 2008 12:19:34 -0700
References: <1211852026.3286.36.camel@pasglop>
	<1213121426.8536.7.camel@localhost.localdomain>
	<adaskvl3yb0.fsf@cisco.com>
In-Reply-To: <adaskvl3yb0.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101219.34995.jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday, June 10, 2008 12:05 pm Roland Dreier wrote:
>  > me too.  That's the whole basis for readX_relaxed() and its cohorts: we
>  > make our weirdest machines (like altix) conform to the x86 norm.  Then
>  > where it really kills us we introduce additional semantics to selected
>  > drivers that enable us to recover I/O speed on the abnormal platforms.
>
> Except as I pointed out before, Altix doesn't conform to the norm and
> many (most?) drivers are missing mmiowb()s that are needed for Altix.
> Just no one has plugged most devices into an Altix (or haven't stressed
> the driver in a way that exposes problems of IO ordering between CPUs).
>
> It would be a great thing to use the powerpc trick of setting a flag
> that is tested by spin_unlock()/mutex_unlock() and automatically doing
> the mmiowb() if needed, and then killing off mmiowb() entirely.

Yeah I think that's what Nick's guidelines would guarantee.  And Jes is 
already working on the spin_unlock change you mentioned, so mmiowb() should 
be history soon (in name only, assuming Nick also introduces the I/O barriers 
he talked about for ordering the looser accessors it would still be there but 
would be called io_wmb or something).

Jesse
