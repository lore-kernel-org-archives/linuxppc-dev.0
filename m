Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-18.bluehost.com (outbound-mail-18.bluehost.com
	[69.89.20.233]) by ozlabs.org (Postfix) with SMTP id 5778CDDFCD
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 04:11:24 +1000 (EST)
Message-ID: <4A0B0D4A.6000405@dlasys.net>
Date: Wed, 13 May 2009 14:11:22 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: Re: device trees.
References: <4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
	<4A0A6495.2050605@dlasys.net>
	<20090513062127.GU24338@yookeroo.seuss>
In-Reply-To: <20090513062127.GU24338@yookeroo.seuss>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>
>
> Ok.  If you have NOR flash, why couldn't you just put the dtb in a
> separate partition of the NOR?
>
>   
It is not THE dtb, it is A dtb. Our systems support and typically use
multiple FPGA bit streams.
Clients are
That means each bitstream must have its own dtb, clients are
allowed/expected to create their own firmware,
but the norm is to leave the "PrimaryBoot.bit" startup bit file intact.
Clients may swap between several bit files for development purposes in
the course of a day.
It is even possible that a clients application may require swapping bit
files as part of normal operations.
I want one linux binary - because I know damn well that given two my
clients will use the wrong one alteast 30% of the time.
Somewhere arround 4 binaries that becomes almost 100% of the time.
Using dtb's to make the linux binary does NOT solve the problem it just
changes the file they have to get right.
Worse still the wrong dtb will probably mostly work. If it just failed
they would be more likely to grasp what they got wrong.

I need/want the device tree welded to the bitstream. That means creating
it dynamically or welding it to the bitstream.
Anything else wil be a support nightmare.

Though this does not impact Linux, we have clusters of FPGA's that are
used for High Performance computing,
One typical application is decryption where they work much like turing's
Bomb's at bletchley park only much faster.
Anyway in that application we load bitstreams into FPGA's exactly the
way someone would load programs into a processor.
The FPGA programming can be changed on a whim. In a cluster some
FPGA's/Processors might be executing one set of code while
others might be running different programming.

As the tools get better this is going to become even more common.
Right now this is not a linux application (linux manages the cluster),
but there is no reason you can not think of the cluster as a massive SMP
machine,
with massively parallel soft CPU's, and who knows the whole mess could
be running Linux itself.

The point I am trying to make is whatever I am doing now, things may be
totally different soon enough.
Every significant performance gain that occurs with Xilinx tools results
in a significant increase in our markets.

Hard and fast constraints guarantee problems down the line. Wasteful
choices that are easy now come back to haunt us down the line.

Standalone embedded systems are my bread and butter, but they are only
about 1/3 of our market.
Even within them 95% of our clients do not need Linux. Most do not
really need an OS at all.
Some of the time they do not even need a CPU.
We provide Linux because it makes them happy, because they are not up to
developing their own standalone programs to perform the tasks.

Still that means that Linux needs to make the task easier - not harder.





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
