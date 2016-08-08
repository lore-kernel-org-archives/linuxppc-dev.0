Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7LD433cPzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 00:59:32 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u78Es8tN104322
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 10:59:29 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24n9gyym8r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 10:59:29 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 15:59:28 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id A01B9219004D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 15:58:50 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u78ExPkx6619432
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 14:59:25 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u78ExOdB009117
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 08:59:24 -0600
Subject: Re: [PATCH v2] cxl: Use fixed width predefined types in data
 structure.
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470398520-20463-1-git-send-email-felix@linux.vnet.ibm.com>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, imunsie@au1.ibm.com, David.Laight@ACULAB.COM
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 16:59:22 +0200
MIME-Version: 1.0
In-Reply-To: <1470398520-20463-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <faa68f54-d826-02dd-9265-aeae0d8dc118@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 05/08/2016 à 14:02, Philippe Bergheaud a écrit :
> This patch fixes a regression introduced by commit b810253.
>
> It substitutes the type __u8 to u8 in the uapi header cxl.h,
> because the latter is not always defined in userland build
> environments, in particular when cross-compiling libcxl on
> x86_64 linux machines (RHEL6.7 and Ubuntu 16.04).
>
> This patch also changes the size of the field data_size, and
> makes it constant, to support 32-bit userland applications
> running on big-endian ppc64 kernels transparently.
>
> This breaks the (young) API that has been merged in v4.8.
>
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changes since v1:
>   Added an explanation for the proposed API change in the log.
>
> Note:
> As far as I know, cxlflash is the only known user of the API.


Yes, ideally, we'd like to change the type of 'data_size' to something 
smaller/constant and were expecting it's still doable since the API was 
merged to 4.8 and the expected user (cxlflash) hasn't started using the 
API yet.

Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

   Fred
