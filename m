Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3HmR3wr5zDvmf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 02:55:19 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9PFs4ki123582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 11:55:17 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26a8hcjw55-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 11:55:16 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 09:55:15 -0600
Date: Tue, 25 Oct 2016 10:55:07 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 4/5] mm: make processing of movable_node arch-specific
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
 <235f2d20-cf84-08df-1fb4-08ee258fdc52@gmail.com>
 <dcfc8ace-e59e-6b4b-0f2f-4eff9f08f3c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <dcfc8ace-e59e-6b4b-0f2f-4eff9f08f3c1@gmail.com>
Message-Id: <20161025155507.37kv5akdlgo6m2be@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 25, 2016 at 11:15:40PM +1100, Balbir Singh wrote:
>After the ack, I realized there were some more checks needed, IOW
>questions for you :)

Hey! No takebacks!

The short answer is that neither of these is a concern.

Longer; if you use "movable_node", x86 can identify these nodes at boot. 
They call memblock_mark_hotplug() while parsing the SRAT. Then, when the 
zones are initialized, those markings are used to determine ZONE_MOVABLE.

We have no analog of this SRAT information, so our movable nodes can 
only be created post boot, by hotplugging and explicitly onlining with 
online_movable.

>1. Have you checked to see if our memblock allocations spill
>over to probably hotpluggable nodes?

Since our nodes don't exist at boot, we don't have that short window 
before the zones are drawn where the node has normal memory, and a 
kernel allocation might occur within.

>2. Shouldn't we be marking nodes discovered as movable via
>memblock_mark_hotplug()?

Again, this early boot marking mechanism only applies to movable_node.

-- 
Reza Arbab
