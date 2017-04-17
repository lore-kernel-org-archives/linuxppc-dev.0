Return-Path: <bhelgaas@google.com>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com
 [IPv6:2a00:1450:400c:c09::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6CRn4801zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 01:51:33 +1000 (AEST)
Received: by mail-wm0-x230.google.com with SMTP id w64so36600070wma.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 08:51:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492293974.25766.30.camel@kernel.crashing.org>
References: <1491825494-19331-1-git-send-email-elohimes@gmail.com>
 <1491825494-19331-4-git-send-email-elohimes@gmail.com>
 <20170414155849.GB5864@bhelgaas-glaptop.roam.corp.google.com>
 <1492206774.25766.14.camel@kernel.crashing.org>
 <CAErSpo5Orx8c453Fn6-PX-7woseSkZFcYO1Yu+1L+B-h6w0T+A@mail.gmail.com>
 <1492293974.25766.30.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 10:51:09 -0500
Message-ID: <CAErSpo6X0JwjqfPN3A5XGqKTdsXw3crTOvn9n+jvN86XHgriVw@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yongji Xie <elohimes@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman <mpe@ellerman.id.au>,
 "paulus@samba.org" <paulus@samba.org>, Li Zhong <zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 15, 2017 at 5:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2017-04-15 at 11:36 -0500, Bjorn Helgaas wrote:
>> > I agree in principle. I'm surprised that PowerPC is the only one
>> > interested here though, what about other platforms who want to use
>> > KVM and PCI pass-through and use Linux to assign BARs ?
>>
>> If I understand correctly, the problem is with BARs smaller than a
>> page, and this happens more on PowerPC because larger page sizes are
>> more common there.
>
> Yes, it happens "more". That doesn't mean it doesn't happen at all on
> others :-) Anyway, I'm not objecting, just surprised.

Yeah, I agree.  Maybe the devices interesting for pass-through tend to
have BARs of least 4KB?  Those would never be a problem on x86.  But I
have absolutely no data either way.
