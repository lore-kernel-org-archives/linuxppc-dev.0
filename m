Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryZNB3yWJzDqTt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:36:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH for-4.8 V2 03/10] powerpc/mm/radix: Add radix_set_pte to
 use in early init
In-Reply-To: <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 25 Jul 2016 18:36:09 +1000
Message-ID: <87shuyyv0m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We want to use the static key based feature check in set_pte_at. Since
> we call radix__map_kernel_page early in boot before jump label is
> initialized we can't call set_pte_at there. Add radix__set_pte for the
> same.

Although this is an OK solution to this problem, I think it highlights a
bigger problem, which is that we're still doing the feature patching too
late.

If we can move the feature patching prior to MMU init, then all (or more
of) these problems with pre vs post patching go away.

I'll see if I can come up with something tomorrow.

cheers
