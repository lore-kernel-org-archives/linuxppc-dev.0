Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 503C467B43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 07:15:45 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Base address of executables - weirdness?
References: <4485A279.4050403@zytor.com>
Date: Tue, 06 Jun 2006 23:15:36 +0200
In-Reply-To: <4485A279.4050403@zytor.com> (H. Peter Anvin's message of "Tue,
	06 Jun 2006 08:42:49 -0700")
Message-ID: <jeirne56kn.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Until recently, binaries linked with ld defaulted to a base address of 
> 0x10000000+SIZEOF_HEADERS.  However, recently I've gotten a couple of 
> reports -- and I've been able to confirm this on my FC5 system -- that 
> some versions of ld links at 0x01800000+SIZEOF_HEADERS.

You are probably using the wrong linker emulation.  There are three
emulations enabled when building binutils for ppc-linux, but only the
elf32ppclinux emulation it the right one that uses 0x10000000 for the base
address.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
