Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1268870941.2335.214.camel@pasglop>
References: <1268870941.2335.214.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Mar 2010 18:35:03 -0600
Message-ID: <fa686aa41003171735v1e9b62bci9273b6ae0e7b7a15@mail.gmail.com>
Subject: Re: [PATCH] powerpc/of: Fix comparison of "compatible" properties
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michal Simek <michal.simek@petalogix.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 17, 2010 at 6:09 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Commit 7c7b60cb87547b1664a4385c187f029bf514a737
> "of: put default string compare and #a/s-cell values into common header"
>
> Breaks various things on powerpc due to using strncasecmp instead of
> strcasecmp for comparing against "compatible" strings.
>
> This causes things like the 4xx PCI code to fail miserably due to the
> partial matches in code like this:
>
> =A0 =A0 =A0 =A0for_each_compatible_node(np, NULL, "ibm,plb-pcix")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ppc4xx_probe_pcix_bridge(np);
> =A0 =A0 =A0 =A0for_each_compatible_node(np, NULL, "ibm,plb-pci")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ppc4xx_probe_pci_bridge(np);
>
> This reverts us to use strcasecmp. I do wonder why microblase and sparc
> want the partial matches though. For sparc it could be historical, but
> microblaze might want to change.
>
> It's not quite right to do partial name match. Entries in a compatible
> list are meant to be matched whole. If a device is compatible with both
> "foo" and "foo1", then the device should have both strings in its
> "compatible" property.

Hmmm.  That's a mistake I made then in commit 7c7b60cb.  I had meant
to use strcasecmp(), and had missed that microblaze was doing it
differently.  I certainly don't want to carry over partial name match
when other architectures pick up device tree support.  If anything,
microblaze should have the exception and the common code fixed.

Michal, why does microblaze differ from powerpc on this point?

Cheers,
g.

>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> =A0arch/powerpc/include/asm/prom.h | =A0 =A08 ++++++++
> =A01 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/p=
rom.h
> index ddd408a..47ce796 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -23,6 +23,14 @@
> =A0#include <asm/irq.h>
> =A0#include <asm/atomic.h>
>
> +/* We do -not- want the generic "strncasecmp" here for of_compat_cmp.
> + * We have cases where we could otherwise mismatch "pcix" and "pci"
> + * and similar.
> + */
> +#define of_compat_cmp(s1, s2, l) =A0 =A0 =A0 strcasecmp((s1), (s2))
> +#define of_prop_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcmp((s1), (s2))
> +#define of_node_cmp(s1, s2) =A0 =A0 =A0 =A0 =A0 =A0strcasecmp((s1), (s2)=
)
> +
> =A0#define HAVE_ARCH_DEVTREE_FIXUPS
>
> =A0#ifdef CONFIG_PPC32
>
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
