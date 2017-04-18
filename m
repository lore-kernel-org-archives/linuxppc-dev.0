Return-Path: <elohimes@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6TK71jM7zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 12:16:42 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id t14so22562560oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 19:16:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW0ds9fXmu77eJscBhYQnQKa9J=+KWThEwC3Kc++YCE-Q@mail.gmail.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213639.21092.22951.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAE9FiQW0ds9fXmu77eJscBhYQnQKa9J=+KWThEwC3Kc++YCE-Q@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 18 Apr 2017 10:16:40 +0800
Message-ID: <CAONzpcYdK-aCuNkH7547z2cQt331V1zruNxPmKNs3TCTDAgmQg@mail.gmail.com>
Subject: Re: [PATCH v11 2/7] PCI: A fix for caculating bridge window's size
 and alignment
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Li Zhong <zhong@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yinghai,

On 18 April 2017 at 05:45, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Apr 17, 2017 at 2:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> From: Yongji Xie <elohimes@gmail.com>
>>
>> In case that one device's alignment is greater than its size,
>> we may get an incorrect size and alignment for its bus's memory
>> window in pbus_size_mem(). This patch fixes this case.
>
> In which case, that device alignment is not same as size?
> or powerpc need small size, but alignment is PAGE_SIZE?
>

Yes, powerpc may have some small size (smaller than PAGE_SIZE)
devices whose alignment would be enforced to be PAGE_SIZE
by pcibios_default_alignment() (in patch 4).

Thanks,
Yongji
