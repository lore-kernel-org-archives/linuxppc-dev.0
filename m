Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C6D21A00B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 02:21:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 5 Feb 2015 01:21:38 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5F7022BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 02:21:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t14FLR9j49086680
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 02:21:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t14FL2EB026833
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Feb 2015 02:21:02 +1100
Date: Wed, 4 Feb 2015 23:20:42 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] powerpc/powernv: make sure the IOV BAR will not exceed
 limit after shifting
Message-ID: <20150204152042.GA6273@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150130230803.GA6795@google.com>
 <1422946903-12958-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150204001926.GA19540@google.com>
 <20150204033409.GA11577@richard>
 <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4nLEvL4XGvkvZbfy0dFQcRDHdn5aznkx2fRMMnt1_n4g@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
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

On Wed, Feb 04, 2015 at 08:19:14AM -0600, Bjorn Helgaas wrote:
>On Tue, Feb 3, 2015 at 9:34 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
>> On Tue, Feb 03, 2015 at 06:19:26PM -0600, Bjorn Helgaas wrote:
>>>On Tue, Feb 03, 2015 at 03:01:43PM +0800, Wei Yang wrote:
>
>>>> +    vf_num = pdn->vf_pes;
>>>
>>>I can't actually build this, but I don't think pdn->vf_pes is defined yet.
>>>
>>
>> The pdn->vf_pes is defined in the next patch, it is not defined yet.
>>
>> I thought the incremental patch means a patch on top of the current patch set,
>> so it is defined as the last patch.
>
>Yes, that's fine.  I want to keep the series bisectable, so I'll fold
>these patches together.
>
>>>I pushed an updated pci/virtualization branch with these updates.  I
>>>think there's also a leak that needs to be fixed that Dan Carpenter
>>>pointed out.
>
>>>+      vf_num = pdn->vf_pes;           // FIXME not defined yet
>>
>> Do you want me poll your pci/virtualization branch and fix this?
>
>Don't worry about this FIXME; I can fix that by squashing two patches.
>But please do pull my pci/virtualization branch and fix this one (this
>is the one that I thought Dan Carpenter pointed out):
>
>  drivers/pci/iov.c:488 sriov_init() warn: possible memory leak of 'iov'

Sure, let me take a look.

-- 
Richard Yang
Help you, Help me
