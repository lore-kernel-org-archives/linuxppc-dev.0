Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJB1r5nYqzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 10:21:20 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so7154217pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 17:21:20 -0700 (PDT)
Subject: Re: [PATCH V2 4/5] powerpc/64/kexec: Copy image with MMU off when
 possible
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1471596759-3396-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <218c621a-8873-47a5-f1f5-21d530cc0005@gmail.com>
Date: Tue, 23 Aug 2016 10:21:13 +1000
MIME-Version: 1.0
In-Reply-To: <1471596759-3396-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 19/08/16 18:52, Aneesh Kumar K.V wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Currently we turn the MMU off after copying the image, and we make
> sure there is no overlap between the hash table and the target pages
> in that case.
> 
> That doesn't work for Radix however. In that case, the page tables
> are scattered and we can't really enforce that the target of the
> image isn't overlapping one of them.
> 
> So instead, let's turn the MMU off before copying the image in radix
> mode. Thankfully, in radix mode, even under a hypervisor, we know we
> don't have the same kind of RMA limitations that hash mode has.
> 
> While at it, also turn the MMU off early when using hash in non-LPAR
> mode, that way we can get rid of the collision check completely.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Looks good

Acked-by: Balbir Singh <bsingharora@gmail.com>
