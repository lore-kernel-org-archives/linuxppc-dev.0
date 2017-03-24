Return-Path: <srs0=zpq8=3b=au1.ibm.com=michael.neuling@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vqHRC2XSYzDqcL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 19:59:19 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vqHRC1ltLz8wBV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 19:59:19 +1100 (AEDT)
Message-ID: <1490345959.28113.67.camel@au1.ibm.com>
Subject: Re: [PATCH v3 06/10] VAS: Define helpers to alloc/free windows
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: stewart@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 apopple@au1.ibm.com,  oohall@gmail.com
Date: Fri, 24 Mar 2017 19:59:19 +1100
In-Reply-To: <1489721642-5657-7-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1489721642-5657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1489721642-5657-7-git-send-email-sukadev@linux.vnet.ibm.com>
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
> Define helpers to allocate/free VAS window objects. These will
> be used in follow-on patches when opening/closing windows.
>=20
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> =C2=A0drivers/misc/vas/vas-window.c | 74 ++++++++++++++++++++++++++++++++=
+++++++++-
> -
> =C2=A01 file changed, 72 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/vas/vas-window.c b/drivers/misc/vas/vas-window.=
c
> index edf5c9f..9233bf5 100644
> --- a/drivers/misc/vas/vas-window.c
> +++ b/drivers/misc/vas/vas-window.c
> @@ -119,7 +119,7 @@ static void unmap_wc_mmio_bars(struct vas_window *win=
dow)
> =C2=A0 * OS/User Window Context (UWC) MMIO Base Address Region for the gi=
ven
> window.
> =C2=A0 * Map these bus addresses and save the mapped kernel addresses in =
@window.
> =C2=A0 */
> -int map_wc_mmio_bars(struct vas_window *window)
> +static int map_wc_mmio_bars(struct vas_window *window)
> =C2=A0{
> =C2=A0	int len;
> =C2=A0	uint64_t start;
> @@ -472,8 +472,78 @@ int init_winctx_regs(struct vas_window *window, stru=
ct
> vas_winctx *winctx)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -/* stub for now */
> +DEFINE_SPINLOCK(vas_ida_lock);
> +
> +void vas_release_window_id(struct ida *ida, int winid)
> +{
> +	spin_lock(&vas_ida_lock);
> +	ida_remove(ida, winid);
> +	spin_unlock(&vas_ida_lock);
> +}
> +
> +int vas_assign_window_id(struct ida *ida)
> +{
> +	int rc, winid;
> +
> +	rc =3D ida_pre_get(ida, GFP_KERNEL);
> +	if (!rc)
> +		return -EAGAIN;
> +
> +	spin_lock(&vas_ida_lock);
> +	rc =3D ida_get_new_above(ida, 0, &winid);
> +	spin_unlock(&vas_ida_lock);
> +
> +	if (rc)
> +		return rc;
> +
> +	if (winid > VAS_MAX_WINDOWS_PER_CHIP) {
> +		pr_err("VAS: Too many (%d) open windows\n", winid);
> +		vas_release_window_id(ida, winid);
> +		return -EAGAIN;
> +	}
> +
> +	return winid;
> +}
> +
> +static void vas_window_free(struct vas_window *window)
> +{
> +	unmap_wc_mmio_bars(window);
> +	kfree(window->paste_addr_name);
> +	kfree(window);
> +}
> +
> +static struct vas_window *vas_window_alloc(struct vas_instance *vinst, i=
nt
> id)
> +{
> +	struct vas_window *window;
> +
> +	window =3D kzalloc(sizeof(*window), GFP_KERNEL);
> +	if (!window)
> +		return NULL;
> +
> +	window->vinst =3D vinst;
> +	window->winid =3D id;
> +
> +	if (map_wc_mmio_bars(window))
> +		goto out_free;
> +
> +	return window;
> +
> +out_free:
> +	kfree(window);
> +	return NULL;
> +}
> +
> =C2=A0int vas_window_reset(struct vas_instance *vinst, int winid)
>=20

This interface seems a little weird to me. Needing an alloc in a hardware r=
eset
path seems a bit strange.

Maybe the data structures are the issue.  A window is a hardware construct.=
=20
Something that uses it should probably be called something else like a cont=
ext.=20
Something that references a window should just be the vas_instance + winid.=
=20

You should be able to reset this hardware window by referencing structures
already allocated.  Something associated with the struct vas_instance.

Mikey

> =C2=A0{
> +	struct vas_window *window;
> +
> +	window =3D vas_window_alloc(vinst, winid);
> +	if (!window)
> +		return -ENOMEM;
> +
> +	reset_window_regs(window);
> +
> +	vas_window_free(window);
> +
> =C2=A0	return 0;
> =C2=A0}
