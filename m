Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F096F1A061B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 11:17:48 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B5B7914007D
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2014 11:17:48 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 28 Oct 2014 10:17:46 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: CXL: Fix PSL error due to duplicate segment table entries
In-reply-to: <20141027064100.D12B514007D@ozlabs.org>
References: <20141027064100.D12B514007D@ozlabs.org>
Date: Tue, 28 Oct 2014 11:17:47 +1100
Message-Id: <1414455360-sup-2142@delenn.ozlabs.ibm.com>
Cc: cbe-oss-dev <cbe-oss-dev@lists.ozlabs.org>, mikey <mikey@neuling.org>,
 arnd <arnd@arndb.de>, greg <greg@kroah.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, jk <jk@ozlabs.org>,
 anton <anton@samba.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2014-10-27 17:41:00 +1100:
> On Mon, 2014-27-10 at 04:24:35 UTC, Ian Munsie wrote:
> > From: Ian Munsie <imunsie@au1.ibm.com>
> > 
> > In certain circumstances the PSL can send an interrupt for a segment
> 
> Define PSL before using it please.

ok

> > The CXL driver did not expect this situation and did not check if a
> 
> does not and does not, you haven't patched it yet.

ok

> > Some of the code has been refactored to simplify it - the segment table
> > hash has been moved from cxl_load_segment to find_free_sste where it is
> 
> Any reason that's not a separate patch?

ok, I'll split it.

> > used and we have disabled the secondary hash in the segment table to
> > reduce the number of entries that need to be tested from 16 to 8. Due to
> > the large segment sizes we use it is extremely unlikely that the
> > secondary hash would ever have been used in practice, so this should not
> > have any negative impacts and may even improve performance.
> 
> Any reason that's not a separate patch?

ok, I'll split it.

> > copro_calculate_slb will now mask the ESID by the correct mask for 1T vs
> 
> Didn't, but will after this patch?

ok, will reword

> > 256M segments. This has no effect by itself as the extra bits were
> > ignored, but it makes debugging the segment table entries easier and
> > means that we can directly compare the ESID values for duplicates
> > without needing to worry about masking in the comparison.
> 
> Separate patch?

ok, I'll split it.

Cheers,
-Ian
