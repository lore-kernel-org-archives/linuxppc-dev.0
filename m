Return-Path: <clark@esteem.com>
Received: from mail5.hsphere.cc (mail5.hsphere.cc [216.157.145.25])
	by ozlabs.org (Postfix) with SMTP id 32D1868351
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 01:27:29 +1000 (EST)
Message-ID: <43381258.2060306@esteem.com>
Date: Mon, 26 Sep 2005 08:23:04 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Andy Hawkins <a.hawkins@cabletime.com>
References: <006101c5c27a$ca9c3280$153335bf@cabletime.com>
In-Reply-To: <006101c5c27a$ca9c3280$153335bf@cabletime.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Slow read performance of NAND flash on PPC 405EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andy Hawkins wrote:
> Hi,
> 
> Thanks for the reply.
> 
> 
>>It would be nice if you would break out the fields in the
>>PB2AP control
>>word. This is what I came up with.
>>
>>BME = 1, burst mode enabled
>>FWT = 2, 3 wait states
>>BWT = 4, 5 wait states
>>CSN = 0, 0 clock cycles before CS asserted
>>OEN = 1, 1 clock cycle before the PerOE is asserted
>>WBN = 1, 1 clock cycle delay until the first PerW line
>>assertion after CS
>>WBF = 1, 1 clock cycle delay
>>TH  = 2, 2 clock cycles in between each burst
>>RE  = 0, PerREADY line disabled
>>SOR = 1, no effect
>>BME = 0
> 
> 
> That matches how we decoded it, yes.
> 
> 
>>So you are reading things in burst mode. I have no experience doing
>>things in burst mode so I'm not going to be much help. I
>>would look at
>>your timing diagrams again. Try changing the TH to 1 or 0 and
>>see what
>>happens.
> 
> 
> We did try switching away from burst mode. However, as the flash is a serial
> read device with only one address, then each 'burst' transaction is only for
> a single ready anyway. We did try configuring without burst mode enabled,
> and it made little difference.
> 
> Are the figures we're seeing particularly slow, or are our expectations
> unrealistic?
> 
> Any other ideas?
> 
> Thanks again
> 
> Andy
> 


Without looking at the data sheet for your flash device I find it a 
little strange that the first wait state is 3 and the subsequent read 
wait states are 5 (i.e. 3,5,5,5,5... ) . Usually burst sequential 
devices have a long first wait state period followed by shorter ones 
(i.e. 5,3,3,3,3..... ). Are you sure you have this correct?

Unfortunately I don't have time to calculate your actual data rate. 
Other than reducing the Transfer Hold setting down from 2 to 1 or 0 I 
don't have any other ideas. In the end you get what you can get and 
thats it. If you have everything correct thats about all your going to 
get unless you start pushing timing beyond what they are rated for. I'm 
sure you don't want to do that.

Good Luck

-- Conn

*****************************************************************
Blessed be the heretic, for he causes some to think and unites
the rest against him.
*****************************************************************

Conn Clark
Engineering Assistant                clark@esteem.com
Electronic Systems Technology Inc.        www.esteem.com

Stock Ticker Symbol                ELST
