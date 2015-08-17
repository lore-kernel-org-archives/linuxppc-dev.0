Return-Path: <ego@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1E601A2E9E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 15:53:58 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Sun, 16 Aug 2015 23:53:56 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5951AC90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 01:44:58 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7H5rrcX53870730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 05:53:53 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7H5rqKI015258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 01:53:53 -0400
Date: Mon, 17 Aug 2015 11:23:45 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] book3s_hv_rmhandlers:Pass the correct trap argument to
 kvmhv_commence_exit
Message-ID: <20150817055345.GA13304@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1432196824-21791-1-git-send-email-ego@linux.vnet.ibm.com>
 <20150814050728.GB13544@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150814050728.GB13544@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sam,

On Fri, Aug 14, 2015 at 03:07:28PM +1000, Sam Bobroff wrote:
> On Thu, May 21, 2015 at 01:57:04PM +0530, Gautham R. Shenoy wrote:
> > In guest_exit_cont we call kvmhv_commence_exit which expects the trap
> > number as the argument. However r3 doesn't contain the trap number at
> > this point and as a result we would be calling the function with a
> > spurious trap number.
> > 
> > Fix this by copying r12 into r3 before calling kvmhv_commence_exit as
> > r12 contains the trap number
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> 
> Hi Gautham,
> 
> I agree with your logic: r3 is quite clearly corrupted in that path. So:
> 
> Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> 
> Just one comment: Do you have a case of this causing some visible problem due
> to the corrupted trap number? (I'll test the patch if you do.)
> 

Actually no! I found this bug while reviewing the code for some other issue.

> Cheers,
> Sam.

--
Thanks and Regards
gautham.
