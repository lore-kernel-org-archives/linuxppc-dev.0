Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdlm15HbbzDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 18:39:45 +1000 (AEST)
Date: Mon, 4 Apr 2016 09:39:39 +0100
From: Mel Gorman <mgorman@suse.de>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, zhlcindy@linux.vnet.ibm.com
Subject: Re: [RFC] mm: Fix memory corruption caused by deferred page
 initialization
Message-ID: <20160404083939.GC21128@suse.de>
References: <1458921929-15264-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3qXFh60DRNz9sDH@ozlabs.org> <20160326133708.GA382@gwshan>
 <20160327134827.GA24644@gwshan> <20160331022734.GA12552@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20160331022734.GA12552@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 31, 2016 at 01:27:34PM +1100, Gavin Shan wrote:
> >So the issue is only existing when CONFIG_NO_BOOTMEM=n. The alternative fix would
> >be similar to what we have on !CONFIG_NO_BOOTMEM: In early stage, all page structs
> >for bootmem reserved pages are initialized and mark them with PG_reserved. I'm
> >not sure it's worthy to fix it as we won't support bootmem as Michael mentioned.
> >
> 
> Mel, could you please confirm if we need a fix on !CONFIG_NO_BOOTMEM? If we need,
> I'll respin and send a patch for review.
> 

Given that CONFIG_NO_BOOTMEM is not supported and bootmem is meant to be
slowly retiring, I would suggest instead making deferred memory init
depend on NO_BOOTMEM. 

-- 
Mel Gorman
SUSE Labs
