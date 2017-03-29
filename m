Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vt7lC4BjtzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 11:23:03 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2T0IjF7109010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 20:23:00 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29fsref8ps-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 20:22:59 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 29 Mar 2017 10:22:57 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2T0MkXW50528286
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 11:22:54 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2T0MLxm008712
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 11:22:21 +1100
Subject: Re: [PATCH V3 2/7] cxl: Remove unused values in bare-metal
 environment.
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 29 Mar 2017 11:21:55 +1100
MIME-Version: 1.0
In-Reply-To: <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5ce2cdd1-7e56-998b-f1fa-2c50fd543d6c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/03/17 02:14, Christophe Lombard wrote:
> The two fields pid and tid of the structure cxl_irq_info are only used
> in the guest environment. To avoid confusion, it's not necessary
> to fill the fields in the bare-metal environment. These two fields
> are renamed to 'reserved' to avoid undefined behavior on bare-metal.
> The PSL Process and Thread Identification Register (CXL_PSL_PID_TID_An)
> is only used when attaching a dedicated process for PSL8 only. This
> register goes away in CAIA2.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>  drivers/misc/cxl/cxl.h    | 13 +++++++------
>  drivers/misc/cxl/hcalls.c |  4 ++--
>  drivers/misc/cxl/native.c |  5 -----
>  3 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 79e60ec..2bbe077 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -895,19 +895,20 @@ int __detach_context(struct cxl_context *ctx);
>   * plpar_hcall9() in hvCall.S
>   * As a consequence:
>   * - we don't need to do any endianness conversion
> - * - the pid and tid are an exception. They are 32-bit values returned in
> - *   the same 64-bit register. So we do need to worry about byte ordering.
> + * - the pid (reserved0) and tid (reserved1) are an exception. They are
> + *   32-bit values returned in the same 64-bit register. So we do need
> + *   to worry about byte ordering.
>   */

Comment should explain that pid/tid are now reserved0/1 because we've 
decided not to use them at all.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
