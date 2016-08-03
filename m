Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s49vb3tHfzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 21:34:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vlastimil Babka <vbabka@suse.cz>, Balbir Singh <bsingharora@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux--foundation.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] fadump: Disable deferred page struct initialisation
In-Reply-To: <acefe941-2c2a-d7d2-0720-4cfbee404a16@suse.cz>
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470143947-24443-3-git-send-email-srikar@linux.vnet.ibm.com>
 <1470201642.5034.3.camel@gmail.com>
 <acefe941-2c2a-d7d2-0720-4cfbee404a16@suse.cz>
Date: Wed, 03 Aug 2016 21:34:11 +1000
Message-ID: <87twf2ulvw.fsf@concordia.ellerman.id.au>
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

Vlastimil Babka <vbabka@suse.cz> writes:

> On 08/03/2016 07:20 AM, Balbir Singh wrote:
>> On Tue, 2016-08-02 at 18:49 +0530, Srikar Dronamraju wrote:
>>> Fadump kernel reserves significant number of memory blocks. On a multi-node
>>> machine, with CONFIG_DEFFERRED_STRUCT_PAGE support, fadump kernel fails to
>>> boot. Fix this by disabling deferred page struct initialisation.
>>>
>>
>> How much memory does a fadump kernel need? Can we bump up the limits depending
>> on the config. I presume when you say fadump kernel you mean kernel with
>> FADUMP in the config?
>>
>> BTW, I would much rather prefer a config based solution that does not select
>> DEFERRED_INIT if FADUMP is enabled.
>
> IIRC the kdump/fadump kernel is typically the same vmlinux as the main 
> kernel, just with special initrd and boot params. So if you want 
> deferred init for the main kernel, this would be impractical.

Yes. Distros won't build a separate kernel, so it has to work at runtime.

cheers
