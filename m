Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rT5rT2FFDzDqcp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 07:43:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5DLho6r044744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:43:50 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf58wnx9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:43:49 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Mon, 13 Jun 2016 18:43:45 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 836E8352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 17:43:26 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5DLhgrt27263378
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:43:42 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5DLhgm2004790
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 18:43:42 -0300
Subject: Re: [PATCH] powerpc: convert 'iommu_alloc failed' messages to dynamic
 debug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1465563831-6565-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1465686148.19533.28.camel@kernel.crashing.org>
 <575EB4DE.9080807@linux.vnet.ibm.com>
 <1465853216.3022.26.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Mon, 13 Jun 2016 18:43:38 -0300
MIME-Version: 1.0
In-Reply-To: <1465853216.3022.26.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <575F290A.2070902@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 06/13/2016 06:26 PM, Benjamin Herrenschmidt wrote:
> I've been thinking about this a bit... it might be worthwhile adding
> a dma_* call to query the approximate size of the IOMMU window, as
> a way for the device to adjust its requirements dynamically.

Ok, cool; something like it was one of the options being discussed here.

What do you mean by 'approximate'? Maybe the size of 'free regions' in 
the pools? -- not sure because iiuic the window size is static / 2 gig,
so didn't get why (or of what) to provide an approximation (for).

> Another option would be to use a dma_attr for silencing mapping errors
> which NVME could use provided it does handle them gracefully ...

Ah, that's new. Interesting. Thanks for suggestion!


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
