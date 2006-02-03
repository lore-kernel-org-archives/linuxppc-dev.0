Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7367268A3A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Feb 2006 08:05:09 +1100 (EST)
In-Reply-To: <4A062D477D842B4C8FC48EA5AF2D41F201AC366C@us-bv-m23.global.tektronix.net>
References: <4A062D477D842B4C8FC48EA5AF2D41F201AC366C@us-bv-m23.global.tektronix.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6b2b0e6794ab02c3ff9d1b4aefed920e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Gdb with MPC85xx
Date: Fri, 3 Feb 2006 16:05:01 -0500
To: <atul.sabharwal@exgate.tek.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 3, 2006, at 3:46 PM, <atul.sabharwal@exgate.tek.com> wrote:

> To the best of my knowledge, I had could single step but not run to a
> breakpoint in the initial u-boot code on PPC8540( an E500 core based)

This is a problem with many processors and has been discussed
at length too often.  The quick response is that various initialization
code in both boot roms and Linux will disable/reset or otherwise
mess up debug registers the BDI has configured for it's use.  So,
it isn't the fault of the BDI2000, you may have to temporarily disable
or modify the code under test in such a way to not do this.  There are
several tricky places to debug code, that are completely inaccessible
without the use of the BDI2000, but that also require some common
sense and minor environment changes to properly debug.  The e500
core (and Book-E in general) significantly complicated the ability
to debug in some modes of development, so you are most
likely to see problems with these processors than others.

Thanks.

	-- Dan
