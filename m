Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CB2EADDECA
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 15:26:04 +1100 (EST)
Date: Tue, 8 Jan 2008 15:25:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 7/8] pseries: phyp dump: Unregister and print dump areas.
Message-Id: <20080108152554.eb06f84a.sfr@canb.auug.org.au>
In-Reply-To: <4782C5CB.4080802@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C5CB.4080802@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_15_25_54_+1100_bk9kw_t_kf5YhH/5"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_15_25_54_+1100_bk9kw_t_kf5YhH/5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

Just more trivial stuff.

On Mon, 07 Jan 2008 18:37:31 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
>  static void register_dump_area(struct phyp_dump_header *ph, unsigned lon=
g addr)
>  {
>  	int rc;
> -	ph->cpu_data.destination_address +=3D addr;
> -	ph->hpte_data.destination_address +=3D addr;
> -	ph->kernel_data.destination_address +=3D addr;
> =20
> +	/* Add addr value if not initialized before */
> +	if (ph->cpu_data.destination_address =3D=3D 0) {
> +		ph->cpu_data.destination_address +=3D addr;

Could be just '=3D' like further down, right?

> +static void invalidate_last_dump(struct phyp_dump_header *ph, unsigned l=
ong addr)
> +{

> +	if (rc)
> +	{

We prefer
	if (rc) {

> +static void unregister_dump_area(struct phyp_dump_header *ph)
> +{

> +	if (rc)
> +	{

And again.

>  static ssize_t
>  show_release_region(struct kset * kset, char *buf)

We normally put the function name on the same line as the type.

>  {
> -	return sprintf(buf, "ola\n");
> +	u64 second_addr_range;
> +
> +	/* total reserved size - start of scratch area */
> +	second_addr_range =3D phdr.cpu_data.destination_address -
> +				phyp_dump_info->init_reserve_size;
> +	return sprintf(buf, "CPU:0x%lx-0x%lx: HPTE:0x%lx-0x%lx:"
> +			    " DUMP:0x%lx-0x%lx, 0x%lx-0x%lx:\n",
> +	  phdr.cpu_data.destination_address, phdr.cpu_data.length_copied,
> +	  phdr.hpte_data.destination_address, phdr.hpte_data.length_copied,
> +	  phdr.kernel_data.destination_address, phdr.kernel_data.length_copied,
> +	  phyp_dump_info->init_reserve_start, second_addr_range);

This indentation should be (probably) two tabs.

> +	/* re-register the dump area, if old dump was invalid */
> +	if ((dump_header) && (dump_header->status & DUMP_ERROR_FLAG)) {
            ^           ^
Extra parentheses.

> +		invalidate_last_dump (&phdr, dump_area_start);
> +		register_dump_area (&phdr, dump_area_start);

No spaces after function names.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_15_25_54_+1100_bk9kw_t_kf5YhH/5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgvtWTgG2atn1QN8RAk3zAJ4j/ycboYw8jSy/QNK4AKBowqTucACgjH5J
wCMWiFcS06P7GUHtZzKVbGE=
=0sTx
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_15_25_54_+1100_bk9kw_t_kf5YhH/5--
