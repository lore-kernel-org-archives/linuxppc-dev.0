Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 009E32BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 00:13:25 +1000 (EST)
In-Reply-To: <4174D1F4.2050506@eircom.net>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
	<BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
	<4174D1F4.2050506@eircom.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5925F5E8-21D9-11D9-A47E-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 19 Oct 2004 10:15:37 -0400
To: Conor McLoughlin <cml3227@eircom.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 19, 2004, at 4:36 AM, Conor McLoughlin wrote:

> If I look at where it is allocating the memory with kmalloc, it is
> in this area.

Oooops, sorry you are correct, I had vmalloc() on the brain
due to some debugging I was doing.

> Just because it works doesn't mean that there might not be a bug
> lurking there.

It works because the 82xx is cache coherent.  The MMU mapping
is irrelevant.  There is no bug here.  Just because people don't
understand how something works doesn't mean there is a bug
present.  On processors like the 8xx or 4xx that are not cache
coherent, this would be a bug unless cache management functions
are also called and the buffers are properly aligned to cache
boundaries.

Thanks.

	-- Dan
