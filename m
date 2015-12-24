Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E26B61A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 17:58:04 +1100 (AEDT)
Date: Thu, 24 Dec 2015 17:37:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: paulus@samba.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 lvivier@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 3/3] pseries: sysfs hack to trigger a hash page table resize
Message-ID: <20151224063734.GX3011@voom.redhat.com>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <1450761298-12172-4-git-send-email-david@gibson.dropbear.id.au>
 <CAOJe8K3U-wF-kMXWwXnR=fPf0UCVfaLnqLOBfXCJFHEcpoXy5A@mail.gmail.com>
 <20151223084548.GW3011@voom.redhat.com>
 <CAOJe8K26k9+iAw1RM2oVCn=gYMCDgfWNhbGJT+kQ=VwM2kXz=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="LvnU4bbuCGLV8PtK"
In-Reply-To: <CAOJe8K26k9+iAw1RM2oVCn=gYMCDgfWNhbGJT+kQ=VwM2kXz=A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LvnU4bbuCGLV8PtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 03:16:39PM +0300, Denis Kirjanov wrote:
> On 12/23/15, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Tue, Dec 22, 2015 at 02:19:20PM +0300, Denis Kirjanov wrote:
> >> On 12/22/15, David Gibson <david@gibson.dropbear.id.au> wrote:
> >> > This patch adds a special file in /sys/kernel/mm which can be used to
> >> > view
> >> > the current size of the hash page table (as a bit shift) and to trig=
ger
> >> > a resize of the hash table on PAPR guests.
> >> >
> >> > Logically this would make more sense as a debugfs file, but that
> >> > doesn't
> >> > see to provide an obvious way to have a "store" function that has an
> >> > effect
> >> > other than updating a variable.
> >> >
> >> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> > ---
> >> >  arch/powerpc/platforms/pseries/lpar.c | 41
> >> > +++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 41 insertions(+)
> >> >
> >> > diff --git a/arch/powerpc/platforms/pseries/lpar.c
> >> > b/arch/powerpc/platforms/pseries/lpar.c
> >> > index aadb242..2759767 100644
> >> > --- a/arch/powerpc/platforms/pseries/lpar.c
> >> > +++ b/arch/powerpc/platforms/pseries/lpar.c
> >> > @@ -903,3 +903,44 @@ int pSeries_lpar_resize_hpt(unsigned long shift)
> >> >
> >> >  	return 0;
> >> >  }
> >> > +
> >> > +static ssize_t ppc64_pft_size_show(struct kobject *kobj,
> >> > +				   struct kobj_attribute *attr, char *buf)
> >> > +{
> >> > +	return sprintf(buf, "%llu\n", (unsigned long long)ppc64_pft_size);
> >> > +}
> >> > +
> >> > +static ssize_t ppc64_pft_size_store(struct kobject *kobj,
> >> > +				    struct kobj_attribute *attr,
> >> > +				    const char *buf, size_t count)
> >> > +{
> >> > +	unsigned long new_shift;
> >> > +	int rc;
> >> > +
> >> > +	pr_err("lpar: ppc64_pft_size_store() count=3D%zd\n", count);
> >> Why pr_err?
> >
> > Uh.. good question.  That's a not particularly useful debug comment I
> > should just remove anyway.
> >
> >> > +
> >> > +	if (kstrtoul(buf, 0, &new_shift))
> >> > +		return -EINVAL;
> >> > +
> >> > +	rc =3D pSeries_lpar_resize_hpt(new_shift);
> >> > +	if (rc < 0)
> >> > +		return rc;
> >> > +
> >> > +	return count;
> >> > +}
> >> > +
> >> > +static struct kobj_attribute ppc64_pft_size_attr =3D
> >> > +	__ATTR(ppc64_pft_size, 0600, ppc64_pft_size_show,
> >> > ppc64_pft_size_store);
> >> > +
> >> > +static int __init pseries_lpar_sysfs(void)
> >> > +{
> >> > +	int rc;
> >> > +
> >> > +	rc =3D sysfs_create_file(mm_kobj, &ppc64_pft_size_attr.attr);
> >> > +	if (rc)
> >> > +		pr_err("lpar: unable to create ppc64_pft_size sysfs file (%d)\n",
> >> > +		       rc);
> >> > +
> >> > +	return 0;
> >> I think that we need to return rc value, right?
> >
> > No.  Failing to register this sysfs file shouldn't cause the boot to fa=
il.
> Then we don't need rc at all ;)

Except to report the error code in the message, which is useful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LvnU4bbuCGLV8PtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWe5KuAAoJEGw4ysog2bOSl8UP/Rj11sv+lZ3k8sTan9x+hU9+
6pbfH2kVgYEGrJeJPx2ewQ6ILNUuQpYjRKgZ/l9wKC1qqu6kpOzheMr21nB3W0e5
vf3gPv6HNRvtnKeq38axFgzvfOdhiwEJoPGKaKTdMVnZ+RjNBZAJuMLkWCwNmSDo
BZar8VqsXfbLXSeaxIkIhNd5TiPpOCC/66kXzGbyJCg3HBwKfKFCt2de07rC7L2t
yb7Vdxg1o0uHs9i54ZjWSF4XRDxkyL4GikhqYNZJnf1yRJ17dr+sUx5Tp0JpHBhK
DxijOFeOyGTrtu5bPd5fTLwlzM02S0pDOrui0WDwvVm9Y7tYJYOCqaqmkGescSSu
F4kaNWvsKC147a3/z+S8kqDZMXFfLJXUPmLveBE/NgcaAlpk2nSYDcgbKYebGd0T
JN99v8YenTKxq/f6zub3COYH1BYbdsVCd+UsjNOaG6bmd004qDQj/6tFaJMoMpTw
mXbex2bXpDM/VQNcpEDEEDerRDdaoKUu8YCKHhRdIONvtQDRliYzf+svBU18QuRX
LPA7lMD3T4pVby2v7cSGL1uXUPd4YLgHuxbm/BuaD3esJCSVTse+OSvx1STloTtT
AgCcSYhzlqe4V965UfakvRZ0Ay/p/F4inqKwZABbbSUg/ng+7br1vkT2fK/HI8AQ
tLaeCfUyT20+GBvuwfz3
=0NvC
-----END PGP SIGNATURE-----

--LvnU4bbuCGLV8PtK--
