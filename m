Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76ECE680CB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 07:00:10 +1000 (EST)
In-Reply-To: <1123739278.19079.13.camel@localhost.localdomain>
References: <1123739278.19079.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ac06540dd9a24bb4998ef19e08848eb1@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 11 Aug 2005 17:00:30 -0400
To: vijaykumar@bravegnu.org
Cc: dmalek@jlc.net, linuxppc-embedded@ozlabs.org
Subject: Re: 8260 fcc_enet driver newbie question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 11, 2005, at 1:47 AM, Vijay Kumar wrote:

> I was going through the fcc_enet driver
> (linux-2.6.12.2/arch/ppc/8260_io/fcc_enet.c).

This has been replaced by the new net/fs_enet, right?

> The driver accesses the CPM memory map using
> immap = (cpm2_map_t *)CPM_MAP_ADDR;

Yes, and that's wrong.  You should at least use
ioremap(), and we recently had discussions about
whether to create some properly named functions
or macros to return common addresses like the
CPM space.

> There is also a global variable cpm2_immr defined in
> arch/ppc/syslib/cpm2_common.c

I know, but we shouldn't be doing that any longer.

> If I were to write a new driver which one should I use
> to access the CPM memory map?

For now, at least ioremap() the space in your driver
and cache the pointer.  I'd like to quickly get a couple of
these other supporting functions done to use, though.

Thanks.

	-- Dan
