Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B5F31A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 13:40:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 13:40:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0E487357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 13:40:06 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t533dv9716253118
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 13:40:05 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t533dXZ8000638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 13:39:33 +1000
Date: Wed, 3 Jun 2015 11:39:15 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150603033915.GB22584@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601234958.GG3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150601234958.GG3631@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 01, 2015 at 06:49:58PM -0500, Bjorn Helgaas wrote:
>On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
>> Current EEH recovery code works with the assumption: the PE has primary
>> bus. Unfortunately, that's not true to VF PEs, which generally contains
>
>"Primary bus" normally means the bus on the upstream side of a PCI bridge.
>But a PE is not a bridge, so I don't know what it means here.
>

Before VF PE introduced, a PE is a "Bus PE" which contains a pci bus. Yes, the
"primary bus" may be a little confusing, since this may refer to the upstream
side of a PCI bridge. I think the log here tries to emphasize the Bus PE
contains a whole pci bus.

>s/not true to VF PEs/not true for VF PEs/

Thanks, changed

>
>> one or multiple VFs (for VF group case). The patch creates PEs for VFs
>> at PCI final fixup time. Those PEs for VFs are indentified with newly
>
>s/indentified/identified/

Thanks, changed

>
>> introduced flag EEH_PE_VF so that we handle them differently during
>> EEH recovery.
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Richard Yang
Help you, Help me
