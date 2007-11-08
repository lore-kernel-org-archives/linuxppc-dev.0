Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F43BDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 21:03:12 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] Modifying i2c-core to support alias driver names compatible
	with device trees
References: <9e4733910711061239g22b06863rbec37fcef138c869@mail.gmail.com>
	<20071108120535.769e4d73.sfr@canb.auug.org.au>
Date: Thu, 08 Nov 2007 11:03:04 +0100
In-Reply-To: <20071108120535.769e4d73.sfr@canb.auug.org.au> (Stephen
	Rothwell's message of "Thu\, 8 Nov 2007 12\:05\:35 +1100")
Message-ID: <jey7d9t5pj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, Tjernlund <tjernlund@tjernlund.se>,
	linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> On Tue, 6 Nov 2007 15:39:42 -0500 "Jon Smirl" <jonsmirl@gmail.com> wrote:
>>
>> It was requested to split this code out into a separate thread....
>> 
>> This code modifies the i2c-core to support lists of alias names in the
>> chip drivers.
>> For example: .aliases	= (char const
>> *[]){"ricoh,rs5c372a","ricoh,rs5c372b","ricoh,rv5c386","ricoh,rv5c387a",
>> 0},
>
> You should not need the (char const *[]) casts at all.

It's not a cast, it's a compound literal.  What it does is to create an
anonymous object, the address of which is the initializer for the
aliases pointer.  Note that the anonymous object is not const qualified.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
