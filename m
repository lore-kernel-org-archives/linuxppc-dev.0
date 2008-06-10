Return-Path: <rdreier@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2.cisco.com [171.71.176.71])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-2.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EEDE4DDF51
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 05:05:59 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: MMIO and gcc re-ordering issue
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0806031153360.3473@woody.linux-foundation.org>
	<200806101656.51211.nickpiggin@yahoo.com.au>
	<200806101041.28829.jbarnes@virtuousgeek.org>
	<1213121426.8536.7.camel@localhost.localdomain>
Date: Tue, 10 Jun 2008 12:05:55 -0700
In-Reply-To: <1213121426.8536.7.camel@localhost.localdomain> (James
	Bottomley's message of "Tue, 10 Jun 2008 13:10:26 -0500")
Message-ID: <adaskvl3yb0.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	Trent Piepho <tpiepho@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > me too.  That's the whole basis for readX_relaxed() and its cohorts: we
 > make our weirdest machines (like altix) conform to the x86 norm.  Then
 > where it really kills us we introduce additional semantics to selected
 > drivers that enable us to recover I/O speed on the abnormal platforms.

Except as I pointed out before, Altix doesn't conform to the norm and
many (most?) drivers are missing mmiowb()s that are needed for Altix.
Just no one has plugged most devices into an Altix (or haven't stressed
the driver in a way that exposes problems of IO ordering between CPUs).

It would be a great thing to use the powerpc trick of setting a flag
that is tested by spin_unlock()/mutex_unlock() and automatically doing
the mmiowb() if needed, and then killing off mmiowb() entirely.

 - R.
