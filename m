Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yx3sk6nxqzDrWg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 02:39:38 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBCFbEfa107933
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 10:39:34 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ethhw1ece-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 10:39:33 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 12 Dec 2017 15:39:32 -0000
Date: Tue, 12 Dec 2017 21:09:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: Dereference bhrb entries safely
To: mpe@ellerman.id.au, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, kamalesh@linux.vnet.ibm.com, kan.liang@intel.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, paulus@samba.org, tglx@linutronix.de
References: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
In-Reply-To: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1513093135.p9uc48ls6m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Bangoria wrote:
> It may very well happen that branch instructions recorded by
> bhrb entries already get unmapped before they get processed by
> the kernel. Hence, trying to dereference such memory location
> will endup in a crash. Ex,
>=20
>     Unable to handle kernel paging request for data at address 0xc0080000=
19c41764
>     Faulting instruction address: 0xc000000000084a14
>     NIP [c000000000084a14] branch_target+0x4/0x70
>     LR [c0000000000eb828] record_and_restart+0x568/0x5c0
>     Call Trace:
>     [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
>     [c0000000000ec378] perf_event_interrupt+0x298/0x460
>     [c000000000027964] performance_monitor_exception+0x54/0x70
>     [c000000000009ba4] performance_monitor_common+0x114/0x120
>=20
> Fix this by deferefencing them safely.
>=20
> Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen

=
