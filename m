Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB8CA1A184B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 10:42:51 +1000 (EST)
Message-ID: <1412210571.19209.80.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 02/17] powerpc/cell: Move data segment faulting code
 out of cell platform
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 02 Oct 2014 10:42:51 +1000
In-Reply-To: <20141001064757.BFF88140174@ozlabs.org>
References: <20141001064757.BFF88140174@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 16:47 +1000, Michael Ellerman wrote:
> On Tue, 2014-30-09 at 10:34:51 UTC, Michael Neuling wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >=20
> > __spu_trap_data_seg() currently contains code to determine the VSID and=
 ESID
> > required for a particular EA and mm struct.
> >=20
> > This code is generically useful for other co-processors.  This moves th=
e code
> > of the cell platform so it can be used by other powerpc code.  It also =
adds 1TB
> > segment handling which Cell didn't have.
>=20
> I'm not loving this.
>=20
> For starters the name "copro_data_segment()" doesn't contain any verbs, a=
nd it
> doesn't tell me what it does.

Ok.

> If we give it a name that says what it does, we get copro_get_ea_esid_and=
_vsid().
> Or something equally ugly.

Ok

> And then in patch 10 you move the bulk of the logic into calculate_vsid()=
.

That was intentional on my part.  I want this patch to be clear that
we're moving this code out of cell.  Then I wanted the optimisations to
be in a separate patch.  It does mean we touch the code twice in this
series, but I was hoping it would make it easier to review.  Alas. :-)

> So instead can we:
>  - add a small helper that does the esid calculation, eg. calculate_esid(=
) ?
>  - factor out the vsid logic into a helper, calculate_vsid() ?
>  - rework the spu code to use those, dropping __spu_trap_data_seg()
>  - use the helpers in the cxl code

OK, I think I can do that.  I might change the name to something better
in this patch, but I'll leave these cleanups to the later patch 10.

Mikey
