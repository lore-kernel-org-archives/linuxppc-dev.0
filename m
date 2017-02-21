Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSZrb21cPzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:27:58 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LMNYDT059689
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:27:56 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rv2rwffg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:27:56 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 08:27:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 65D4F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:27:51 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LMRhS546465174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:27:51 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LMRIjE015151
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:27:19 +1100
Date: Wed, 22 Feb 2017 09:26:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv: Fix it_ops::get() callback to
 return in cpu endian
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170221023854.47493-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221023854.47493-1-aik@ozlabs.ru>
Message-Id: <20170221222654.GA5151@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 01:38:54PM +1100, Alexey Kardashevskiy wrote:
>The iommu_table_ops callbacks are declared CPU endian as they take and
>return "unsigned long"; underlying hardware tables are big-endian.
>
>However get() was missing be64_to_cpu(), this adds the missing conversion.
>
>The only caller of this is crash dump at arch/powerpc/kernel/iommu.c,
>iommu_table_clear() which only compares TCE to zero so this change
>should not cause behavioral change.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
