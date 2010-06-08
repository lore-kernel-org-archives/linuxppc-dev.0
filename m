Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 4EB0AB7D20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jun 2010 16:54:45 +1000 (EST)
Subject: Re: [PATCH] agp/uninorth: Fix oops caused by flushing too much
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20100602053308.GA24509@drongo>
References: <20100602053308.GA24509@drongo>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 08 Jun 2010 08:48:11 +0200
Message-ID: <1275979691.3246.177.camel@thor.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mit, 2010-06-02 at 15:33 +1000, Paul Mackerras wrote:=20
> This fixes a sporadic oops at boot on G5 Power Macs.  The table_end
> variable has the address of the last byte of the table.  Adding on
> PAGE_SIZE means we flush too much, and if the page after the table
> is not mapped for any reason, the kernel will oops.  Instead we add
> on 1 because flush_dcache_range() interprets its second argument as
> the first byte past the range to be flushed.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Reviewed-by: Michel D=C3=A4nzer <michel@daenzer.net>
Tested-by: Michel D=C3=A4nzer <michel@daenzer.net>


Thanks for the good catch, Paul.


> ---
>=20
> diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-=
agp.c
> index 6f48931..9aaa0eb 100644
> --- a/drivers/char/agp/uninorth-agp.c
> +++ b/drivers/char/agp/uninorth-agp.c
> @@ -413,7 +413,7 @@ static int uninorth_create_gatt_table(struct agp_brid=
ge_data *bridge)
>  	bridge->gatt_table_real =3D (u32 *) table;
>  	/* Need to clear out any dirty data still sitting in caches */
>  	flush_dcache_range((unsigned long)table,
> -			   (unsigned long)(table_end + PAGE_SIZE));
> +			   (unsigned long)table_end + 1);
>  	bridge->gatt_table =3D vmap(pages, (1 << page_order), 0, PAGE_KERNEL_NC=
G);
> =20
>  	if (bridge->gatt_table =3D=3D NULL)




--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer
