Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA365DE14A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 00:46:41 +1000 (EST)
Date: Wed, 11 Jun 2008 07:46:03 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806111500.30789.nickpiggin@yahoo.com.au>
Message-ID: <alpine.LFD.1.10.0806110736500.3101@woody.linux-foundation.org>
References: <1211852026.3286.36.camel@pasglop>
	<200806101656.51211.nickpiggin@yahoo.com.au>
	<18511.21025.978328.596571@cargo.ozlabs.ibm.com>
	<200806111500.30789.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, scottwood@freescale.com,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 11 Jun 2008, Nick Piggin wrote:
> 
> I can't actually find the definitive statement in the Intel manuals
> saying UC is strongly ordered also WRT WB. Linus?

Definitive? Dunno. But look in the Architecture manual, volume 3A, 10.3 
"Methods of Caching Available", and then under the bullet about Write 
Combining (WC), it says

  the writes may be delayed until the next occurrence of a serializing 
  event; such as, an SFENCE of MFENCE instruction, CPUID execution, a read 
  or write to uncached memory, an interrupt occurrence, or a LOCK 
  instruction execution.

However, it's worth noting that

 - documentation can be wrong, or even if right, can be Intel-specific.

 - the above is expressly _only_ about the WC buffer, not about regular 
   memory writes. Cached memory accesses are different from WC accesses.

so in the end, the thing that matters is how things actually work.

		Linus
