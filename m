Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWlJ6swQzDrKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:21:32 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v82so7233807pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:21:32 -0700 (PDT)
Date: Wed, 13 Sep 2017 16:21:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/5] powerpc/mce: Hookup derror (load/store) UE errors
Message-ID: <20170913162113.49e80b39@roar.ozlabs.ibm.com>
In-Reply-To: <20170913061049.13256-4-bsingharora@gmail.com>
References: <20170913061049.13256-1-bsingharora@gmail.com>
 <20170913061049.13256-4-bsingharora@gmail.com>
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

On Wed, 13 Sep 2017 16:10:47 +1000
Balbir Singh <bsingharora@gmail.com> wrote:

> Extract physical_address for UE errors by walking the page
> tables for the mm and address at the NIP, to extract the
> instruction. Then use the instruction to find the effective
> address via analyse_instr().
> 
> We might have page table walking races, but we expect them to
> be rare, the physical address extraction is best effort. The idea
> is to then hook up this infrastructure to memory failure eventually.

This all looks pretty good to me, you can probably update these
changelogs now because you are hooking it into memory failure.

I wonder if it would be worth skipping the instruction analysis and
page table walk if we've recursed up to the maximum MCE depth, just
in case we're hitting MCEs in part of that code or data.

Thanks,
Nick
