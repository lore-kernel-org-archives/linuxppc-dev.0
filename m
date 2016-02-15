Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E53581A0A94
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:25:54 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 00:25:35 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 92F9738C8039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 00:25:33 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1F5PX2K30408840
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 05:25:33 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1F5PWhg012440
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 00:25:33 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 05/29] powerpc/mm: Copy pgalloc (part 2)
In-Reply-To: <20160212035334.GD13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160212035334.GD13831@oak.ozlabs.ibm.com>
Date: Mon, 15 Feb 2016 10:55:27 +0530
Message-ID: <87fuwufsu0.fsf@linux.vnet.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Feb 08, 2016 at 02:50:17PM +0530, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> This needs a proper patch description.
>
> Paul.

I am expecting part1, 2 and 3 will be folded into one patch before
merge. I updated part1 with

powerpc/mm: Copy pgalloc (part 1)

This patch make a copy of pgalloc routines for book3s. The idea is to
enable a hash64 copy of these pgalloc routines which can be later
updated to have a radix conditional. Radix introduce a new page table
format with different page table size.

This mostly does:

cp pgalloc-32.h book3s/32/pgalloc.h
cp pgalloc-64.h book3s/64/pgalloc.h

-aneesh
