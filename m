Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJBq259STzDvXv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 02:57:18 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAFFsMrt042580
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:57:15 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26r2cghyk5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 10:57:15 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 15 Nov 2016 08:57:14 -0700
Date: Tue, 15 Nov 2016 09:57:07 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, devicetree@vger.kernel.org,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] mm: remove x86-only restriction of movable_node
References: <1479160961-25840-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1479160961-25840-3-git-send-email-arbab@linux.vnet.ibm.com>
 <87lgwlb4u1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87lgwlb4u1.fsf@linux.vnet.ibm.com>
Message-Id: <20161115155706.zft7iaw2fjtwu7yp@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 15, 2016 at 12:35:42PM +0530, Aneesh Kumar K.V wrote:
>Considering that we now can mark memblock hotpluggable, do we need to
>enable the bottom up allocation for ppc64 also ?

No, we don't, because early_init_dt_scan_memory() marks the memblocks 
hotpluggable immediately when they are added. There is no gap between 
the addition and the marking, as there is on x86, during which an 
allocation might accidentally occur in a movable node.

-- 
Reza Arbab
