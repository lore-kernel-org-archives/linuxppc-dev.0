Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 595B41A1E27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:43:35 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 28 Aug 2015 11:43:33 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 432872BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:43:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7S1hPEv31588576
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:43:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7S1gxmm001288
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:42:59 +1000
Date: Fri, 28 Aug 2015 11:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/pseries: Fix corrupted pdn list
Message-ID: <20150828014234.GA32198@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150828005535.5B29814018C@ozlabs.org>
 <20150828010905.GA21981@gwshan>
 <1440725560.8076.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440725560.8076.0.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2015 at 11:32:40AM +1000, Michael Ellerman wrote:
>On Fri, 2015-08-28 at 11:09 +1000, Gavin Shan wrote:
>> On Fri, Aug 28, 2015 at 10:55:35AM +1000, Michael Ellerman wrote:
>> >On Thu, 2015-27-08 at 04:12:36 UTC, Gavin Shan wrote:
>> >> Commit cca87d30 ("powerpc/pci: Refactor pci_dn") introduced pdn
>> >> list for SRIOV VFs. It means the pdn is be put into the child list
>> >> of its parent pdn when the pdn is created. When doing PCI hot
>> >> unplugging on pSeries, the PCI device node as well as its pdn are
>> >> released through procfs entry "powerpc/ofdt". Some one else grabs
>> >> the memory chunk of the pdn and update it accordingly. At the same
>> >> time, the pdn is still tracked in the child list of parent pdn. It
>> >> leads to corrupted child list in the parent pdn.
>> >> 
>> >> This fixes above issue by removing the pdn from the child list of
>> >> its parent pdn when the device node is detached from the system.
>> >> Note the pdn is free'd when the device node is released if the
>> >> device node is dynamic one. Otherwise, the device node as well
>> >> as the pdn won't be released.
>> >> 
>> >> Fixes: cca87d30 ("powerpc/pci: Refactor pci_dn")
>> >
>> >That went into 4.1, so this should presumably go to stable?
>> 
>> Yeah, This should be put into 4.1 stable.
>
>OK thanks.
>
>I've added:
>
>  Cc: stable@vger.kernel.org # 4.1
>

Thanks, Michael :-)

>cheers
>
>
