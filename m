Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8DW80JMQzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 11:45:39 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7A1hibJ007168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Aug 2016 21:45:37 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24qm9s62v0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 21:45:37 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 10 Aug 2016 11:45:35 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9E04B2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 11:45:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7A1jTHJ31653934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 11:45:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7A1jSqv024286
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 11:45:29 +1000
Subject: Re: [PATCH v2 1/2] powerpc: add refcount to struct pci_controller
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1470789844-16401-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 10 Aug 2016 11:45:27 +1000
MIME-Version: 1.0
In-Reply-To: <1470789844-16401-2-git-send-email-mauricfo@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5c42993e-208e-34a5-0d5e-48d9df86fa49@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/16 10:44, Mauricio Faria de Oliveira wrote:
> This commit introduces the 'refcount' field in struct pci_controller,
> along with the corresponding functions 'controller_(get|put|free)()'.
>
> The functions 'pcibios_(alloc|free)_controller()' are modified to use
> that in a backwards compatible manner. (i.e., kfree(phb) is performed
> when pcibios_free_controller() is called.)
>
> So, this patch adds the infrastructure with no functional differences
> to current users of pcibios_(alloc|free)_controller().  Notably, only
> the pseries platform calls pcibios_free_controller() for some purpose
> other than to release the pci_controller in case of errors just after
> the call to pcibios_alloc_controller() (i.e., 'goto error' scenarios).

cxl's vPHB API also uses pcibios_free_controller() (which is why we 
export the symbol, as it's called from within the cxl module). When we 
remove/shutdown the underlying cxl device, we remove all the devices 
sitting on the vPHB and then free the vPHB.

I'm currently working on a cxl defect found by an IBM test team where we 
run into this - will review this patch more thoroughly and test it shortly.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
