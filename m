Return-Path: <benh@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AD331A0325
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:06:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sat, 21 Mar 2015 07:06:09 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5C8402BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:06:05 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KL5ucC46596148
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:06:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KL5Vpv013355
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 08:05:31 +1100
Message-ID: <1426885502.4770.159.camel@au1.ibm.com>
Subject: Re: [PATCH V14 00/21] Enable SRIOV on Power8
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Sat, 21 Mar 2015 08:05:02 +1100
In-Reply-To: <CAErSpo6zTLyDK+aaHK6+uwfs579Qq1vbXDx4rb9L4uNq=24dVA@mail.gmail.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150320054327.GA8119@shangw>
 <CAErSpo6zTLyDK+aaHK6+uwfs579Qq1vbXDx4rb9L4uNq=24dVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-20 at 09:34 -0500, Bjorn Helgaas wrote:
> On Fri, Mar 20, 2015 at 12:43 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> > On Fri, Mar 20, 2015 at 11:06:16AM +0800, Wei Yang wrote:
> >
> > [snip]
> >
> >>---
> >>v14:
> >>   * call ppc_md.pcibios_fixup_sriov() in pcibios_add_device
> >>   * add more explanation in change log
> >>   * Following patches have been reordered to the beginning.
> >>     "EEH refactor to use pci_dn":
> >>     8ec20d6 powerpc/powernv: Use pci_dn, not device_node, in PCI config accessor
> >>     a3460fc powerpc/pci: Refactor pci_dn
> >>     These two patches will be modified to merge with other patches which are
> >>     under discussion/review in ppc mail list. Some changes may also be made in
> >>     other patches, which I didn't include them in this series, so that the
> >>     auto build robot could work on this.
> >
> > The comment here isn't precise enough and not the things I suggested before.
> > Those 2 patches have been split into 3 patches (A/B/C). Some other EEH
> > cleanup/refactor patches depends on A/B and those patches would be merged
> > before your SRIOV patches to PowerPC tree. C, which I already sent to you,
> > need to be integrated to your patchset right after the following one:
> >
> > powerpc/pci: Don't unset PCI resources for VFs
> >
> > I guess you can move the patches around after checking if Bjorn has further
> > concerns/comments.
> 
> I think we need to move forward on this soon so it has at least a
> little time in -next.  And it sounds like I cannot merge this v14
> as-is because it doesn't include these additional EEH cleanup/refactor
> patches?  (If they are only cleanup and refactoring, I don't
> understand why they would be required, but I haven't seen them, so I'm
> taking your word for it.)
> 
> So I guess I'm waiting for v15.  Don't wait for my comments on v14.
> Ideally I'd also like an ack from a powerpc maintainer.  This has so
> much powerpc impact that I'm not comfortable stuffing this in without
> their OK.

The other option is you put the generic changes in a topic branch which
both of us merge and I take care of the rest.

Cheers,
Ben.

> Bjorn
