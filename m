Return-Path: <srs0=zpq8=3b=au1.ibm.com=michael.neuling@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq9zL34LNzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:53:18 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vq9zL2PLzz8wBM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 15:53:18 +1100 (AEDT)
Message-ID: <1490331198.28113.61.camel@au1.ibm.com>
Subject: Re: [PATCH v3 04/10] VAS: Define helpers for access MMIO regions
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 15:53:18 +1100
In-Reply-To: <1489721642-5657-5-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-5-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-16 at 20:33 -0700, Sukadev Bhattiprolu wrote:
> Define some helper functions to access the MMIO regions. We use these
> in a follow-on patches to read/write VAS hardware registers. These
> helpers are also used to later issue 'paste' instructions to submit
> requests to the NX hardware engines.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog [v3]:
> 	- Minor reorg/cleanup of map/unmap functions
>=20
> Changelog [v2]:
> 	- Get HVWC, UWC and paste addresses from window->vinst (i.e DT)
> 	=C2=A0=C2=A0rather than kernel macros.
> ---
> =C2=A0drivers/misc/vas/vas-window.c | 126
> ++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 126 insertions(+)
>=20
> diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.=
c
> index 468f3bf..32dd1d0 100644
> --- a/drivers/misc/vas/vas-window.c
> +++ b/drivers/misc/vas/vas-window.c
> @@ -9,9 +9,135 @@
> =C2=A0
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> =C2=A0#include <asm/vas.h>
> =C2=A0#include "vas-internal.h"
> =C2=A0
> +/*
> + * Compute the paste address region for the window @window using the
> + * ->win_base_addr and ->win_id_shift we got from device tree.
> + */
> +void compute_paste_address(struct vas_window *window, uint64_t *addr, in=
t
> *len)
> +{
> +	uint64_t base, shift;
> +	int winid;
> +
> +	base =3D window->vinst->win_base_addr;
> +	shift =3D window->vinst->win_id_shift;
> +	winid =3D window->winid;
> +
> +	*addr=C2=A0=C2=A0=3D base + (winid << shift);
> +	*len =3D PAGE_SIZE;
> +
> +	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
> +}
> +
> +static inline void get_hvwc_mmio_bar(struct vas_window *window,
> +			uint64_t *start, int *len)
> +{
> +	uint64_t pbaddr;
> +
> +	pbaddr =3D window->vinst->hvwc_bar_start;
> +	*start =3D pbaddr + window->winid * VAS_HVWC_SIZE;
> +	*len =3D VAS_HVWC_SIZE;
> +}
> +
> +static inline void get_uwc_mmio_bar(struct vas_window *window,
> +			uint64_t *start, int *len)
> +{
> +	uint64_t pbaddr;
> +
> +	pbaddr =3D window->vinst->uwc_bar_start;
> +	*start =3D pbaddr + window->winid * VAS_UWC_SIZE;
> +	*len =3D VAS_UWC_SIZE;

I'm not sure this works for 4K pages since VAS_UWC_SIZE =3D PAGE_SIZE but i=
n
reality I think it's always 64K.  Right?

Seem like we are mixing pages sizes and hardware sizes here.

(I realise 4K isn't supported yet, but....)

> +}
> +
> +static void *map_mmio_region(char *name, uint64_t start, int len)
> +{
> +	void *map;
> +
> +	if (!request_mem_region(start, len, name)) {
> +		pr_devel("%s(): request_mem_region(0x%llx, %d) failed\n",
> +				__func__, start, len);
> +		return NULL;
> +	}
> +
> +	map =3D __ioremap(start, len, pgprot_val(pgprot_cached(__pgprot(0))));
> +	if (!map) {
> +		pr_devel("%s(): ioremap(0x%llx, %d) failed\n", __func__,
> start,
> +				len);
> +		return NULL;
> +	}
> +
> +	return map;
> +}
> +
> +/*
> + * Unmap the MMIO regions for a window.
> + */
> +static void unmap_wc_paste_kaddr(struct vas_window *window)
> +{
> +	int len;
> +	uint64_t busaddr_start;
> +
> +	if (window->paste_kaddr) {
> +		iounmap(window->paste_kaddr);
> +		compute_paste_address(window, &busaddr_start, &len);
> +		release_mem_region((phys_addr_t)busaddr_start, len);
> +		window->paste_kaddr =3D NULL;
> +	}
> +
> +}
> +
> +static void unmap_wc_mmio_bars(struct vas_window *window)
> +{
> +	int len;
> +	uint64_t busaddr_start;
> +
> +	unmap_wc_paste_kaddr(window);
> +
> +	if (window->hvwc_map) {
> +		iounmap(window->hvwc_map);
> +		get_hvwc_mmio_bar(window, &busaddr_start, &len);
> +		release_mem_region((phys_addr_t)busaddr_start, len);
> +		window->hvwc_map =3D NULL;
> +	}
> +
> +	if (window->uwc_map) {
> +		iounmap(window->uwc_map);
> +		get_uwc_mmio_bar(window, &busaddr_start, &len);
> +		release_mem_region((phys_addr_t)busaddr_start, len);
> +		window->uwc_map =3D NULL;
> +	}
> +}
> +
> +/*
> + * Find the Hypervisor Window Context (HVWC) MMIO Base Address Region an=
d the
> + * OS/User Window Context (UWC) MMIO Base Address Region for the given
> window.
> + * Map these bus addresses and save the mapped kernel addresses in @wind=
ow.
> + */
> +int map_wc_mmio_bars(struct vas_window *window)
> +{
> +	int len;
> +	uint64_t start;
> +
> +	window->paste_kaddr =3D window->hvwc_map =3D window->uwc_map =3D NULL;
> +
> +	get_hvwc_mmio_bar(window, &start, &len);
> +	window->hvwc_map =3D map_mmio_region("HVWCM_Window", start, len);
> +
> +	get_uwc_mmio_bar(window, &start, &len);
> +	window->uwc_map =3D map_mmio_region("UWCM_Window", start, len);
> +
> +	if (!window->hvwc_map || !window->uwc_map) {
> +		unmap_wc_mmio_bars(window);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0/* stub for now */
> =C2=A0int vas_window_reset(struct vas_instance *vinst, int winid)
> =C2=A0{
