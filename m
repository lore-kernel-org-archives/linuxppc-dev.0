Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01F39DDE9B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 02:14:52 +1000 (EST)
Date: Thu, 23 Aug 2007 09:14:42 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: wmb vs mmiowb
In-Reply-To: <20070823035448.GG18788@wotan.suse.de>
Message-ID: <alpine.LFD.0.999.0708230913470.30176@woody.linux-foundation.org>
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
	<200708221202.12403.jesse.barnes@intel.com>
	<20070823022043.GB18788@wotan.suse.de>
	<alpine.LFD.0.999.0708221953360.30176@woody.linux-foundation.org>
	<20070823035448.GG18788@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linux-ia64@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 23 Aug 2007, Nick Piggin wrote:
> 
> OK, but we'd have some kind of functions that are called not to
> serialise the CPUs, but to serialise the IO. It would be up to
> the calling code to already provide CPU synchronisation.
> 
> serialize_io(); / unserialize_io(); / a nicer name

We could call it "mmiowb()", for example?

Radical idea, I know.

> If we could pass in some kind of relevant resoure (eg. the IO
> memory or device or something), then we might even be able to
> put debug checks there to ensure two CPUs are never inside the
> same critical IO section at once.

We could certainly give it the spinlock as an argument.

		Linus
