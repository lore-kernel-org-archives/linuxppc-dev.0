Return-Path: <bhelgaas@google.com>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com
 [IPv6:2607:f8b0:4001:c06::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTV0G35CdzDvsb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 05:52:30 +1100 (AEDT)
Received: by mail-io0-x22a.google.com with SMTP id c21so342438064ioj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 10:52:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02307B5@AcuExch.aculab.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <063D6719AE5E284EB5DD2968C1650D6DB02307B5@AcuExch.aculab.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Nov 2016 12:52:05 -0600
Message-ID: <CAErSpo7a1M+J74VkgjyGLYUZgj2rcC-sktV8a68biM8U0hv+Ng@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space is
 enabled
To: David Laight <David.Laight@aculab.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "clsoto@us.ibm.com" <clsoto@us.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Your response didn't make it to the list, I think because it's some
non-plaintext encoding that is rejected by the list (see
http://vger.kernel.org/majordomo-info.html)]

On Wed, Nov 30, 2016 at 11:56 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Bjorn Helgaas
>> Sent: 29 November 2016 04:15
>> If we update a VF BAR while it's enabled, there are two potential problems:
>>
>>   1) Any driver that's using the VF has a cached BAR value that is stale
>>      after the update, and
>>
>>   2) We can't update 64-bit BARs atomically, so the intermediate state
>>      (new lower dword with old upper dword) may conflict with another
>>      device, and an access by a driver unrelated to the VF may cause a bus
>>      error.
>
> Can the high word be first set to a value that is invalid (ie a 4G block
> that has no valid PCIe slaves) before updating the low word and finally
> the correct high word.
>
> Note that the address only has to be outside the range that the bridge
> forwards onto that specific bus.

Maybe, but I think that's getting way too complicated.  I think we
should just think of it as a higher level bug if we're trying to
update an enabled BAR.  We might have to live with that scenario for
standard BARs because firmware might have enabled it for us, and
things might break if we disable it, but I don't think we should try
to make it work for VF BARs.

Bjorn
