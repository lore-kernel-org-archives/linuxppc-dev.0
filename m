Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf3xs5dZTzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:49:37 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SBmvSq024474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:49:35 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sjuhh1px-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 07:49:35 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 05:49:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/38] powerpc: Move 64-bit feature fixup earlier
In-Reply-To: <1467112469.20278.123.camel@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
 <1467026976-7974-7-git-send-email-benh@kernel.crashing.org>
 <87a8i560ak.fsf@skywalker.in.ibm.com>
 <1467112469.20278.123.camel@kernel.crashing.org>
Date: Tue, 28 Jun 2016 17:19:26 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <877fd95y9l.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2016-06-28 at 16:35 +0530, Aneesh Kumar K.V wrote:
>> Why not move it immediately after we finish all the device tress
>> scan.
>
> Do you need it in early_init_mmu ? The important thing is to have it
> done before we *turn on* the MMU but yeah, there's no big deal
> moving it even further up I think..

If we can do feature fixup early. Then this patch series become simpler.

https://lkml.kernel.org/r/1465887288-12952-1-git-send-email-aneesh.kumar@li=
nux.vnet.ibm.com

ie, we can now start using cpu_has_feature/mmu_has_feature early instead
of using __cpu/mmu_has_feature.

>
>> ie,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0early_init_devtree(__va(=
dt_ptr));
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0epapr_paravirt_early_ini=
t();
>>=20
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apply_feature_fixups();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Now we know the logic=
al id of our boot cpu, setup the
>> paca. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0setup_paca(&paca[boot_cp=
uid]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fixup_boot_paca();
>>=20
>> Also with a comment explaining why we can't move it further up ?
>
> Yup, adding some comments about the why things are done in that order
> would be good, I'll improve that
>
> Cheers,
> Ben.

-aneesh
