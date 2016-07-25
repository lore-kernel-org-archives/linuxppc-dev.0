Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryWl26Gd3zDqcY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 16:37:18 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so11334944pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 23:37:18 -0700 (PDT)
Date: Mon, 25 Jul 2016 16:37:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 00/10] Use jump label for cpu/mmu_has_feature
Message-ID: <20160725163711.648355ee@roar.ozlabs.ibm.com>
In-Reply-To: <87shuykzdd.fsf@skywalker.in.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160725152201.03788ccb@roar.ozlabs.ibm.com>
 <87shuykzdd.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jul 2016 11:55:50 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Sat, 23 Jul 2016 14:42:33 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >  
> >> Changes from V1:
> >> * Update "powerpc/mm: Convert early cpu/mmu feature check to use
> >> the new helpers" based on resend code changes in this area.
> >> 
> >> We now do feature fixup early and hence we can reduce the usage of
> >>  __cpu/__mmu_has_feature.  
> >
> > Is there a particular reason for for-4.8?
> >
> > I've only just started following this development so it might be
> > obvious, but if you could add some small justifications for why
> > a patch or series is done, it would be of great help to me.  
> 
> The goal is to reduce the impact of radix series on existing MMU
> function. With radix series, we do
> 
> if (radix_enabled())
>         radix_function()
> else
>         hash_function()
> 
> We did try to reduce the impact in most code path like linux page
> table accessors by moving linux pte bits around to match the
> radix/hardware requirements. But we still have other code paths where
> we do the above conditional.
> 
> Now for-4.8 is mainly because, I was trying to make sure 4.8 release
> will have a good performing radix/hash implementation which distros
> can base their kernel on. This series was posted to external list
> multiple times and I didn't receive many objections to the series.
> Hence I was thinking it to be a good idea to get it upstream by 4.8.

Thanks, I was just curious. I don't have an objection.

It would be a bigger change, but it might be nice to do alternate
patching for some of these, so we could even avoid the branch for
the radix case in some of the critical functions. That's something
for later though.

Thanks,
Nick
