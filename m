Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpyKj01WyzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 09:07:36 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6CMxi1S051613
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:07:34 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243ensm5vt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:07:34 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Tue, 12 Jul 2016 20:07:32 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 1CCBB1DC0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 19:07:21 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6CN7TlF15663504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:07:29 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6CN7SBc021922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 20:07:28 -0300
Subject: Re: [PATCH] powerpc: fix oops in pcibios_release_device() after
 pcibios_free_controller()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1467683085-3537-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1467687331.13965.27.camel@kernel.crashing.org>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Tue, 12 Jul 2016 20:07:25 -0300
MIME-Version: 1.0
In-Reply-To: <1467687331.13965.27.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5785782D.3010407@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

On 07/04/2016 11:55 PM, Benjamin Herrenschmidt wrote:
> Have you considered instead adding a kref to the PHB and only freeing
> it when all devices have been freed ? Or it's too hard to tract device
> creation ?

Can you clarify which are the devices that should be tracked w/ krefs to
the PHB?

I've been wondering if it's just the root bus (phb->bus) -- which relays
on it (ie its phb->bus->children and phb->bus->devices) being eventually
freed in order to free the phb, or perhaps track the children & devices
directly.

If that's too far from sensible, can you point some interesting places
to look at? I've read much of arch/powerpc/kernel/pci-{common,hotplug}.c
and arch/powerpc/include/asm/pci-bridge.h, and some more in drivers/pci,
but things weren't as obvious to a newcomer in this area.

Thanks,

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center
