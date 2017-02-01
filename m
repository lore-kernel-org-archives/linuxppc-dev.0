Return-Path: <hmurray@megapathdsl.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCvQ160cTzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 18:09:29 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Hugh Blemings <hugh@blemings.org>, linuxppc-dev@ozlabs.org,
 devel@ntpsec.org, Hal Murray <hmurray@megapathdsl.net>,
 Paul Mackerras <paulus@ozlabs.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Hal Murray <hmurray@megapathdsl.net>
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: Message from Benjamin Herrenschmidt <benh@kernel.crashing.org>
 of "Wed,
 01 Feb 2017 14:34:48 +1100." <1485920088.2953.15.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jan 2017 22:59:32 -0800
Message-Id: <20170201065932.92618406061@ip-64-139-1-69.sjc.megapath.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks.

benh@kernel.crashing.org said:
> Right, we just use the value provided by Open Firmware. Any chance you can
> try with MacOS X ? 

Not easily.  I'm using boxes from eBay.  They didn't come with CDs and I've 
already installed other software.


> From the value in the properties you showed me (and the ones I have in some
> DT snapshots) it looks like the value isn't fixed but somewhat calibrated by
> Open Firmware during boot. 

I rebooted several times.  It always got the exact same clock speed numbers.

I don't know anything about the insides of the PowerPC chip.  Can you confirm 
that the kernel time keeping works off an always ticking register similar to 
the Intel TSC and uses the timebase-frequency as the scale factor?

If so, I should be able to "fix" it from Open Firmware.  I tried that but 
things got worse.  I could easily have fatfingered something but more likely 
my reasoning for computing the right value was buggy.  I guess I'll try again.

I see that powerpc/kernel/time.c reads both timebase-frequency and 
clock-frequency, but doesn't seem to use clock-frequency.  Was that just a 
handy place to read it that got called before anybody else needed it?



-- 
These are my opinions.  I hate spam.
