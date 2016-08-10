Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8VDh6l4XzDr3M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:04:04 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7ABwS9F010861
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:04:02 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24qm9rthf3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:04:02 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 10 Aug 2016 09:03:59 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 8E6C83520068
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 08:03:36 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7AC3uJd5189688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:03:56 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7AC3uAu027559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 09:03:56 -0300
Subject: Re: [PATCH v2 1/2] powerpc: add refcount to struct pci_controller
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
 <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 10 Aug 2016 09:03:52 -0300
MIME-Version: 1.0
In-Reply-To: <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d1fd4576-8011-45b5-0bf8-0b1045e932db@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2016 10:45 PM, Andrew Donnellan wrote:
>> [snip] Notably, only
>> the pseries platform calls pcibios_free_controller() for some purpose
>> other than to release the pci_controller in case of errors just after
>> the call to pcibios_alloc_controller() (i.e., 'goto error' scenarios).
>
> cxl's vPHB API also uses pcibios_free_controller() [snip]

Cool. I see I missed this report line from grep; thanks. I was mostly
biased at arch/powerpc/ and driver/pci/ these days.

> I'm currently working on a cxl defect found by an IBM test team where we
> run into this - will review this patch more thoroughly and test it shortly.

That's great; thanks!

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
