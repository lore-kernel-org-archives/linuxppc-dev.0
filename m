Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E2B11A0BBD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 13:25:56 +1000 (AEST)
In-Reply-To: <1435652431-22024-5-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [4/5] powerpc/perf: Change name & type of 'pred' in
 power_pmu_bhrb_read
Message-Id: <20150729032555.CE6CB140E41@ozlabs.org>
Date: Wed, 29 Jul 2015 13:25:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-30-06 at 08:20:30 UTC, Anshuman Khandual wrote:
> Branch record attributes 'mispred' and 'predicted' are single bit
> fields as defined in the perf ABI. Hence the data type of the field
> 'pred' used during BHRB processing should be changed from integer
> to bool. This patch also changes the name of the variable from 'pred'
> to 'mispred' making the logical inversion process more meaningful
> and readable.

This whole function is a mess.

There's no good reason why we're doing the assignment to pred/mispred in two
places to begin with, so if that was eliminated we wouldn't need a local for
mispred to begin with.

Then there's the type juggling, all of which probably works but is fishy and
horrible.

You take a u64, bitwise and it with a mask, assign that to a boolean, then take
the boolean, *bitwise* negate that and assign the result to a single bit
bitfield.

> +	bool mispred;
> +			mispred = val & BHRB_PREDICTION;
> +				cpuhw->bhrb_entries[u_index].predicted = ~mispred;


cheers
