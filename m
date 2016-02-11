Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFD3A1A032C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 01:40:15 +1100 (AEDT)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 14:40:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8B5031B08067
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 14:40:23 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1BEe9C316908492
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 14:40:09 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1BEe80G002872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 07:40:09 -0700
Subject: Re: [PATCH v3 03/18] cxl: Define process problem state area at attach
 time only
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-4-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1455085746-sup-9303@delenn.ozlabs.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Message-ID: <56BC9D47.6070600@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2016 15:40:07 +0100
MIME-Version: 1.0
In-Reply-To: <1455085746-sup-9303@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/02/2016 07:32, Ian Munsie a écrit :
> It might be a reasonable idea to make cxl_psa_map fail outright if it is
> called on a context that has not been attached yet like we do in the
> user api, but I trust kernel devs to get this right more than userspace
> so I'm not too worried :)


The net effect will be the same (we return a NULL pointer, which will 
need to be handled properly by the caller), but I like your suggestion 
of checking whether the context is attached first, which avoids calling 
ioremap() with null parameters.

Pushing it further: if we don't allow mapping the psa before attaching, 
then I believe the call to cxl_afu_check_and_enable() is no longer 
useful, since the AFU will be enabled on the first attach()

[ the very existence of the call to cxl_afu_check_and_enable() confirms 
my first impression: allowing to map the psa before attaching was 
deliberate ]

   Fred
