Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2XSm4WgGzDvPr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 21:24:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <apopple@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tang Chen <tangchen@cn.fujitsu.com>,
 linux-mm@kvack.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/5] drivers/of: do not add memory for unavailable nodes
In-Reply-To: <2344394.NlaWgtFOqB@new-mexico>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-3-git-send-email-arbab@linux.vnet.ibm.com>
 <2344394.NlaWgtFOqB@new-mexico>
Date: Mon, 24 Oct 2016 21:24:04 +1100
Message-ID: <87vawixcxn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alistair Popple <apopple@au1.ibm.com> writes:

> Hi Reza,
>
> On Thu, 6 Oct 2016 01:36:32 PM Reza Arbab wrote:
>> Respect the standard dt "status" property when scanning memory nodes in
>> early_init_dt_scan_memory(), so that if the node is unavailable, no
>> memory will be added.
>
> What happens if a kernel without this patch is booted on a system with some 
> status="disabled" device-nodes? Do older kernels just ignore this memory or do 
> they try to use it?
>
> From what I can tell it seems that kernels without this patch will try and use 
> this memory even if it is marked in the device-tree as status="disabled" which 
> could lead to problems for older kernels when we start exporting this property 
> from firmware.

The code already looks for "linux,usable-memory" in preference to "reg".
Can you use that instead?

That would have the advantage that existing kernels already understand
it.

Another problem with using "status" is we could have device trees out
there that have status = disabled and we don't know about it, and by
changing the kernel to use that property we break people's systems.
Though for memory nodes my guess is that's not true, but you never know ...

cheers
