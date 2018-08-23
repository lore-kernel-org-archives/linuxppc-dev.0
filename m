Return-Path: <srs0=gqm2=lg=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wvj22KdkzF2Dd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 16:32:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41wvj21hShz8tQ2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 16:32:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41wvj14Xbvz9s5b
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 16:32:20 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7N6TASk059822
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 02:32:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m1m3r7b33-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 02:32:18 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 23 Aug 2018 07:32:16 +0100
Subject: Re: [PATCH v2] poewrpc/mce: Fix SLB rebolting during MCE recovery
 path.
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <153500011126.9482.8367068862900987587.stgit@jupiter.in.ibm.com>
Date: Thu, 23 Aug 2018 12:02:11 +0530
MIME-Version: 1.0
In-Reply-To: <153500011126.9482.8367068862900987587.stgit@jupiter.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <92846f23-137f-9647-33ca-7f0dcb367f3f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2018 10:26 AM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> With the powrpc next commit e7e81847478 (poewrpc/mce: Fix SLB rebolting
> during MCE recovery path.), the SLB error recovery is broken. The new
> change now does not add index value to RB[52-63] that selects the SLB
> entry while rebolting, instead it assumes that the shadow save area
> already have index embeded correctly in esid field. While all valid bolted
> save areas do contain index value set correctly, there is a case where
> 3rd (KSTACK_INDEX) entry for kernel stack does not embed index for NULL
> esid entry. This patch fixes that.
> 
> Without this patch the SLB rebolt code overwirtes the 1st entry of kernel
> linear mapping and causes SLB recovery to fail.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Ignore this patch.. There are few spelling mistakes in this patch.. will
resend v2 again after fixing those.

Thanks,
-Mahesh.
