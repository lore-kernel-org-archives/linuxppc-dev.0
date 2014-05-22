Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BF5F1A0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:38:55 +1000 (EST)
Date: Fri, 23 May 2014 08:38:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf/hv-24x7: use kmem_cache instead of aligned
 stack allocations
Message-ID: <20140523083847.4e039ddb@canb.auug.org.au>
In-Reply-To: <1400797756-6057-1-git-send-email-cody@linux.vnet.ibm.com>
References: <537E78AD.1040409@linux.vnet.ibm.com>
 <1400797756-6057-1-git-send-email-cody@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vY7w.S42ucd/t8Q=uJdy8J="; protocol="application/pgp-signature"
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 mingo@redhat.com, paulus@samba.org, imunsie@au1.ibm.com,
 acme@ghostprotocols.net, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/vY7w.S42ucd/t8Q=uJdy8J=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Cody,

On Thu, 22 May 2014 15:29:08 -0700 Cody P Schafer <cody@linux.vnet.ibm.com>=
 wrote:
>
> -	*res =3D be64_to_cpu(result_buffer.result);
> +	*res =3D be64_to_cpu(result_buffer->result);
> +	kfree(result_buffer);
> +	kfree(request_buffer);
> +	return ret;

Why not just fall through here by removing the above 3 lines?

> +
> +out_hcall:
> +	kfree(result_buffer);
> +out_resb:
> +	kfree(request_buffer);
> +out_reqb:
>  	return ret;
>  }

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/vY7w.S42ucd/t8Q=uJdy8J=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTfnx8AAoJEMDTa8Ir7ZwVbBcP/AmC6VxAvD37K/pqbIdteq5s
pzy2Jien5QdRiePqxJl9G0TH20KQANMrejTwhhbbQuHs86qAYC9HhEgtfxl4jnXc
UGadMbw9gYgUGbXW2O5k6bRxHBX0nDw/HzA4UR1s4B12dJXi5LWcEXglY+v5/k1j
PsGhx2zA4t1w28/kY1KunOcwyqZDnkVudBETcdErCtyBV9l7z3DyQwQr2lfKNSCv
LYnRW4za2jKe3YHIgGNQpmdb5nn2Y0TLf3QnF/+DDFe7CRYmNhBbPCtj2dQD57HK
itvUTSzoAYjarOZ0tql/0cAVKh+LcNz+2qBZk8jMwrqElOwVBabSh/S6GW1w+TLF
UdNJ939AFnidpl1v6xsMXx3lfXkqQDf1PCZ45pMzgIzhcKqkpXhfOmCebOR4Wi5H
miqCw7jmES9zkUgg0FfQfvBsYQlM/bjNdHE0Aio0E9QFeKSs6gPWHJcgkHCiYkqF
PEESWNw94wXEWm0IDmTd97c7W8xKsoy4BJJ9Wk3RG44CMz3KfVShf7JZbVYVvG/B
xcn/LZig6QaZK3namhVdf+albHi4Svbcg9Vzp+ByouOdEn08iTCrsm723cJ/a6GR
mLkyOlP17NtyiaVavC5AgmCdTbbKe54JNz1dK7vSleWmpbm+7+ulQX9b35RfY6Y0
Ron3JypLQaI6R0ZME1Hy
=y+gw
-----END PGP SIGNATURE-----

--Sig_/vY7w.S42ucd/t8Q=uJdy8J=--
