Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp01V60L6zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 11:20:30 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id n24so9450255pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 17:20:30 -0700 (PDT)
Subject: Re: [PATCH] powerpc: During context switch, check before setting
 mm_cpumask
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@ozlabs.org>, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com, cyrilbur@gmail.com
References: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
 <b0537503-e415-ec23-f2c9-88d18209473e@gmail.com>
 <1475539094.3784.113.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <80788474-4c53-3e3c-8a17-e7d06b30c366@gmail.com>
Date: Tue, 4 Oct 2016 11:20:16 +1100
MIME-Version: 1.0
In-Reply-To: <1475539094.3784.113.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 04/10/16 10:58, Benjamin Herrenschmidt wrote:
> On Tue, 2016-10-04 at 10:25 +1100, Balbir Singh wrote:
>> I think this makes sense, in fact I think in the longer term we can
>> even use __set_bit() reorder-able version since we have a sync
>> coming out of schedule(). The read side for TLB flush can use a RMB
> 
> No, that wouldn't be atomic vs. other threads accessing the same
> bitmap.

Somethings distorted my thought process. Thanks!

Balbir Singh.
