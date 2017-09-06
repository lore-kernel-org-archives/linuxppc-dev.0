Return-Path: <srs0=mryy=ah=au1.ibm.com=benh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnf8P4ssNzDrVk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 08:56:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xnf8P4L16z8w2j
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 08:56:21 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xnf8P1LY0z9t2R
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2017 08:56:20 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v86MrfYM135865
 for <linuxppc-dev@ozlabs.org>; Wed, 6 Sep 2017 18:56:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ctsxdrtj1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Sep 2017 18:56:18 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 7 Sep 2017 08:56:16 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v86MuE0n41091218
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2017 08:56:14 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v86Mu5cV002972
 for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2017 08:56:05 +1000
Subject: Re: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Balbir Singh <bsingharora@gmail.com>, npiggin@gmail.com,
 mahesh@linux.vnet.ibm.com, alistair@popple.id.au
Cc: linuxppc-dev@ozlabs.org
Date: Thu, 07 Sep 2017 08:56:12 +1000
In-Reply-To: <20170905041555.27696-3-bsingharora@gmail.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
 <20170905041555.27696-3-bsingharora@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1504738572.2371.3.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-09-05 at 14:15 +1000, Balbir Singh wrote:
>  void save_mce_event(struct pt_regs *regs, long handled,
>                     struct mce_error_info *mce_err,
> -                   uint64_t nip, uint64_t addr)
> +                   uint64_t nip, uint64_t addr, uint64_t phys_addr)
>  {
>         int index = __this_cpu_inc_return(mce_nest_count) - 1;
>         struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
> @@ -140,6 +140,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
>         } else if (mce->error_type == MCE_ERROR_TYPE_UE) {
>                 mce->u.ue_error.effective_address_provided = true;
>                 mce->u.ue_error.effective_address = addr;
> +               if (phys_addr != ULONG_MAX) {
> +                       mce->u.ue_error.physical_address_provided = true;
> +                       mce->u.ue_error.physical_address = phys_addr;
> +               }
>         }
>         return;

Where is "addr" coming from ? Keep in mind that on P9 at least, a UE
will *not* give you an EA in DAR in most cases.

Ben.
