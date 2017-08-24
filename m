Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdFm44c7QzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:09:40 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O78jek123227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:09:38 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2chrudwnqt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:09:38 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 17:09:35 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7O79XrT31916272
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:09:33 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7O79Xp4015922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:09:33 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Add support for POWER9 DD2
In-Reply-To: <1503500286-1684-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1503500286-1684-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 12:39:28 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87378hv3vb.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
> +	/* For debugging with trace arrays */
> +	/* Configure RX trace 0 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000000ULL);
> +	/* Configure RX trace 1 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xAA00000000000001ULL);
> +	/* Configure CT trace 0 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xA2B8000000000003ULL);
> +	/* Configure LA0 trace 0 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x83FFC00000000005ULL);
> +	/* Configure JM0 trace 0 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000007ULL);
> +	/* Configure DMA trace 0 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000008ULL);
> +	/* Configure DMA trace 1 segmented mode */
> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000009ULL);
Please wrap this block that configures the trace arrays in #ifdef
DEBUG. Or it will be better if we remove it from here as the register is
already accessible via debugfs.

---
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
