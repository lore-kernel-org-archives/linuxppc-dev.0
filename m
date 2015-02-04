Return-Path: <bhelgaas@google.com>
Received: from mail-qg0-x22e.google.com (mail-qg0-x22e.google.com
 [IPv6:2607:f8b0:400d:c04::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C57A01A09D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:19:38 +1100 (AEDT)
Received: by mail-qg0-f46.google.com with SMTP id j5so1324280qga.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2015 06:19:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150204033409.GA11577@richard>
References: <20150130230803.GA6795@google.com>
 <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204001926.GA19540@google.com> <20150204033409.GA11577@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 4 Feb 2015 08:19:14 -0600
Message-ID: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>,
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

On Tue, Feb 3, 2015 at 9:34 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, Feb 03, 2015 at 06:19:26PM -0600, Bjorn Helgaas wrote:
>>On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:

>>> +    vf_num = pdn->vf_pes;
>>
>>I can't actually build this, but I don't think pdn->vf_pes is defined yet.
>>
>
> The pdn->vf_pes is defined in the next patch, it is not defined yet.
>
> I thought the incremental patch means a patch on top of the current patch set,
> so it is defined as the last patch.

Yes, that's fine.  I want to keep the series bisectable, so I'll fold
these patches together.

>>I pushed an updated pci/virtualization branch with these updates.  I
>>think there's also a leak that needs to be fixed that Dan Carpenter
>>pointed out.

>>+      vf_num = pdn->vf_pes;           // FIXME not defined yet
>
> Do you want me poll your pci/virtualization branch and fix this?

Don't worry about this FIXME; I can fix that by squashing two patches.
But please do pull my pci/virtualization branch and fix this one (this
is the one that I thought Dan Carpenter pointed out):

  drivers/pci/iov.c:488 sriov_init() warn: possible memory leak of 'iov'
