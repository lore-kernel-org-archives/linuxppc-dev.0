Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB0E51A05F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:11:53 +1100 (AEDT)
Date: Mon, 23 Mar 2015 21:11:38 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
Message-ID: <20150324011138.GD21966@oracle.com>
References: <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
 <20150323.150508.149509757161802782.davem@davemloft.net>
 <1427149265.4770.238.camel@kernel.crashing.org>
 <20150323230811.GA21966@oracle.com>
 <1427158048.4770.295.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427158048.4770.295.camel@kernel.crashing.org>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (03/24/15 11:47), Benjamin Herrenschmidt wrote:
> 
> Yes, pass a function pointer argument that can be NULL or just make it a
> member of the iommu_allocator struct (or whatever you call it) passed to
> the init function and that can be NULL. My point is we don't need a
> separate "ops" structure.

Ok, I'll make this a function pointer to the iommu_tbl_pool_init()
function (tomorrow)

fwiw, the ops struct came out as a result of DaveM input, 
  http://www.spinics.net/lists/sparclinux/msg13232.html
albeit the original context is now moot.

> Pass it to init and stash it in the table but don't call it
> "iommu_table", let's use a name that conveys better the fact that this
> is purely a DMA space allocator (to be embedded by the arch specific
> iommu table). Something like iommu_alloc_zone or whatever you want to
> call it. I keep finding new names whenever I think of it :-)

please pick a name that you like as this mooshes all the patches,
and I myself really dont care what it gets called (rose? :-)) as long 
as fat-fingering-risk is minimized

Regarding the relationship with largepool,

> But that might not be necessary. If indeed we very rarely use the large
> pool, then just make it flush always. My feeling is that it will only
> ever be used at driver init/remove time when allocating things like
> descriptor rings, where the flush overhead dont' matter.

ok, will factor this in tomorrow (assuming DaveM has no objections
to anything proposed here, esp around the function pointer for flushall).

--Sowmini
