Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1P0K6M0vzDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:45:05 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q1iw1A091244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:45:03 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7abcgk0p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:45:02 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 26 Sep 2017 11:45:00 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8Q1iv1w13172784
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:44:57 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8Q1ix1A032459
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:45:00 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH V2] cxl: Fix memory page not handled
In-Reply-To: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Tue, 26 Sep 2017 07:14:52 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv5imdwr.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christophe,

A minor nitpick

Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

> +	for (dar = (addr & ~(page_size - 1)); dar < (addr + size); dar += page_size) {
> +		if (dar < vma->vm_start || dar > vma->vm_end) {
Code comment in mm_types.h for vm_end says it "The first byte after our
end address within vm_mm". So this condition should be
(dar < vma->vm_start || dar >= vma->vm_end)

~ Vaibhav
