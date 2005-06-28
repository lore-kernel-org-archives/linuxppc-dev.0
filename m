Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CFA967B67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 23:53:41 +1000 (EST)
In-Reply-To: <1119940208.5133.204.camel@gaston>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 28 Jun 2005 09:53:26 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 28, 2005, at 2:30 AM, Benjamin Herrenschmidt wrote:

> You should consider 8Mb pages the way we do BATs yes,

It's always been considered, just never fully implemented :-)

> Note that I'll soon send the patch I told you about that makes the
> virtual address picked by io_block_mapping() dynamic, so we no longer
> have to do crappy assumptions all over the place :)

Whatever, I'll never use it that way and no one else should either.
All of the io_block_mapping() calls should be used to set these 8M
mapped IO spaces, everyone should use ioremap() to map them,
and ioremap() has to be modified to find them for the 8xx.

Thanks.


	-- Dan
