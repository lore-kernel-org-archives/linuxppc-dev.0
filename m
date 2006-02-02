Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D88C468A3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 05:55:40 +1100 (EST)
In-Reply-To: <200602021642.49282.laurent.pinchart@tbox.biz>
References: <200602021458.26623.laurent.pinchart@tbox.biz>
	<20060202170753.2a805189@vitb.ru.mvista.com>
	<200602021642.49282.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f23a702cbd0fc2910162c5cf25e30abe@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Accessing the CPM2 on an MPC82xx : CPM_MAP_ADDR or cpm2_immr ?
Date: Thu, 2 Feb 2006 13:55:36 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
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


On Feb 2, 2006, at 10:42 AM, Laurent Pinchart wrote:

> The new fs_enet driver internally maps CPM_MAP_ADDR. Should every 
> driver
> create an internal CPM mapping ?

Yes, they should.  All drivers should do the ioremap() and stash the
pointer internally.

> .... Why was the old fec_enet driver able to
> access the CPM through CPM_MAP_ADDR without ioremap()ing it first ?

Because that's a long left over "performance hack" from many
years ago when I first implemented the 8xx software.  The IMMR used
to be mapped to a well known virtual address, the board initialization
did this early, and everyone (ab)used it.  This was way back in the 
2.0/2.1
days when it was acceptable to do such things :-)  Due to the CPM2 now
being used on may different Freescale parts, and mapped in various
ways, the internal mapping should be done by every driver.

Thanks.

	-- Dan
