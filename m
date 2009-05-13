Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-306.bluehost.com (outbound-mail-306.bluehost.com
	[67.222.53.252]) by ozlabs.org (Postfix) with SMTP id 19127DDF82
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 16:18:15 +1000 (EST)
Message-ID: <4A0A6495.2050605@dlasys.net>
Date: Wed, 13 May 2009 02:11:33 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: device trees.
References: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
In-Reply-To: <20090513023614.GJ24338@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, May 12, 2009 at 05:10:46PM -0700, Stephen Neuendorffer wrote:
>   
>> Another possibility is to pad the DTB with a DESYNC command and the
>> correct pad frame, just in case it cannot be prevented.
>>     
>
> Um.. one thing I'm missing in this discussion of attaching the dtb to
> the bitstream:  I don't see how the bitstream becomes accessible to
> the kernel at runtime.  Unless you were exposing the dtb as part of
> the fpga programming, but I thought you explicitly weren't doing that
> because of limited bram space.
>
> I imagine this is simply due to my ignorance about FPGA techniques,
> but if someone could enlighten me...?
>   
    While I am not sure I grasp all of the nuances why, this is NOT the
scheme Stephen recomends.
    But it looks to be the most promising for me at Pico.

    In my instance, the FPGA code is typically in NOR Flash - actually
several different FPGA bitstreams might be in Flash.
    The mechanism that we use to load the FPGA ensures that I can know
the Flash File that was used to program the FPGA.
    That means that my monitor an read that file and extract the device
tree.
    The remainder is a discussion of how to concatenate the dtb and the
bit stream together, the pros/cons of prepending vs. appending,
    and work arrounds for issues.
    The critical factor is that the nature of the FPGA load process
makes it possible to put data at the front or rear and assure that it
gets ignored.





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
