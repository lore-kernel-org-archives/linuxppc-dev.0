Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E34E1DE36F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 03:08:07 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating
	point	registers in thread_struct.
References: <20080625040718.028B470296@localhost.localdomain>
	<F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
	<48626588.8050202@freescale.com> <20080625161255.GA12165@iram.es>
Date: Wed, 25 Jun 2008 19:08:00 +0200
In-Reply-To: <20080625161255.GA12165@iram.es> (Gabriel Paubert's message of
	"Wed, 25 Jun 2008 18:12:55 +0200")
Message-ID: <jetzfhigsv.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert <paubert@iram.es> writes:

> On Wed, Jun 25, 2008 at 10:34:32AM -0500, Scott Wood wrote:
>> Kumar Gala wrote:
>> >>+/* Macros to workout the correct index for the FPR in the thread 
>> >>struct */
>> >>+#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
>> >>+#define FPRHALF(i) (((i) - PT_FPR0) % 2)
>> >
>> >Have you looked at what the compiler spits out here to make sure we 
>> >aren't getting a divide?  Seems like we could use '& 0x1'.
>> 
>> GCC's not *that* dumb.  However, you may get some unnecessary 
>> sign-twiddling if "i" is signed.
>
> Not for modulo 2, it's only an even/odd choice

That's wrong.  -1 % 2 == -1, 1 % 2 == 1.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
