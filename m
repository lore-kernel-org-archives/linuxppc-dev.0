Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B27921A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:53:09 +1100 (AEDT)
Date: Thu, 25 Feb 2016 15:27:31 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 08/18] powerpc/mm: Copy pgalloc (part 1)
Message-ID: <20160225042731.GG18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456202900-5454-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 10:18:10AM +0530, Aneesh Kumar K.V wrote:
> This patch make a copy of pgalloc routines for book3s. The idea is to
> enable a hash64 copy of these pgalloc routines which can be later
> updated to have a radix conditional. Radix introduce a new page table
> format with different page table size.
> 
> This mostly does:
> 
> cp pgalloc-32.h book3s/32/pgalloc.h
> cp pgalloc-64.h book3s/64/pgalloc.h

What is the motivation for copying over the 32-bit header?

Regarding the 64-bit header, I don't see anything in it that will need
to be changed for radix other than making P{G,U,M}D_INDEX_SIZE be
variables rather than constants (and possibly have a lowercase name
instead of uppercase).  What other changes are you expecting to make?

Paul.
