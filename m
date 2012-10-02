Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 90B612C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 21:04:17 +1000 (EST)
Subject: Re: [PATCH 3/6] arch/powerpc/kvm/e500_tlb.c: fix error return code
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1344160356-387-4-git-send-email-Julia.Lawall@lip6.fr>
Date: Tue, 2 Oct 2012 13:04:03 +0200
Message-Id: <BF4777C1-E76A-4AEB-A87D-FC2CBB465F98@suse.de>
References: <1344160356-387-1-git-send-email-Julia.Lawall@lip6.fr>
 <1344160356-387-4-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Avi Kivity <avi@redhat.com>, Julia Lawall <julia@diku.dk>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.08.2012, at 11:52, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
>=20
> Convert a 0 error return code to a negative one, as returned elsewhere =
in the
> function.
>=20
> A new label is also added to avoid freeing things that are known to =
not yet
> be allocated.
>=20
> A simplified version of the semantic match that finds the first =
problem is as
> follows: (http://coccinelle.lip6.fr/)
>=20
> // <smpl>
> @@
> identifier ret;
> expression e,e1,e2,e3,e4,x;
> @@
>=20
> (
> if (\(ret !=3D 0\|ret < 0\) || ...) { ... return ...; }
> |
> ret =3D 0
> )
> ... when !=3D ret =3D e1
> *x =3D =
\(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\|ioremap\|ioremap_nocache\|devm_=
ioremap\|devm_ioremap_nocache\)(...);
> ... when !=3D x =3D e2
>    when !=3D ret =3D e3
> *if (x =3D=3D NULL || ...)
> {
>  ... when !=3D ret =3D e4
> *  return ret;
> }
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <julia@diku.dk>

Thanks, applied to kvm-ppc-next.


Alex
