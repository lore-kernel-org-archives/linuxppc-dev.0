Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B00051A1D5C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:08:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 14 Aug 2015 15:08:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 525B93578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:08:28 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E58ELI50135150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:08:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E57tHj009826
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:07:55 +1000
Date: Fri, 14 Aug 2015 15:07:28 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] book3s_hv_rmhandlers:Pass the correct trap argument to
 kvmhv_commence_exit
Message-ID: <20150814050728.GB13544@tungsten.ozlabs.ibm.com>
References: <1432196824-21791-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432196824-21791-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 21, 2015 at 01:57:04PM +0530, Gautham R. Shenoy wrote:
> In guest_exit_cont we call kvmhv_commence_exit which expects the trap
> number as the argument. However r3 doesn't contain the trap number at
> this point and as a result we would be calling the function with a
> spurious trap number.
> 
> Fix this by copying r12 into r3 before calling kvmhv_commence_exit as
> r12 contains the trap number
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Hi Gautham,

I agree with your logic: r3 is quite clearly corrupted in that path. So:

Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Just one comment: Do you have a case of this causing some visible problem due
to the corrupted trap number? (I'll test the patch if you do.)

Cheers,
Sam.
