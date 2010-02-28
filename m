Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D560B7DC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:39:10 +1100 (EST)
Date: Sun, 28 Feb 2010 14:20:46 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: [RFC PATCH v2 4/9] add generic dmabounce support
Message-ID: <20100228142046.GA16745@n2100.arm.linux.org.uk>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
	<1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267366082-15248-5-git-send-email-albert_herranz@yahoo.es>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 28, 2010 at 03:07:57PM +0100, Albert Herranz wrote:
> This patch makes part of the ARM dmabounce code available to other
> architectures as a generic API.

There is already a generic dma bounce implementation - it's called
swiotlb - lib/swiotlb.c.  We should eventually switch the ARM
dmabounce stuff over to that instead of keeping dmabounce around.

The only problem I forsee is that on ARM, we have devices which can
only address the least significant N bits of RAM, but there may be
an offset on the base address of RAM on the bus which isn't included
in these N bits.

Even more fun is where we have a DMA controller which can address
N bits of RAM, except for bit M which must be zero... (where N > M).
