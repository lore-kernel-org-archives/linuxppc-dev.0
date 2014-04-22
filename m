Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DDB6E1400EC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 09:00:26 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 23 Apr 2014 09:00:24 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1AEED2BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 09:00:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3MMdTII63045796
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 08:39:29 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3MN0KS8014080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 09:00:21 +1000
Date: Wed, 23 Apr 2014 09:00:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
Message-ID: <20140422230033.GA12208@shangw>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140421233423.GA4023@shangw> <20140422074437.GB6431@richard>
 <1398155109.19682.89.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398155109.19682.89.camel@pasglop>
Cc: aik@au1.ibm.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2014 at 06:25:09PM +1000, Benjamin Herrenschmidt wrote:
>On Tue, 2014-04-22 at 15:44 +0800, Wei Yang wrote:
>> So this patch(the 2nd one) doesn't contribute to clear the warning and
>> error.
>> Only the first patch did it. Please ignore this one.
>
>But is it correct ? It's not right to keep a refcount elevated if we
>don't have to.
>
>Gavin, can you get to the bottom of that refcount business ?
>

Ben, "struct pci_dn::pcidev" was used by EEH originally. We don't
use it any more. So it can be removed.

Currently, EEH has following 4 functions to do conversion from
one to another. None of them relies on "struct pci_dn::pcidev".

of_node_to_eeh_dev()	device_node -> pci_dn -> eeh_dev
pci_dev_to_eeh_dev()    pci_dev     -> device -> archdata -> eeh_dev
eeh_dev_to_of_node()    eeh_dev     -> device_node
eeh_dev_to_pci_dev()    eeh_dev     -> pci_dev

The side effect of holding pci_dev refcount is the pci_dev, eeh_dev,
eeh_pe instance can't be free'ed during fully hotplug though EEH can
survive. It's reasonable to remove it.

Thanks,
Gavin
