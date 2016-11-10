Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDkVq2dLczDvNk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 11:31:15 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so1926838pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 16:31:15 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm: Correct process and partition table max size
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <dc8556fa-c8f1-d2e7-6321-f0d9c56fa422@gmail.com>
Date: Thu, 10 Nov 2016 11:30:56 +1100
MIME-Version: 1.0
In-Reply-To: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/11/16 16:36, Suraj Jitindar Singh wrote:
> Version 3.00 of the ISA states that the PATS (partition table size) field
> of the PTCR (partition table control register) and the PRTS (process table
> size) field of the partition table entry must both be less than or equal
> to 24. However the actual size of the partition and process tables is equal
> to 2 to the power of 12 plus the PATS and PRTS fields, respectively. This
> means that the max allowable size of each of these tables is 2^36 or 64GB
> for both.
> 
> Thus when checking the size shift for each we should be checking for values
> of greater than 36 instead of the current check for shifts larger than 24
> and 23.
> 

I looked at the ISA and the patch seems reasonable to me. It has no functional
impact other than when we decide to increase the size of PA(R)TB_SIZE_SHIFT

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
