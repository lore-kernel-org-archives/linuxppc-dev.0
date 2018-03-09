Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyKxm45MLzF196
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2018 19:17:48 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w298HJ91098567
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 03:17:46 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gkgeev89h-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 03:17:46 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 08:17:43 -0000
Date: Fri, 09 Mar 2018 13:47:38 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras
 <paulus@ozlabs.org>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180307124553.312ea88c@vmware.local.home>
 <1520447419.431mwwg71x.naveen@linux.ibm.com>
 <20180307140232.0023b8cc@vmware.local.home>
In-Reply-To: <20180307140232.0023b8cc@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1520583359.xj3hnnu1tw.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Thu, 08 Mar 2018 00:07:07 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Yes, that's negligible.
>> Though, to be honest, I will have to introduce a 'mfmsr' for the older=20
>> -pg variant. I still think that the improved reliability far outweighs=20
>> the minor slowdown there.
>=20
> In that case, can you introduce a read_mostly variable that can be
> tested before calling the mfmsr. Why punish normal ftrace tracing if
> kvm is not enabled or running?
>=20
> Both should probably have an #ifdef CONFIG_KVM encapsulating the code.

Agreed. My previous intent was to exclude all realmode code from ftrace,=20
but I now think it is better to only exclude the KVM path. So, I will=20
make it specific to KVM.

- Naveen

=
