Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68566B7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 00:11:46 +1000 (EST)
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
	by ozlabs.org (Postfix) with ESMTP id DE57ADDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 00:11:45 +1000 (EST)
Subject: Re: [00/15] swiotlb cleanup
From: Ian Campbell <Ian.Campbell@citrix.com>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20090710143408A.fujita.tomonori@lab.ntt.co.jp>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<20090710051236.GA22218@elte.hu>
	<20090710143408A.fujita.tomonori@lab.ntt.co.jp>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 15:02:00 +0100
Message-ID: <1247234520.4002.418.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: jeremy@goop.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, joerg.roedel@amd.com, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-10 at 14:35 +0900, FUJITA Tomonori wrote:
> I don't think that we need to take account of dom0 support; we don't
> have a clear idea about an acceptable dom0 design (it needs to use
> swiotlb code? I don't know yet), we don't even know we will have dom0
> support in mainline. That's why I didn't CC this patchset to Xen
> camp.

The core domain 0 patches which were the subject of the discussions a
few week back are completely orthogonal to the swiotlb side of things
and whatever form they eventually take I do not think it will have any
impact on the shape of the solution which we arrive at for swiotlb. I
don't think that assuming that domain 0 can never be done in a way which
everyone finds acceptable and therefore discounting all consideration of
it is a useful way to make progress with these issues.

The DMA use case is much more tightly tied to the paravirtualized MMU
(which is already in the kernel for domU purposes) than it is to "the
domain 0" patches anyway. Although domain 0 is probably the main use
case, at least today, swiotlb support is also used in a Xen domU as part
of the support for direct assignment of PCI devices to paravirtualised
guests (pci passthrough).

The pci frontend driver depends on some bits of the domain 0 physical
interrupt patches as well as swiotlb which is why I/we haven't tried to
upstream that particular series yet.

Ian.
