Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id ECF5A4F38E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 04:56:08 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2456508ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:56:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090127043315.26160.43312.stgit@localhost.localdomain>
References: <20090127043315.26160.43312.stgit@localhost.localdomain>
Date: Tue, 27 Jan 2009 11:56:06 -0600
Message-ID: <b5e2fc790901270956q4448ac4brd0f6ea177ace9ade@mail.gmail.com>
Subject: Re: [PATCH] powerpc/5200: Bugfix for PCI mapping of memory and IMMR
From: Matt Sealey <matt@genesi-usa.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2009 at 10:34 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This patch ensures that memory gets properly mapped into the PCI
> address space.  Without this patch, the memory window BAR is left
> at whatever value happened to be loaded into the BAR when Linux
> was booted.  Without this patch, memory could end up getting mapped
> at any of the 1G address boundaries instead of at '0' where Linux
> expects it.
>
> Similarly, this patch also ensures that the internally memory mapped
> registers (IMMR) are mapped to the correct PCI address range.
>
> Without this patch, PCI appears to work correctly until a PCI
> device is inserted which DMAs into memory.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> This is a bugfix that I intend to merge into 2.6.29 and once it is
> mainlined get it added to the stable queue.  If you have a 5200 system,
> please test and make sure it works for you.
>
> Thanks
> g.
>
>  arch/powerpc/platforms/52xx/mpc52xx_pci.c |   24 ++++++++++--------------
>  1 files changed, 10 insertions(+), 14 deletions(-)
>

This doesn't affect Efika, right?

What's the expected impact and how come nobody tried a DMA-capable PCI
card in an MPC5200B board before? :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
