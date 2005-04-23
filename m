Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50A4367AC5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 24 Apr 2005 07:25:36 +1000 (EST)
In-Reply-To: <1114268839955.clasu.41340._Jq1rpPPGxteNPNX4EzpwA@luukku.com>
References: <1114268839955.clasu.41340._Jq1rpPPGxteNPNX4EzpwA@luukku.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26b0918f636b06e4c0cffa6808c212ae@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sat, 23 Apr 2005 17:25:20 -0400
To: clasu@luukku.com
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: ioremap problem with kernel 2.6.11 on mpc8270
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 23, 2005, at 11:07 AM, clasu@luukku.com wrote:

> It seems to me that the ioremap call fails somehow in 2.6.11 and that 
> the page
> tables are not updated correctly.

I can't find any obvious differences that would cause this.  I suspect 
something
may be different in your platform specific set up or there was some 
minor
changes that are required moving your platform specific set up to the 
newer
kernel sources.

> I have not been able to find out what causes this but it would make 
> may day if
> someone could help me a bit.

In arch/ppc/mm/pgtable.c, about line 481, change the
	#define HAVE_BATS 1
to
	#define HAVE_BATS 0


and report if that makes any difference.

Thanks.

	-- Dan
