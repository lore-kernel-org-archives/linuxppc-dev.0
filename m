Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjhCl0g1szDrRs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 10:14:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8R0Cqt5090080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:14:24 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25q592q7qs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 20:14:24 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 26 Sep 2016 20:14:23 -0400
Date: Mon, 26 Sep 2016 19:14:14 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 4/5] powerpc/mm: restore top-down allocation when
 using movable_node
References: <1474828616-16608-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1474828616-16608-5-git-send-email-arbab@linux.vnet.ibm.com>
 <1474924351.2857.255.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1474924351.2857.255.camel@kernel.crashing.org>
Message-Id: <20160927001413.o72fqpfsnsxpu5qq@arbab-laptop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 27, 2016 at 07:12:31AM +1000, Benjamin Herrenschmidt wrote:
>In any case, if the memory hasn't been hotplug, this shouldn't be 
>necessary as we shouldn't be considering it for allocation.

Right. To be clear, the background info I put in the commit log refers 
to x86, where the SRAT can describe movable nodes which exist at boot.  
They're trying to avoid allocations from those nodes before they've been 
identified.

On power, movable nodes can only exist via hotplug, so that scenario 
can't happen. We can immediately go back to top-down allocation. That is 
the missing call being added in the patch.

-- 
Reza Arbab
