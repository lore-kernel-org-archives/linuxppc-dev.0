Return-Path: <srs0=adkq=4a=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBYCM1RHfzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 03:25:51 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBYCM0Ql7z8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 03:25:51 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBYCL3Mrrz9sDb
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2017 03:25:50 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3OHNoxZ140248
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 13:25:45 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a1jn1ttds-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 13:25:44 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 13:25:43 -0400
Date: Mon, 24 Apr 2017 10:25:27 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, michael.neuling@au1.ibm.com,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v4 05/11] VAS: Define helpers for access MMIO regions
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <1493015287.25766.213.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1493015287.25766.213.camel@kernel.crashing.org>
Message-Id: <20170424172527.GA15532@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt [benh@kernel.crashing.org] wrote:
> On Thu, 2017-03-30 at 22:13 -0700, Sukadev Bhattiprolu wrote:
> > +static void *map_mmio_region(char *name, uint64_t start, int len)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0void *map;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (!request_mem_region(start, len, name)) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_devel("%s(): request_m=
em_region(0x%llx, %d) failed\n",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0__func__, start, len);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0map =3D __ioremap(start, len, pgprot_val(pgprot_c=
ached(__pgprot(0))));
> > +=A0=A0=A0=A0=A0=A0=A0if (!map) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0pr_devel("%s(): ioremap(0=
x%llx, %d) failed\n", __func__, start,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0len);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return NULL;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return map;
> > +}
>=20
> That's very wrong. I assume this never worked right ?

Untl recently, only tested on simics and has been working there. On the
hardware, hitting a crash on the first mmio write...
>=20
> MMIO regions must be mapped non-cachable. Only the paste region

which maybe due to this :-) Should I change to pgprot_noncached() for the
MMIO writes?

> requires being mapped cachable. Ask Aneesh for a cleaner way of
> doing it too while at it.

Ok.

>=20
> > +/*
> > + * Unmap the MMIO regions for a window.
> > + */
> > +static void unmap_wc_paste_kaddr(struct vas_window *window)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0int len;
>=20
> Don't use "wc"... that usually means "write combine".

Ok.

Thanks,

Sukadev
