Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D53F61A0C4D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 19:45:08 +1100 (AEDT)
Date: Wed, 23 Dec 2015 19:45:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: paulus@samba.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com,
 lvivier@redhat.com, thuth@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 3/3] pseries: sysfs hack to trigger a hash page table resize
Message-ID: <20151223084548.GW3011@voom.redhat.com>
References: <1450761298-12172-1-git-send-email-david@gibson.dropbear.id.au>
 <1450761298-12172-4-git-send-email-david@gibson.dropbear.id.au>
 <CAOJe8K3U-wF-kMXWwXnR=fPf0UCVfaLnqLOBfXCJFHEcpoXy5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="w1TwAseT95X423KH"
In-Reply-To: <CAOJe8K3U-wF-kMXWwXnR=fPf0UCVfaLnqLOBfXCJFHEcpoXy5A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--w1TwAseT95X423KH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 22, 2015 at 02:19:20PM +0300, Denis Kirjanov wrote:
> On 12/22/15, David Gibson <david@gibson.dropbear.id.au> wrote:
> > This patch adds a special file in /sys/kernel/mm which can be used to v=
iew
> > the current size of the hash page table (as a bit shift) and to trigger
> > a resize of the hash table on PAPR guests.
> >
> > Logically this would make more sense as a debugfs file, but that doesn't
> > see to provide an obvious way to have a "store" function that has an ef=
fect
> > other than updating a variable.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  arch/powerpc/platforms/pseries/lpar.c | 41
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/arch/powerpc/platforms/pseries/lpar.c
> > b/arch/powerpc/platforms/pseries/lpar.c
> > index aadb242..2759767 100644
> > --- a/arch/powerpc/platforms/pseries/lpar.c
> > +++ b/arch/powerpc/platforms/pseries/lpar.c
> > @@ -903,3 +903,44 @@ int pSeries_lpar_resize_hpt(unsigned long shift)
> >
> >  	return 0;
> >  }
> > +
> > +static ssize_t ppc64_pft_size_show(struct kobject *kobj,
> > +				   struct kobj_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%llu\n", (unsigned long long)ppc64_pft_size);
> > +}
> > +
> > +static ssize_t ppc64_pft_size_store(struct kobject *kobj,
> > +				    struct kobj_attribute *attr,
> > +				    const char *buf, size_t count)
> > +{
> > +	unsigned long new_shift;
> > +	int rc;
> > +
> > +	pr_err("lpar: ppc64_pft_size_store() count=3D%zd\n", count);
> Why pr_err?

Uh.. good question.  That's a not particularly useful debug comment I
should just remove anyway.

> > +
> > +	if (kstrtoul(buf, 0, &new_shift))
> > +		return -EINVAL;
> > +
> > +	rc =3D pSeries_lpar_resize_hpt(new_shift);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return count;
> > +}
> > +
> > +static struct kobj_attribute ppc64_pft_size_attr =3D
> > +	__ATTR(ppc64_pft_size, 0600, ppc64_pft_size_show, ppc64_pft_size_stor=
e);
> > +
> > +static int __init pseries_lpar_sysfs(void)
> > +{
> > +	int rc;
> > +
> > +	rc =3D sysfs_create_file(mm_kobj, &ppc64_pft_size_attr.attr);
> > +	if (rc)
> > +		pr_err("lpar: unable to create ppc64_pft_size sysfs file (%d)\n",
> > +		       rc);
> > +
> > +	return 0;
> I think that we need to return rc value, right?

No.  Failing to register this sysfs file shouldn't cause the boot to fail.

> > +}
> > +machine_device_initcall(pseries, pseries_lpar_sysfs);
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w1TwAseT95X423KH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWel88AAoJEGw4ysog2bOSKQ8QAINB+D49uiMnnKqKvMg6H3Qi
Xm/bVic9TPRfKGUqIpWQtOPlRkujfb+nKTxUvLKRBEvoE+HqwuBA/1u427MS0W/F
V9vFEILc6w46AukxnJsjX12MfLP3jrg1xeVeV9HgPQA4N/H1WFaVYaNcsiVkzQVd
VLa+4J4zQ/hD79bx+mkxg+S58HRzguAVffqhzXwjfewdSfQdBE/KaqqVC4I0RQNU
Ge+/qeMvN37lKDpMjro92MqsEgJD1DTtEd7LmTLogsqA52CTOLBKyegugjVMQuJm
VzozFMSBZG2FZhqk/q5uHiz8bgpAmXNdx6Au5fjqVYbzt6t+CuweYpfy909o7kW2
CFZ7r4puBfbys6997BXhfeIYsknRU7rI6/KGFUaS5+96++riPG4F6UH2STJ4ISnX
QZ+/w0FhOdIOH/UGC04UFKUjVFCewOE6vCcToDURgsOwpSfDnjUBave4VoMxjxUE
PzU/RR8eEm8NOQ1KYrlqbxl3MSmL3gnhSzsahfK3qqKahfAm6IAW0/vNdGeHgA9/
WPgu/HqY9v6YCehvaZtvR3E10qTVywIim6ulyd2tdCzu0TeaK2xGBxeDwemCDMKg
TXzatwRtctSTYxGlp72RHzAJ88X2tsUqnkJ18UwhFjwKgSIoNOrpFmEUWtmp/zjq
FmZ9d0YcuTC8pT9DR4he
=BsYv
-----END PGP SIGNATURE-----

--w1TwAseT95X423KH--
