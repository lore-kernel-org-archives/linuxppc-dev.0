Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt1f5187SzDqJp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 11:48:45 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id q76so782093pfq.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 18:48:44 -0700 (PDT)
Date: Thu, 14 Sep 2017 11:48:34 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 5/7] powerpc: Swizzle around 4K PTE bits to free up bit
 5 and bit 6
Message-ID: <20170914114834.62dcc428@firefly.ozlabs.ibm.com>
In-Reply-To: <1504910713-7094-6-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-6-git-send-email-linuxram@us.ibm.com>
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

On Fri,  8 Sep 2017 15:44:45 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> We  need  PTE bits  3 ,4, 5, 6 and 57 to support protection-keys,
> because these are  the bits we want to consolidate on across all
> configuration to support protection keys.
> 
> Bit 3,4,5 and 6 are currently used on 4K-pte kernels.  But bit 9
> and 10 are available.  Hence  we  use the two available bits and
> free up bit 5 and 6.  We will still not be able to free up bit 3
> and 4. In the absence  of  any  other free bits, we will have to
> stay satisfied  with  what we have :-(.   This means we will not
> be  able  to support  32  protection  keys, but only 8.  The bit
> numbers are  big-endian as defined in the  ISA3.0
>

Any chance for 4k PTE's we can do slot searching for the PTE?
I guess thats add additional complexity

Balbir Singh.
