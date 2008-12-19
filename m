Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 7A220DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 18:36:57 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LDZun-0000x3-9M
	for linuxppc-dev@ozlabs.org; Thu, 18 Dec 2008 23:36:53 -0800
Message-ID: <21087072.post@talk.nabble.com>
Date: Thu, 18 Dec 2008 23:36:53 -0800 (PST)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
In-Reply-To: <20081218190208.GC18201@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <21070179.post@talk.nabble.com>
	<20081218190208.GC18201@yoda.jdub.homelinux.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Josh Boyer-3 wrote:
> 
> On Thu, Dec 18, 2008 at 02:29:52AM -0800, Felix Radensky wrote:
>>
> 
> 
> I booted on a canyonlands this morning (after having removed the brown
> paper bag that preventing me from booting it yesterday).  I saw no
> delay.
> 
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

Thanks a lot to everyone who replied. I've managed to identify the cause
of the delay. The board is equipped with 256 MiB Samsung NAND flash. 
Since NAND support is a must for this platform, I've intergated the ndfc
driver recently posted by Sean McLennan. With this driver enabled the delay
is present, without it messages appear on the console immediately.

Is this an expected behavior - detection of 256 MiB NAND flash
takes around 20 seconds. The ndfc driver works fine after boot.

Felix.
-- 
View this message in context: http://www.nabble.com/Long-boot-delay-on-460EX-with-2.6.28-rc8-tp21070179p21087072.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
