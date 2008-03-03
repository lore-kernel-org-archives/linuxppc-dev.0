Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2FADDDF16
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 21:10:54 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] add strncmp to PowerPC
References: <1204301097.14759.6.camel@localhost.localdomain>
	<1204340690.15052.457.camel@pasglop>
	<Pine.LNX.4.58.0802292250490.21555@gandalf.stny.rr.com>
	<20080303095443.GB27105@iram.es>
Date: Mon, 03 Mar 2008 11:10:27 +0100
In-Reply-To: <20080303095443.GB27105@iram.es> (Gabriel Paubert's message of
	"Mon\, 3 Mar 2008 10\:54\:43 +0100")
Message-ID: <je4pbow224.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert <paubert@iram.es> writes:

> Now that I think a bit more about it, I believe that the C version is
> incorrect: the clrldi/extsb dance takes a value between -255 and +255
> and collapses it into the -128 to 127 range, meaning that the return
> value may be wrong if we rely on the sign of the result. So unless I
> miss something, the problem is much more serious than just stupid code
> (I had just a look at the libc version in C and characters are cast to
> unsigned char before the comparison).

The latter is explicitly required by the C standard.  Ie. even if your
characters are signed they are always compared as unsigned by
strcmp/strncmp/memcmp.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
