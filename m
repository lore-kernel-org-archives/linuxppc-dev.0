Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 627251A013E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 07:55:20 +1000 (EST)
Message-ID: <1406066112.22200.28.camel@pasglop>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the
 valid bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 23 Jul 2014 07:55:12 +1000
In-Reply-To: <8761iptebe.fsf@linux.vnet.ibm.com>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406006862.22200.7.camel@pasglop> <8761iptebe.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-23 at 00:23 +0530, Aneesh Kumar K.V wrote:
> > A better place for this would be right before the last write to the PMD
> > (that's also clearing BUSY) in __hash_page_thp(). Basically, it's the
> > normal lock ordering that's missing here, nothing specific to
> > mark_hpte_slot_valid() but instead, any state relative to the BUSY bit
> > in the PMD (including the actual hash writes in update_pp etc...)
> >
> 
> IIUC updatepp already have required barriers. ie in updatepp we do tlbie
> which should take care of the ordering right ?

Only if it succeeds but that doesn't matter, I'd rather we get the
semantics right. The clearing of the busy bit is an unlock, it should
have the appropriate barriers like it does in other variants of hash
page.
> 
> Now the reason i moved that spm_wmb() to mark_hpte_slot_valid was to
> pair it with smb_rmb() in get_hpte_slot_array().

Which is also probably in the wrong place. Care to explain to me the
exact relationship ?

Ben.
