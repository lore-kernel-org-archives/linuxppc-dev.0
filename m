Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrj9R23CMzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 17:22:34 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5J7JRVZ087367
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 03:22:32 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b5uhb9y2y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 03:22:32 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 19 Jun 2017 17:22:25 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5J7MLcX6291878
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 17:22:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5J7MDEd022460
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 17:22:13 +1000
Subject: Re: [PATCH] powerpc/mm/hash: Free the subpage_prot_table correctly
To: Ram Pai <linuxram@us.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <1497709855-25788-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170617160019.GB5845@ram.oc3035372033.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 12:52:14 +0530
MIME-Version: 1.0
In-Reply-To: <20170617160019.GB5845@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <c73262b8-7be5-6816-c743-9cad10c045da@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:30 PM, Ram Pai wrote:
> 
> This fix, resolved the OOM seen while running subpage_prot selftest, in a
> infinite loop.

The OOM is caused because of memory leaks by wrong freeing
of the subpage_prot_table previously ?
