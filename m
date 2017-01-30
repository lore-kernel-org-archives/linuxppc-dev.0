Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBxDr0bDHzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 04:28:11 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UHJ0Uq036938
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 12:28:09 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28a6t0huq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 12:28:08 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 30 Jan 2017 12:28:07 -0500
Date: Mon, 30 Jan 2017 11:28:03 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
 <87o9ypvt6t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
In-Reply-To: <87o9ypvt6t.fsf@concordia.ellerman.id.au>
Message-Id: <20170130172802.qvv2wqksxn7bq2sr@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 30, 2017 at 07:38:18PM +1100, Michael Ellerman wrote:
>Doesn't build.
>
>In file included from ../include/linux/kernel.h:13:0,
>                 from ../include/linux/sched.h:17,
>                 from ../arch/powerpc/mm/pgtable-radix.c:11:
>../arch/powerpc/mm/pgtable-radix.c: In function ‘create_physical_mapping’:
>../include/linux/printk.h:299:2: error: ‘mapping_size’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>  ^~~~~~
>../arch/powerpc/mm/pgtable-radix.c:123:22: note: ‘mapping_size’ was declared here
>  unsigned long addr, mapping_size;

Doh. Could you please do the following for now?

-	unsigned long addr, mapping_size;
+	unsigned long addr, mapping_size = 0;

I'd like to delay spinning v6 with this until I see any input you might 
have on the rest of the set.

And for future reference, how are you ending up with 
-Werror=maybe-uninitialized? On powerpc/next, with pseries_le_defconfig, 
I get -Wno-maybe-uninitialized.

-- 
Reza Arbab
