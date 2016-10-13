Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svb8M0yMczDsxp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:00:50 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9D2xJri046551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 23:00:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 261wvxgh7m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 23:00:47 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 13 Oct 2016 13:00:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 892A02CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:00:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9D30fvV64094462
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:00:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9D30eLQ002136
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:00:41 +1100
Subject: Re: [PATCH v2] cxl: Prevent adapter reset if an active context exists
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
References: <1476245834-1864-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 13 Oct 2016 14:00:40 +1100
MIME-Version: 1.0
In-Reply-To: <1476245834-1864-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <bc9f5510-27eb-4638-7dd7-ac02ab41ee0c@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/10/16 15:17, Vaibhav Jain wrote:
> This patch prevents resetting the cxl adapter via sysfs in presence of
> one or more active cxl_context on it. This protects against an
> unrecoverable error caused by PSL owning a dirty cache line even after
> reset and host tries to touch the same cache line. In case a force reset
> of the card is required irrespective of any active contexts, the int
> value -1 can be stored in the 'reset' sysfs attribute of the card.
>
> The patch introduces a new atomic_t member named contexts_num inside
> struct cxl that holds the number of active context attached to the card
> , which is checked against '0' before proceeding with the reset. To
> prevent against a race condition where a context is activated just after
> reset check is performed, the contexts_num is atomically set to '-1'
> after reset-check to indicate that no more contexts can be activated on
> the card anymore.
>
> Before activating a context we atomically test if contexts_num is
> non-negative and if so, increment its value by one. In case the value of
> contexts_num is negative then it indicates that the card is about to be
> reset and context activation is error-ed out at that point.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

All the changes look good to me.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 4ba0a2a..dae2b38 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -220,8 +220,11 @@ What:           /sys/class/cxl/<card>/reset
>  Date:           October 2014
>  Contact:        linuxppc-dev@lists.ozlabs.org
>  Description:    write only
> -                Writing 1 will issue a PERST to card which may cause the card
> -                to reload the FPGA depending on load_image_on_perst.
> +                Writing 1 will issue a PERST to card provided there are no
> +		contexts active on any one of the card AFUs. This may cause
> +		the card to reload the FPGA depending on load_image_on_perst.
> +		Writing -1 will do a force PERST irrespective of any active
> +		contexts on the card AFUs.

Ugh, spaces vs tabs bites again :(

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
