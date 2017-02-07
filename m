Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHSl86LHkzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 13:21:40 +1100 (AEDT)
From: Michael Ellerman <michael@ellerman.id.au>
To: Hal Murray <hmurray@megapathdsl.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugh Blemings <hugh@blemings.org>, linuxppc-dev@ozlabs.org,
 devel@ntpsec.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
References: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
Date: Tue, 07 Feb 2017 13:21:40 +1100
Message-ID: <87h946g2q3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hal Murray <hmurray@megapathdsl.net> writes:

> benh@kernel.crashing.org said:
>> Ok, I do have one though somewhere with OS X on it. If you give me
>> instructions on how to test (I know near to nothing about ntpsec), I should
>> be able to compile and run it.
>
> I'm assuming you are already running the normal ntpd from ntp classic, or 
> Apple's version of it.
>
> ntpq -c "rv 0 frequency" <host-name, defaults to localhost>
> will get you the fudge-factor that ntpd passes to the kernel to get
> the clock ticking accurately.  Units are parts-per-million.
>
> There is a source-address filter in ntp.conf (restrict is the keyword), so 
> try from localhost if it doesn't work from the net.
>
> The problem that started this is that it's off by more than 500 ppm.  If all 
> the arithmetic and documentation is correct, it should be the crystal error.  
> A few or few 10s of ppm is reasonable at normal temperature.  Over 50 is a 
> bit strange, but anything under 100 is within normal.  Over 100 is getting 
> suspicious but could easily be due to some round off someplace.
>
>
>
> ntpsec should be the same as ntp classic.  I tried ntp classic on FreeBSD 
> (same trouble) but haven't tried it on Debian.
>
> If you want to try ntpsec...
>
> git clone git@gitlab.com:NTPsec/ntpsec.git xxx
> cd xxx
> ./waf configure build check
>
> I think it builds cleanly on OS-X, but I can't verify that.
>
> ps ax | grep ntpd  # to get args
> service ntpd stop
> ./build/main/ntpd/ntpd <args-from-above>
>
> Unless you are doing something unusual, it should run with your existing 
> ntp.conf and get the same frequency correction.

What do I do if I don't have an existing ntp.conf ?

cheers
