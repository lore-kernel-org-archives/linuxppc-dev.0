Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64DDD679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 11:03:38 +1000 (EST)
In-Reply-To: <s2b045ef.027@scms1.sc.signaal.nl>
References: <s2b045ef.027@scms1.sc.signaal.nl>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5359e8b72ccab672f101490b84a1f1c0@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 15 Jun 2005 21:03:25 -0400
To: "Samuel Osorio Calvo" <samuel.osorio@nl.thalesgroup.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: multicast disabled on 8260_io/fcc_enet.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 9:14 AM, Samuel Osorio Calvo wrote:

> Currently I have multicast working just be moving the return 
> statement. It seems to work but I guess I did not face yet the 
> problems that caused the code to be commented.
> Let's say it works in an unreliable way....

When I wrote the original code I copied the old SCC driver and didn't 
have
a function for computing CRCs, so I just placed the return early in the 
function.
I believe there is a patch floating around that wrote a CRC function 
(or used some
existing one), to compute the filter mask.  If the code has a CRC 
function call,
then it will likely work.  If it doesn't have one, then you are running 
on luck.  Either
the proper filter bit is set by some random reset bits, or you somehow 
get the
right one set.  By default, the multicast filter may just catch 
everything, forcing
the Linux IP stack to do the filtering at a higher level, not exactly 
what you want. :-)

This has been discussed many times in the past.

Thanks.

	-- Dan
