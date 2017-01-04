Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tv3kY3mZKzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 08:25:25 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04LDb4N035426
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 16:25:22 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27s259930j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 16:25:22 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 14:25:22 -0700
Date: Wed, 4 Jan 2017 15:25:15 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v4 1/4] powerpc/mm: refactor radix physical page mapping
References: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1483476218-17271-2-git-send-email-arbab@linux.vnet.ibm.com>
 <878tqr76w6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <878tqr76w6.fsf@linux.vnet.ibm.com>
Message-Id: <20170104212515.7dibsrkqf7fuf63x@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 10:34:25AM +0530, Aneesh Kumar K.V wrote:
>We lost the below in the change.
>
>		pr_info("Mapping range 0x%lx - 0x%lx with 0x%lx\n",
>			(unsigned long)base, (unsigned long)end,
>			linear_page_size);
>
>
>Is there a way to dump the range and the size with which we mapped that
>range ?

Sure. It's a little more difficult than before, because the mapping size 
is now reselected in each iteration of the loop, but a similar print can 
be done.

-- 
Reza Arbab
