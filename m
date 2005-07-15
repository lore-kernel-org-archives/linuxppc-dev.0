Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F3E4F67CB1
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2005 04:22:58 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Frank van Maarseveen <frankvm@frankvm.com>
References: <20050715160115.GA22990@janus>
Date: Fri, 15 Jul 2005 20:22:53 +0200
In-Reply-To: <20050715160115.GA22990@janus> (Frank van Maarseveen's message of
	"Fri, 15 Jul 2005 18:01:15 +0200")
Message-ID: <jey88853pe.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: bug in arch/ppc/kernel/misc.S: __ashrdi3?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Frank van Maarseveen <frankvm@frankvm.com> writes:

> I don't really grok the code but an operand seems to be missing and the
> assembler makes something out of it I don't trust:
>
> _GLOBAL(__ashrdi3)
> 	...
> 	rlwinm  r8,r7,0,32      # t3 = (count < 32) ? 32 : 0

32 == 0x80000000 >> 26

> 00000000 <f>:
> f():
>    0:   54 e8 06 b4     rlwinm  r8,r7,0,26,26

The mask begins at bit 26 and ends at bit 26 (counted from the left).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
