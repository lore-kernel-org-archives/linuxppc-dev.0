Return-Path: <vbabka@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s42fP3lR7zDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 16:07:24 +1000 (AEST)
Subject: Re: [PATCH 2/2] fadump: Disable deferred page struct initialisation
To: Balbir Singh <bsingharora@gmail.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-mm@kvack.org,
 Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux--foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1470143947-24443-3-git-send-email-srikar@linux.vnet.ibm.com>
 <1470201642.5034.3.camel@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <acefe941-2c2a-d7d2-0720-4cfbee404a16@suse.cz>
Date: Wed, 3 Aug 2016 08:07:19 +0200
MIME-Version: 1.0
In-Reply-To: <1470201642.5034.3.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2016 07:20 AM, Balbir Singh wrote:
> On Tue, 2016-08-02 at 18:49 +0530, Srikar Dronamraju wrote:
>> Fadump kernel reserves significant number of memory blocks. On a multi-node
>> machine, with CONFIG_DEFFERRED_STRUCT_PAGE support, fadump kernel fails to
>> boot. Fix this by disabling deferred page struct initialisation.
>>
>
> How much memory does a fadump kernel need? Can we bump up the limits depending
> on the config. I presume when you say fadump kernel you mean kernel with
> FADUMP in the config?
>
> BTW, I would much rather prefer a config based solution that does not select
> DEFERRED_INIT if FADUMP is enabled.

IIRC the kdump/fadump kernel is typically the same vmlinux as the main 
kernel, just with special initrd and boot params. So if you want 
deferred init for the main kernel, this would be impractical.

> Balbir
>
