Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424B2n2GmvzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2018 12:42:56 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w842fMi4056217
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 22:42:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m9agscjhc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 22:42:54 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Tue, 4 Sep 2018 03:42:52 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv: Make possible for user to force a
 full ipl cec reboot
In-Reply-To: <39220fff-0db2-f2f4-50ab-1257d27a7133@au1.ibm.com>
References: <20180903102624.24344-1-vaibhav@linux.ibm.com>
 <39220fff-0db2-f2f4-50ab-1257d27a7133@au1.ibm.com>
Date: Tue, 04 Sep 2018 08:12:43 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87musym198.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing this patch Andrew,

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> The logic here is a bit hard to follow, relying on if (cmd && strcmp...) 
> failing then setting rc = OPAL_UNSUPPORTED in order to handle the normal 
> case seems a bit backwards.
Agree. With this change I am trying to make adding new reboot types in
future simpler, without resorting to major refactoring of the
function. opal_cec_reboot() should be a fallback for any failures in
doing a typed reboot. So adding a new foobar reboot type just needs
adding a new branch in the if-else ladder.

if (cmd && strcmp(cmd, "full") == 0)
    rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
else if(cmd && strcmd(cmd, "foobar") == 0)
    rc = /* new code here */
else
    rc = OPAL_UNSUPPORTED;

> I think I would slightly prefer it if the !cmd case were handled first 
> to make it clear that opal_cec_reboot() is the normal case.
Fair suggestion. But then I will still have to handle the errors just
after the if-else ladder is finished to determine if I need to fallback.

> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Thanks

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
