Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltw75SHdzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:25:43 +1000 (AEST)
In-Reply-To: <153072701775.29016.13501175476729182702.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v6, 1/8] powerpc/pseries: Avoid using the size greater than
 RTAS_ERROR_LOG_MAX.
Message-Id: <41ltvx6gM6z9s3Z@ozlabs.org>
Date: Thu,  9 Aug 2018 00:25:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-04 at 17:57:02 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The global mce data buffer that used to copy rtas error log is of 2048
> (RTAS_ERROR_LOG_MAX) bytes in size. Before the copy we read
> extended_log_length from rtas error log header, then use max of
> extended_log_length and RTAS_ERROR_LOG_MAX as a size of data to be copied.
> Ideally the platform (phyp) will never send extended error log with
> size > 2048. But if that happens, then we have a risk of buffer overrun
> and corruption. Fix this by using min_t instead.
> 
> Fixes: d368514c3097 ("powerpc: Fix corruption when grabbing FWNMI data")
> Reported-by: Michal Suchanek <msuchanek@suse.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/74e96bf44f430cf7a01de19ba6cf49

cheers
