Return-Path: <zhong@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t31V523rqzDvjL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 16:11:57 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9P58Vtj060778
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 01:11:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269v7wjcg3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 01:11:54 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 23:11:53 -0600
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [RFC PATCH] powerpc/powernv: recheck lock bit in
 core_idle_lock_held after lwarx
From: Li Zhong <zhong@linux.vnet.ibm.com>
In-Reply-To: <20161025041530.GA17852@fergus.ozlabs.ibm.com>
Date: Tue, 25 Oct 2016 13:09:36 +0800
Cc: shreyas@linux.vnet.ibm.com,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>, ego@linux.vnet.ibm.com
References: <1477365874.10026.7.camel@TP420>
 <20161025041530.GA17852@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Message-Id: <F2740D40-FD37-4CE5-BCCD-391021DECEDA@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> On 25 Oct 2016, at 12:15, Paul Mackerras <paulus@ozlabs.org> wrote:
>=20
> On Tue, Oct 25, 2016 at 11:24:34AM +0800, Li Zhong wrote:
>> The core_idle_lock_held loops when the lock bit is held by others.
>> However, it is possible that after the lock bit is cleared, some one
>> else sees it first and sets the lock bit. And lwarx loads a value =
with
>> lock bit set, and the lock bit may be cleared in the following stwcx.
>> It is possible the first one is still executing in the critical =
section.
>>=20
>> This patch rechecks the lock bit after lwarx, and go back to loop if =
it
>> is set.
>=20
> You're quite correct, in fact I posted almost exactly the same patch a
> few days ago...  See http://patchwork.ozlabs.org/patch/684963/.


Forget to check the list before sending =E2=80=A6=20

One minor difference, maybe we can use bne- for the rechecking :)

Thanks, Zhong

>=20
> Thanks,
> Paul.
>=20
