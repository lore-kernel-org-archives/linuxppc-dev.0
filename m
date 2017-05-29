Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbzkL5sjLzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:33:30 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4TETw5b080470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 10:33:27 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aqn3g9nwe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 10:33:26 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 30 May 2017 00:33:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4TEXDpA66388002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:33:21 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4TEWl7r004850
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 00:32:48 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/mm: Rename find_linux_pte_or_hugepte
In-Reply-To: <1494997069.3092.5.camel@kernel.crashing.org>
References: <1494926782-25700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494926782-25700-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1494933772.21847.48.camel@kernel.crashing.org>
 <87wp9g17tt.fsf@skywalker.in.ibm.com>
 <1494997069.3092.5.camel@kernel.crashing.org>
Date: Mon, 29 May 2017 20:02:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87zidvpwcl.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Wed, 2017-05-17 at 08:57 +0530, Aneesh Kumar K.V wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>>=20
>> > On Tue, 2017-05-16 at 14:56 +0530, Aneesh Kumar K.V wrote:
>> > > +static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea,
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool *is_th=
p, unsigned *hshift)
>> > > +{
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VM_WARN((!arch_irqs_disab=
led() && !__hard_irqs_disabled()) ,
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"%s called with irq enabled\n", __func__);
>> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return __find_linux_pte(p=
gdir, ea, is_thp, hshift);
>> > > +}
>> > > +
>> >=20
>> > When is arch_irqs_disabled() not sufficient ?
>>=20
>> We can do lockless page table walk in interrupt handlers where we find
>> MSR_EE =3D 0.=20
>
> Such as ?
>

kvmppc_do_h_enter() when get called in real mode.

For now i have dropped hard_irq_disabled() and switched these usage to
__find_linux_pte with explict comment around them stating they are
called with MSR_EE =3D 0.

-aneesh
