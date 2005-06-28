Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6ED767B5D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 09:53:22 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet> <20050627133930.GA9109@logos.cnet>
	<f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
	<1119940208.5133.204.camel@gaston>
	<3e7207cd8e98080f2f469a668e37a20f@embeddededge.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:47:54 +1000
Message-Id: <1120002475.5133.208.camel@gaston>
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

On Tue, 2005-06-28 at 09:53 -0400, Dan Malek wrote:
> On Jun 28, 2005, at 2:30 AM, Benjamin Herrenschmidt wrote:
> 
> > You should consider 8Mb pages the way we do BATs yes,
> 
> It's always been considered, just never fully implemented :-)
> 
> > Note that I'll soon send the patch I told you about that makes the
> > virtual address picked by io_block_mapping() dynamic, so we no longer
> > have to do crappy assumptions all over the place :)
> 
> Whatever, I'll never use it that way and no one else should either.

That is stupid

> All of the io_block_mapping() calls should be used to set these 8M

I think you just never bothered actually reading all I wrote about
that... None of what you describe requires hard coding the virtual
address. This is just plain bad.

> mapped IO spaces, everyone should use ioremap() to map them,
> and ioremap() has to be modified to find them for the 8xx.

We agree here.
