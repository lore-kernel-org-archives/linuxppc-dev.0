Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9FXT6smfzDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 03:35:21 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BHSr5R017856
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:35:18 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rmj73ksf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:35:18 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 14:35:16 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id C88F33520070
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 13:34:52 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BHZDfU23396832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:35:13 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BHZCJ4000519
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 14:35:13 -0300
Subject: Re: [PATCH v3] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com
References: <1470865522-28046-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <fa66d691-6059-e1dd-0aa2-69346d49f16e@au1.ibm.com>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 11 Aug 2016 14:35:09 -0300
MIME-Version: 1.0
In-Reply-To: <fa66d691-6059-e1dd-0aa2-69346d49f16e@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fe4d23ab-ede0-3b6b-dd6e-7c89b4044f76@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2016 02:01 AM, Andrew Donnellan wrote:
> In cxl, we currently call:
>
>     pci_remove_root_bus(phb->bus);
>     pcibios_free_controller(phb);
>
> which appears to break with this patch after I wire up
> pci_set_host_bridge_release() in cxl, as phb can be freed before we call
> pcibios_free_controller().

Ugh; you're right. I believe the user is expected to use either one way
or another, but now I see it's not that intuitive -- a design fault.

I'll address this w/ the other review/suggestion by Gavin; replying it.

> Missing a '---' here :)
>
>> Changelog:

Ok, thanks!


-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
