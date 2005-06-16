Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8BBD67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:12:41 +1000 (EST)
In-Reply-To: <a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0fc7d3f2fe1266cdd0beaf44a71bc27c@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 11:12:24 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 12:13 AM, Kumar Gala wrote:

>> 2. I am torn about using numeric IMMR offsets vs. the structure member
>> approach. The good thing is that you can create all the devices in a
>> single table even if they overlay depending on processor. The question
>> is, will the IMMAP structure become obsolete? If not, then you will
>> still need the conditional compiles in immap_cpm2.h.
>
> I'm trying to stay away from basing things on the structure.  Since 
> the offsets are truly fixed I see not reason to try to make sure that 
> the immap structure is always correct for all cases.

Having just converted an different SoC part from using offsets to data
structures, I have to say that tables/defines of offsets are more of a 
mess
than a data structure.  We don't have to define the whole of the IMMAP, 
but
using the data structures for the individual device spaces is quite 
effective.
The advantage of using the data structure is it also conveys the data 
type
size, adding a level error checking.  I also dislike io accessor 
functions/macros,
especially on these processor specific devices.


Thanks.

	-- Dan
