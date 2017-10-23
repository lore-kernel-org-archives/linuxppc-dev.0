Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLQ9d0TkYzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 05:37:08 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9NIYHsk010086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 14:37:07 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dsku25efw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 14:37:06 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Mon, 23 Oct 2017 12:37:05 -0600
Date: Mon, 23 Oct 2017 11:36:58 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 06/25] powerpc: cleaup AMR,iAMR when a key is allocated
 or freed
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-15-git-send-email-linuxram@us.ibm.com>
 <20171018143414.125b6e0f@firefly.ozlabs.ibm.com>
 <87k1zm8ai6.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k1zm8ai6.fsf@linux.vnet.ibm.com>
Message-Id: <20171023183658.GF5454@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 23, 2017 at 03:13:45PM +0530, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
> > On Fri,  8 Sep 2017 15:44:54 -0700
> > Ram Pai <linuxram@us.ibm.com> wrote:
> >
> >> cleanup the bits corresponding to a key in the AMR, and IAMR
> >> register, when the key is newly allocated/activated or is freed.
> >> We dont want some residual bits cause the hardware enforce
> >> unintended behavior when the key is activated or freed.
> >> 
> >> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
> >>  1 files changed, 12 insertions(+), 0 deletions(-)
> >> 
> >> diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
> >> index 5a83ed7..53bf13b 100644
> >> --- a/arch/powerpc/include/asm/pkeys.h
> >> +++ b/arch/powerpc/include/asm/pkeys.h
> >> @@ -54,6 +54,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
> >>  		mm_set_pkey_is_allocated(mm, pkey));
> >>  }
> >>  
> >> +extern void __arch_activate_pkey(int pkey);
> >> +extern void __arch_deactivate_pkey(int pkey);
> >>  /*
> >>   * Returns a positive, 5-bit key on success, or -1 on failure.
> >>   */
> >> @@ -80,6 +82,12 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
> >>  
> >>  	ret = ffz((u32)mm_pkey_allocation_map(mm));
> >>  	mm_set_pkey_allocated(mm, ret);
> >> +
> >> +	/*
> >> +	 * enable the key in the hardware
> >> +	 */
> >> +	if (ret > 0)
> >> +		__arch_activate_pkey(ret);
> >>  	return ret;
> >>  }
> >>  
> >> @@ -91,6 +99,10 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
> >>  	if (!mm_pkey_is_allocated(mm, pkey))
> >>  		return -EINVAL;
> >>  
> >> +	/*
> >> +	 * Disable the key in the hardware
> >> +	 */
> >> +	__arch_deactivate_pkey(pkey);
> >>  	mm_set_pkey_free(mm, pkey);
> >>  
> >>  	return 0;
> >
> > I think some of these patches can be merged, too much fine granularity
> > is hurting my ability to see the larger function/implementation.
> 
> 
> Completely agree

Me agree too :) Had to fine-grain it to satisfy comments
received during the initial versions.  I had about 10-12 patches in total.

Thanks, will merge a couple of these patches.

RP
