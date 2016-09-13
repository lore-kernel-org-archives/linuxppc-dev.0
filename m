Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYBx55vQxzDsQd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 14:47:21 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ph5so2577558pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 21:47:21 -0700 (PDT)
Subject: Re: [PATCH v1] Fix __tlbiel in hash_native_64
To: linuxppc-dev@lists.ozlabs.org
References: <1473741761-2795-1-git-send-email-bsingharora@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <3240f8ca-4817-7773-23c7-84f3d779a421@gmail.com>
Date: Tue, 13 Sep 2016 14:47:16 +1000
MIME-Version: 1.0
In-Reply-To: <1473741761-2795-1-git-send-email-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/09/16 14:42, Balbir Singh wrote:
> __tlbie and __tlbiel are out of sync. __tlbie does the right thing
> it calls tlbie with "tlbie rb, L" if CPU_FTR_ARCH_206 (cpu feature) is clear
> and with "tlbie rb" otherwise. During the cleanup of __tlbiel I noticed
> that __tlbiel was setting bit 11 PPC_BIT(21) independent of the ISA
> version for non-4k (L) pages. This patch fixes that issue. It also changes
> the current PPC_TLBIEL to PPC_TLBIEL_5 and introduces a new PPC_TLBIEL similar
> to PPC_TLBIE.
> 
> The arguments to PPC_TLBIE have also been changed/switched in order
> to be consistent with the actual assembly usage for clearer reading
> of code.
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Please ignore.. resending with fixes

Balbir
