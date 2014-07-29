Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 892761A019F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 17:00:54 +1000 (EST)
Message-ID: <1406617244.4935.81.camel@pasglop>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the
 valid bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 29 Jul 2014 17:00:44 +1000
In-Reply-To: <8761igu008.fsf@linux.vnet.ibm.com>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1406006862.22200.7.camel@pasglop> <8761iptebe.fsf@linux.vnet.ibm.com>
 <1406066112.22200.28.camel@pasglop> <8761igu008.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-29 at 12:25 +0530, Aneesh Kumar K.V wrote:
> We want to make sure for usage like below we don't reorder the  load.
> 
> if (pmd_trans_huge(*pmdp)){
> 
>    get_hpte_slot_array(pmdp)
> }

Shouldn't we also make sure that we don't have lock set ? (In case it's
in the middle of being updated).

Cheers,
Ben.
