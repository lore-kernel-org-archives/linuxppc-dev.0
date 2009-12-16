Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-153.bluehost.com (outbound-mail-153.bluehost.com
	[67.222.39.33]) by ozlabs.org (Postfix) with SMTP id 61516B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 09:08:29 +1100 (EST)
Date: Wed, 16 Dec 2009 14:01:28 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cardbus: Add a fixup hook and fix powerpc
Message-ID: <20091216140128.16afbeb7@jbarnes-piketon>
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
> ---
> 
> Note: In the long run we might want to streamline the hooks for fixing
> up new devices vs. new busses and make some stuff common between
> cardbus and PCI hotplug which is actually a mess.
> 
> This is a quick fix that makes it work again in the meantime, and that
> I would like to see in 2.6.31 and 2.6.32 stable at least. 
> 
> Another option if you prefer is I can make my pcibios_fixup_bus() do
> the right thing in all cases I believe (by testing bus->is_added to
> skip stuff that must not be done twice) and we can remove the comment
> and stick the call in #ifdef CONFIG_PPC but I felt that solution was
> a tad cleaner.
> 
> Olof, once that's in you should be able to remove the hack you have in
> the PA-Semi code to work around this.
> 

Oops, looks like this fails for the modular case?  I get an unresolved
symbol error when building this with my default config...

Care to resend with the fix against my for-linus branch?

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
