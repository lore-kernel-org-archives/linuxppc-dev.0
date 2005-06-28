Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7540267A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 16:35:26 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 16:30:07 +1000
Message-Id: <1119940208.5133.204.camel@gaston>
Mime-Version: 1.0
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


> 
> You see, this just keeps growing in features and complexity :-)
> It would be nice for ioremap() to consider multiple, dynamic 8M
> pages on 8xx like it does BATs on traditional PPC.  It will do
> this .... someday soon.

You should consider 8Mb pages the way we do BATs yes, that is have
something like an array of those or use 2 PMD entries to represent them,
and then, have ioremap treat them like it does with BATs. Such 8Mb pages
could then be setup using io_block_mapping().

Note that I'll soon send the patch I told you about that makes the
virtual address picked by io_block_mapping() dynamic, so we no longer
have to do crappy assumptions all over the place :)

> Perhaps I should go back and push some of this dynamic 8M
> page stuff.  It would eliminate the tlbie() problems, give us
> more flexibility.  Damn, not enough hours in a day ....

Looks like a good idea though :)

Ben.
