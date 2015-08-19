Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8EE81A005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 09:14:14 +1000 (AEST)
In-Reply-To: <1435815541-11860-1-git-send-email-nikunj@linux.vnet.ibm.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com,
 bharata@linux.vnet.ibm.com
Subject: Re: [RESEND] powerpc/numa: initialize distance lookup table from
 drconf path
Message-Id: <20150819231414.BF91C140771@ozlabs.org>
Date: Thu, 20 Aug 2015 09:14:14 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-07 at 05:39:01 UTC, Nikunj A Dadhania wrote:
> In some situations, a NUMA guest that supports
> ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
> distances between nodes. This is because of two problems in the
> current code.
> 
> 1) Different representations of associativity lists.
> 
>    There is an assumption about the associativity list in
>    initialize_distance_lookup_table(). Associativity list has two forms:
> 
>    a) [cpu,memory]@x/ibm,associativity has following
>       format:
>            <N> <N integers>
> 
>    b) ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays
> 
>            <M> <N> <M associativity lists each having N integers>
>            M = the number of associativity lists
>            N = the number of entries per associativity list
> 
>    Fix initialize_distance_lookup_table() so that it does not assume
>    "case a". And update the caller to skip the length field before
>    sending the associativity list.
> 
> 2) Distance table not getting updated from drconf path.
> 
>    Node distance table will not get initialized in certain cases as
>    ibm,dynamic-reconfiguration-memory path does not initialize the
>    lookup table.
> 
>    Call initialize_distance_lookup_table() from drconf path with
>    appropriate associativity list.
> 
> Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1d805440a364b4a68562

cheers
