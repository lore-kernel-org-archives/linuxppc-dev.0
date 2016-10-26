Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t3n150QXrzDt0N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 21:52:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 4/5] mm: make processing of movable_node arch-specific
In-Reply-To: <20161026004929.h6v54dhehk4yvmwm@arbab-vm>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
 <235f2d20-cf84-08df-1fb4-08ee258fdc52@gmail.com>
 <dcfc8ace-e59e-6b4b-0f2f-4eff9f08f3c1@gmail.com>
 <20161025155507.37kv5akdlgo6m2be@arbab-laptop.austin.ibm.com>
 <112504e9-561d-e0da-7a40-73996c678b56@gmail.com>
 <20161026004929.h6v54dhehk4yvmwm@arbab-vm>
Date: Wed, 26 Oct 2016 21:52:53 +1100
Message-ID: <87vawfwfei.fsf@concordia.ellerman.id.au>
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

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> On Wed, Oct 26, 2016 at 09:34:18AM +1100, Balbir Singh wrote:
>>I still believe we need your changes, I was wondering if we've tested
>>it against normal memory nodes and checked if any memblock
>>allocations end up there. Michael showed me some memblock
>>allocations on node 1 of a two node machine with movable_node
>
> The movable_node option is x86-only. Both of those nodes contain normal 
> memory, so allocations on both are allowed.
>
>>> Longer; if you use "movable_node", x86 can identify these nodes at 
>>> boot. They call memblock_mark_hotplug() while parsing the SRAT. Then, 
>>> when the zones are initialized, those markings are used to determine 
>>> ZONE_MOVABLE.
>>>
>>> We have no analog of this SRAT information, so our movable nodes can 
>>> only be created post boot, by hotplugging and explicitly onlining 
>>> with online_movable.
>>
>>Is this true for all of system memory as well or only for nodes
>>hotplugged later?
>
> As far as I know, power has nothing like the SRAT that tells us, at 
> boot, which memory is hotpluggable.

On pseries we have the ibm,dynamic-memory device tree property, which
can contain ranges of memory that are not yet "assigned to the
partition" - ie. can be hotplugged later.

So in general that statement is not true.

But I think you're focused on bare-metal, in which case you might be
right. But that doesn't mean we couldn't have a similar property, if
skiboot/hostboot knew what the ranges of memory were going to be.

cheers
