Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9236F2BD81
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 01:29:04 +1000 (EST)
In-Reply-To: <41738D27.4060007@eircom.net>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BE328096-211A-11D9-8079-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 18 Oct 2004 11:31:12 -0400
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


On Oct 18, 2004, at 5:30 AM, Conor McLoughlin wrote:

> I have been looking at the ethernet device driver (fcc_enet) for the
> mpc82xx platform. This allocates buffer descriptors using kmalloc with
> the GFP_DMA flag.

Yes.

>  As far as I can see on my platform, this allocates
> from the regular kernel memory (0xCxxxxxxx). As the attributes of this
> block of memory are controlled by the block address translation
> registers,

No, the kmalloc() space is not covered by BATs (but, that isn't
relevant for this discussion).

>  this cannot be DMA safe, can it?

Yes, it is DMA safe.  That's why this driver works :-)

	-- Dan
