Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-310.bluehost.com (outbound-mail-310.bluehost.com
	[67.222.54.3]) by ozlabs.org (Postfix) with SMTP id 15DCFB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 14:03:28 +1100 (EST)
Date: Wed, 16 Dec 2009 18:56:27 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cardbus: Add a fixup hook and fix powerpc
Message-ID: <20091216185627.2ea4f3d8@jbarnes-piketon>
In-Reply-To: <1260341533.16132.20.camel@pasglop>
References: <1260341533.16132.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
	blofeldus@yahoo.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 09 Dec 2009 17:52:13 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> The cardbus code creates PCI devices without ever going through the
> necessary fixup bits and pieces that normal PCI devices go through.
> 
> There's in fact a commented out call to pcibios_fixup_bus() in there,
> it's commented because ... it doesn't work.
> 
> I could make pcibios_fixup_bus() do the right thing on powerpc easily
> but I felt it cleaner instead to provide a specific hook
> pci_fixup_cardbus for which a weak empty implementation is provided
> by the PCI core.
> 
> This fixes cardbus on powerbooks and probably all other PowerPC
> platforms which was broken completely for ever on some platforms and
> since 2.6.31 on others such as PowerBooks when we made the DMA ops
> mandatory (since those are setup by the fixups).
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ah the link failure was my fault.  I had fixed up the conflict
incorrectly.  It's applied now.

-- 
Jesse Barnes, Intel Open Source Technology Center
