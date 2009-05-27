Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id A73E7DDFC0
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 06:29:24 +1000 (EST)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
From: Ian Campbell <Ian.Campbell@eu.citrix.com>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <0628DF07-E085-4CC8-ADFC-1B0798343159@kernel.crashing.org>
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
	<20090519142656T.fujita.tomonori@lab.ntt.co.jp>
	<19E48A70-3332-423C-ACAD-390F940EE81C@kernel.crashing.org>
	<4A1592CF.8000208@goop.org>
	<E6DAA792-9923-4B76-9759-6955AABE3EAB@kernel.crashing.org>
	<1242990702.22654.253.camel@zakaz.uk.xensource.com>
	<0628DF07-E085-4CC8-ADFC-1B0798343159@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 27 May 2009 21:29:19 +0100
Message-ID: <1243456159.4399.42.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-05-27 at 15:05 -0400, Becky Bruce wrote:
> On May 22, 2009, at 6:11 AM, Ian Campbell wrote:
> >
> >
> > BTW do you need swiotlb_bus_to_virt to be __weak or is the fact that  
> > it
> > is implemented in terms of swiotlb_bus_to_phys sufficient?
> 
> The default one in swiotlb calls phys_to_virt on the result of  
> swiotlb_bus_to_phys, which only works on lowmem.

Perhaps we can simply enhance the default one to handle highmem instead
of making it arch specific?

Ian.
