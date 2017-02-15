Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNKgH5bPtzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 11:20:11 +1100 (AEDT)
Date: Tue, 14 Feb 2017 16:20:08 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <michaele@au1.ibm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Rik van Riel
 <riel@surriel.com>, Mel Gorman <mgorman@techsingularity.net>,
 paulus@ozlabs.org, benh@kernel.crashing.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mm/autonuma: Let architecture override how the
 write bit should be stashed in a protnone pte.
Message-Id: <20170214162008.bd592c747fc5e167c10ce7b8@linux-foundation.org>
In-Reply-To: <874lzxm41g.fsf@concordia.ellerman.id.au>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87poilmien.fsf@concordia.ellerman.id.au>
 <abd9d231-c380-95b0-0722-8df7be626968@linux.vnet.ibm.com>
 <874lzxm41g.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Feb 2017 21:59:23 +1100 Michael Ellerman <michaele@au1.ibm.com> wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > On Tuesday 14 February 2017 11:19 AM, Michael Ellerman wrote:
> >> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> >>
> >>> Autonuma preserves the write permission across numa fault to avoid taking
> >>> a writefault after a numa fault (Commit: b191f9b106ea " mm: numa: preserve PTE
> >>> write permissions across a NUMA hinting fault"). Architecture can implement
> >>> protnone in different ways and some may choose to implement that by clearing Read/
> >>> Write/Exec bit of pte. Setting the write bit on such pte can result in wrong
> >>> behaviour. Fix this up by allowing arch to override how to save the write bit
> >>> on a protnone pte.
> >> This is pretty obviously a nop on arches that don't implement the new
> >> hooks, but it'd still be good to get an ack from someone in mm land
> >> before I merge it.
> >
> >
> > To get it apply cleanly you may need
> > http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes.patch
> > http://ozlabs.org/~akpm/mmots/broken-out/mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes-fix.patch
> 
> Ah OK, I missed those.
> 
> In that case these two should probably go via Andrew's tree.

Done.  But
mm-autonuma-dont-use-set_pte_at-when-updating-protnone-ptes.patch is on
hold because Aneesh saw a testing issue, so these two are also on hold.
