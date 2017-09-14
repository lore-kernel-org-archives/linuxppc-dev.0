Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtBC03ndszDrSW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 18:14:20 +1000 (AEST)
Message-ID: <1505376837.12628.192.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/7] powerpc: Free up four 64K PTE bits in 64K backed
 HPTE pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Date: Thu, 14 Sep 2017 18:13:57 +1000
In-Reply-To: <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-5-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-08 at 15:44 -0700, Ram Pai wrote:
> The second part of the PTE will hold
> (H_PAGE_F_SECOND|H_PAGE_F_GIX) at bit 60,61,62,63.
> NOTE: None of the bits in the secondary PTE were not used
> by 64k-HPTE backed PTE.

Have you measured the performance impact of this ? The second part of
the PTE being in a different cache line there could be one...

Cheers,
Ben.
