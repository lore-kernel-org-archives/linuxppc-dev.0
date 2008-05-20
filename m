Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5013FDDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:01:03 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
Date: Wed, 21 May 2008 00:00:51 +0200
In-Reply-To: <1211316025-29069-1-git-send-email-tpiepho@freescale.com> (Trent
	Piepho's message of "Tue, 20 May 2008 13:40:25 -0700")
Message-ID: <jeiqx83ab0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho <tpiepho@freescale.com> writes:

> For the LE versions, eventually they boil down to an asm that will look
> something like this:
> asm("sync; stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
>
> While not perfect, this appears to be the best one can do.  The issue is
> that the "stwbrx" instruction only comes in an indexed, or 'x', version, in
> which the address is represented by the sum of two registers (the "0,%2").
> Unfortunately, gcc doesn't have a constraint for an indexed memory
> reference.

There is the "Z" constraint, which matches either an indirect or an
indexed memory address.  That should fit here.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
