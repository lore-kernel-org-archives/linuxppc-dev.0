Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1wvy23dQzDrnd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 00:43:26 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBKDfKGB108948
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 08:43:24 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eynurt0mk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 08:43:23 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 13:43:21 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: christophe lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V4] cxl: Add support for ASB_Notify on POWER9
In-Reply-To: <17bdbcb0-d986-be10-a60b-959c105c4374@linux.vnet.ibm.com>
References: <1513704438-28958-1-git-send-email-clombard@linux.vnet.ibm.com>
 <871sjpap1e.fsf@vajain21.in.ibm.com>
 <9070c615-209d-d12f-7c40-f4c2a01c50a2@linux.vnet.ibm.com>
 <87y3lx9489.fsf@vajain21.in.ibm.com>
 <17bdbcb0-d986-be10-a60b-959c105c4374@linux.vnet.ibm.com>
Date: Wed, 20 Dec 2017 19:13:16 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87wp1hbjm3.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

christophe lombard <clombard@linux.vnet.ibm.com> writes:

> Le 20/12/2017 =C3=A0 09:46, Vaibhav Jain a =C3=A9crit=C2=A0:
>>> In fact, it does not matter. I don't know what the userspace could do
>>> with this value.
>> Without libcxl knowing the tidr value, it cannot enforce the condition
>> that only threads that have called attach can issue 'wait' on the right
>> context.
>>=20
>> Also AFU can selectively ask PSL to issue asb_notify to a specific
>> thread via the PSL interface. Without userspace knowing the tidr value
>> it might not be easy for it to give this value to AFU through a Problem
>> State Area register.
>>=20
>
> Don't forget that The ASB_Notify will use LPID:PID:TID tuple found
> in the Process Element Entry.
> The AFU may optionally provide a TID on AxH_CEA[40:55] (AxH_CEA[39]
> must be set to indicate an AFU provided TID)
> If AxH_CEA[39] =3D=3D 1=E2=80=99b0 then Process Element information
> (LPID:PID:TID) is used to generate the PCIe address.
> If AxH_CEA[39] =3D=3D 1=E2=80=99b1then the LPID:PID are taken from the PEE
> while the TID is taken from AxH_-CEA[40:55]

Agree and that was the point I was trying to make when I said that AFU
can selectivly issue asb_notify to a thread. Without userspace threads
knowing their tidr libcxl would let any thread issue the 'wait'
instruction that may cause unpredictable results.

--=20
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
