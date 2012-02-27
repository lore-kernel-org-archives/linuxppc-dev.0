Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 664DBB6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 20:19:37 +1100 (EST)
Message-ID: <1330334360.11728.3.camel@pasglop>
Subject: Re: linux-next: build failure after merge of the final tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 27 Feb 2012 20:19:20 +1100
In-Reply-To: <20120227173747.853e7fbe3ce3afab8939720b@canb.auug.org.au>
References: <20120227173747.853e7fbe3ce3afab8939720b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org,
 Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-02-27 at 17:37 +1100, Stephen Rothwell wrote:
>         pci_add_resource_offset(resources, res,
> -                       (resource_size_t) hose->io_base_virt - _IO_BASE);
> +                       (resource_size_t)(unsigned long)hose->io_base_virt - _IO_BASE);

We have to be careful here as we do want sign extension to happen (yeah
it's odd, but it's the way we do IOs on ppc32 :-) Maybe I should change
it one day).

So we probably want to do:

	 (resource_size_t)(long long)(hose->io_base_virt - _IO_BASE)

Basically, IO resources are relative to _IO_BASE which on ppc32 is
basically the virtual address where we map the first PHB IO space.

Subsequent PHB mappings can end up below _IO_BASE, leading to negative
resource values for IO BARs on those busses. It all works fine because
even an unsigned addition will do the right thing as long as the value
is fully sign extended.

Cheers,
Ben.
