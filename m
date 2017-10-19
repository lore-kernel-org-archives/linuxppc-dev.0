Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHpRH6MwpzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:39:55 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:39:49 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linuxppc-dev@lists.ozlabs.org, Rob Herring <robh@kernel.org>, Sahil
 Mehta <sahilmehta17@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Tyrel
 Datwyler <tyreld@linux.vnet.ibm.com>, kernel-janitors@vger.kernel.org, Doug
 Ledford <dledford@redhat.com>, Johan Hovold <johan@kernel.org>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@samba.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bart Van Assche
 <bart.vanassche@sandisk.com>, Andrew Morton <akpm@linux-foundation.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 4/5] powerpc-pseries: Return directly after a failed
 kzalloc_node() in iommu_pseries_alloc_group()
Message-ID: <20171019143949.2c87ea66@kitsune.suse.cz>
In-Reply-To: <2f1e61bd-9d79-1b9f-e686-f9d13a6f0afc@users.sourceforge.net>
References: <0d221be4-1402-0499-d95e-afa4a30e1f33@users.sourceforge.net>
 <a824fe65-1708-16ba-68d6-df0f73e0f49a@users.sourceforge.net>
 <20171019134148.52b890b4@kitsune.suse.cz>
 <2f1e61bd-9d79-1b9f-e686-f9d13a6f0afc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 19 Oct 2017 14:04:43 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> >> @@ -61,7 +61,7 @@ static struct iommu_table_group
> >> *iommu_pseries_alloc_group(int node) table_group =3D
> >> kzalloc_node(sizeof(*table_group), GFP_KERNEL, node); if
> >> (!table_group)
> >> -		goto fail_exit;
> >> +		return NULL;
> >> =20
> >>  	tbl =3D kzalloc_node(sizeof(*tbl), GFP_KERNEL, node);
> >>  	if (!tbl) =20
> >=20
> > I have seen quite a few fixes that do inverse of this patch after a
> > piece of code allocating some extra piece of memory was added before
> > code that just returns on fail because it is the first allocation in
> > the function.
> >=20
> > This is not useful. =20
>=20
> How do you think about an information from the section =E2=80=9C7)
> Centralized exiting of functions=E2=80=9D in the document =E2=80=9Ccoding=
-style.rst=E2=80=9D
> then?
>=20
> =E2=80=9C=E2=80=A6
> If there is no cleanup needed then just return directly.
> =E2=80=A6=E2=80=9D

There is also stated benefit

"
- errors by not updating individual exit points when making
  modifications are prevented
"

which is furthered by using the common cleanup even in case no cleanup
is required but running the cleanup does not cause any harm.

Thanks

Michal
