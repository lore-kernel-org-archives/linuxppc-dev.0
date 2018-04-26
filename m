Return-Path: <srs0=rtz9=hp=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wyrf183BzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 23:41:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Wyrd5jXYz8t2S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 23:41:05 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Wyrd10jhz9s02
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 23:41:05 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id f15so18415821pfn.0
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 06:41:04 -0700 (PDT)
Date: Thu, 26 Apr 2018 23:40:49 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Srikar Dronamraju
 <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>, Hari
 Bathini <hbathini@linux.vnet.ibm.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/fadump: un-register fadump on kexec path.
Message-ID: <20180426234049.3f7909df@roar.ozlabs.ibm.com>
In-Reply-To: <d064a5aa-9568-b83b-3154-c719721de17e@linux.vnet.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
 <152474292369.5697.4957552670306451723.stgit@jupiter.in.ibm.com>
 <20180426225757.2a8552e0@roar.ozlabs.ibm.com>
 <d064a5aa-9568-b83b-3154-c719721de17e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Apr 2018 18:35:10 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 04/26/2018 06:28 PM, Nicholas Piggin wrote:
> > On Thu, 26 Apr 2018 17:12:03 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >   
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> otherwise the fadump registration in new kexec-ed kernel complains that
> >> fadump is already registered. This makes new kernel to continue using
> >> fadump registered by previous kernel which may lead to invalid vmcore
> >> generation. Hence this patch fixes this issue by un-registering fadump
> >> in fadump_cleanup() which is called during kexec path so that new kernel
> >> can register fadump with new valid values.  
> > 
> > I assume this series is for 4.17, but it might be good to get this one
> > into the 4.16 fixes branch? Should it go to stable kernels?  
> 
> You are right. Should I send it out as separate patch ?

Yes I think so.

Thanks,
Nick
