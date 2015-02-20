Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 900911A08A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 13:42:38 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 20 Feb 2015 12:42:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C03142CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 13:42:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1K2gOO037879916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 13:42:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1K2fwZH002984
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 13:41:59 +1100
Message-ID: <1424400095.27448.7.camel@au1.ibm.com>
Subject: Re: [PATCH V11 06/17] powerpc/pci: Add PCI resource alignment
 documentation
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Feb 2015 13:41:35 +1100
In-Reply-To: <20150220005621.GA21131@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204234433.GC11271@google.com> <1423530151.4924.73.camel@au1.ibm.com>
 <20150220005621.GA21131@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-19 at 18:56 -0600, Bjorn Helgaas wrote:

> So there are the two windows of CPU address space that are routed to the
> PHB.  And the PHB contains one M32 window and sixteen M64 windows.  What
> happens if the PHB receives an access to something that was in one of the
> two CPU address space windows, but is not contained in M32 or one of the
> M64 windows?

Some kind of error, I don't know which one at this point, possibly fatal
(checkstop or similar) or maybe a fence of the PHB. Don't do it :-)

> If that is an error or is non-sensical, then the only windows relevant to
> PCI would be the M32 and M64 windows, and we could just ignore the
> top-level two windows.

Right. In fact we pretty much hard wire that one of the top level is
small and used for M32 with a fixed layout and the other is big and used
for all M64's. We use one of the M64 to cover it entirely, which is our
"base" set of segments for allocating busses/BARs, and then we use the
remaining M64's overlaid on top of that first one for things like
SR-IOV.

> I squashed all my doc updates into the original and pushed it here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=5449d1a812d561bafe0d458132ef356765505507
> 
> If I made it say something wrong, a patch would be the best way to fix it.

Thanks, I'll have a look

Cheers,
Ben.
