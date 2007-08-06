Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 24B6EDDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:48:40 +1000 (EST)
Message-ID: <46B7A537.9020807@s5r6.in-berlin.de>
Date: Tue, 07 Aug 2007 00:48:23 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2.6.22.y] ieee1394: revert "sbp2: enforce
	32bit	DMA	mapping"
References: <fa.Qn3Snqoik3hhnxcA6HqjGV0Yzck@ifi.uio.no>
	<46B4B3DC.7020609@shaw.ca> <46B4B7C6.1040107@s5r6.in-berlin.de>
	<1186272926.938.8.camel@localhost.localdomain>
	<46B5824B.1000103@s5r6.in-berlin.de>
	<1186351473.938.21.camel@localhost.localdomain>
	<20070806135124.GA2900@suse.de>
	<1186436848.938.75.camel@localhost.localdomain>
	<46B79F25.50205@s5r6.in-berlin.de> <46B79FD7.9020801@shaw.ca>
In-Reply-To: <46B79FD7.9020801@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org, linux-kernel@vger.kernel.org,
	Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Hancock wrote:
> Stefan Richter wrote:
>> So that's the story why that dma_set_mask went into sbp2:  Sbp2 wants
>> mappings in a _subset_ of the OHCI-1394 controllers DMA range.
>>
>> Anyway.  For now I will simply go with what 2.6.23-rc has and what
>> 2.6.21 had:  No dma_set_mask anywhere in the 1394 subsystem.  We can
>> revisit this whenever an actual need arises.
> 
> Not sure this is a very good idea. This seems rather likely to fail on
> x86_64 machines with >4GB of RAM for example..

I'll deal with it when a bug report comes in.

  1.) The ieee1394 subsystem is known to work on x86_64 with more than 4
GB RAM, so I gather that architecture code already sets a proper DMA
mask for all those 32bit PCI OHCI-1394 implementations out there.

  2.) I haven't heard of an OHCI-1394 chip whose overall DMA range was
bigger than the Physical Range.  There are only two chips, from ALi and
from Fujitsu, whose Physical Range is curiously bigger than the actual
DMA range.
-- 
Stefan Richter
-=====-=-=== =--- --===
http://arcgraph.de/sr/
