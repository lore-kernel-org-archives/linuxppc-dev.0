Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrzBn0pLczDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 03:54:40 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JHrlRw109038
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 13:54:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b64sdsja5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 13:54:37 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 19 Jun 2017 11:54:36 -0600
Date: Mon, 19 Jun 2017 10:54:21 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Free the subpage_prot_table correctlyy
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497709855-25788-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170617160019.GB5845@ram.oc3035372033.ibm.com>
 <c73262b8-7be5-6816-c743-9cad10c045da@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c73262b8-7be5-6816-c743-9cad10c045da@linux.vnet.ibm.com>
Message-Id: <20170619175421.GC5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2017 at 12:52:14PM +0530, Anshuman Khandual wrote:
> On 06/17/2017 09:30 PM, Ram Pai wrote:
> > 
> > This fix, resolved the OOM seen while running subpage_prot selftest, in a
> > infinite loop.
> 
> The OOM is caused because of memory leaks by wrong freeing
> of the subpage_prot_table previously ?

No. Rather, not freeing up of the memory allocated previously
and tracked through the subpage_prot_table.

RP
