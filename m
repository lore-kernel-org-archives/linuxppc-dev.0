Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVmQz1pGVzDqfP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 00:46:03 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rVmQy4XR4z9t0f
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2016 00:46:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GEi7Sc022734
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 10:45:59 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23kdg5j635-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2016 10:45:59 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 08:45:57 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@au1.ibm.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: kernel bug in "Drop WIMG in favour of new constants"?
In-Reply-To: <1466078709.24271.17.camel@au1.ibm.com>
References: <20160616043340.GB22590@birch.djwong.org>
 <1466078709.24271.17.camel@au1.ibm.com>
Date: Thu, 16 Jun 2016 20:15:42 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87r3bx8a5l.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@au1.ibm.com> writes:

>=20=09
>  <1466054627.5400.5.camel@ellerman.id.au>
>=20=09
>=20=09
>  <20160616055746.GC22590@birch.djwong.org>
>=20=09
>=20=09
>  <8737oda1lt.fsf@skywalker.in.ibm.com>
>=20=09
> 	 <87ziql8l93.fsf@skywalker.in.ibm.com>
> 	 <87wplp8kxh.fsf@skywalker.in.ibm.com>
> Organization: IBM Australia
> Content-Type: text/plain; charset=3D"UTF-8"
> X-Mailer: Evolution 3.20.3 (3.20.3-1.fc24)=20
> Mime-Version: 1.0
> Content-Transfer-Encoding: 8bit
>
> On Thu, 2016-06-16 at 16:22 +0530, Aneesh Kumar K.V wrote:
>> Hmm Qemu=C2=A0 does
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Looks like an IO address */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME: What WIMG combinati=
ons could be sensible for IO?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For now we allow WIMG=
=3D010x, but are there others? */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME: Should we check aga=
inst registered IO addresses? */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((ptel & (HPTE64_R_W | HPT=
E64_R_I | HPTE64_R_M)) !=3D HPTE64_R_I) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n H_PARAMETER;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20
>> -aneesh
>
> And what do we get ? M ? I think we might be OR'ing it
> unconditionaly...
>

Yes we do. We did that for a long time. But we had special case handing
for the lpar case. I already sent a patch to update that. But I am not
sure whether to fix this in the kernel or in Qemu.

-aneesh
