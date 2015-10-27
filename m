Return-Path: <julian.calaby@gmail.com>
Received: from mail-io0-x22f.google.com (mail-io0-x22f.google.com
 [IPv6:2607:f8b0:4001:c06::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 376401A0479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 09:58:10 +1100 (AEDT)
Received: by ioll68 with SMTP id l68so239842397iol.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 15:58:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151027222010.GD7716@linux.vnet.ibm.com>
References: <20151023205420.GA10197@linux.vnet.ibm.com>
 <20151026.182746.1323901353520152838.davem@davemloft.net>
 <20151027222010.GD7716@linux.vnet.ibm.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 28 Oct 2015 09:57:48 +1100
Message-ID: <CAGRGNgXV+RJvjOBe351HyguYkonQ8F=CM3uZTijcqoQg6ArAcw@mail.gmail.com>
Subject: Re: [PATCH 0/5 v3] Fix NVMe driver support on Power with 32-bit DMA
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: David Miller <davem@davemloft.net>, willy@linux.intel.com,
 keith.busch@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 david@gibson.dropbear.id.au, Christoph Hellwig <hch@infradead.org>,
 linux-nvme@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nishanth,

On Wed, Oct 28, 2015 at 9:20 AM, Nishanth Aravamudan
<nacc@linux.vnet.ibm.com> wrote:
> On 26.10.2015 [18:27:46 -0700], David Miller wrote:
>> From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
>> Date: Fri, 23 Oct 2015 13:54:20 -0700
>>
>> > 1) add a generic dma_get_page_shift implementation that just returns
>> > PAGE_SHIFT
>>
>> I won't object to this patch series, but if I had implemented this I
>> would have required the architectures to implement this explicitly,
>> one-by-one.  I think it is less error prone and more likely to end
>> up with all the architectures setting this correctly.
>
> Well, looks like I should spin up a v4 anyways for the powerpc changes.
> So, to make sure I understand your point, should I make the generic
> dma_get_page_shift a compile-error kind of thing? It will only fail on
> architectures that actually build the NVME driver (as the only caller).
> But I'm not sure how exactly to achieve that, if you could give a bit
> more detail I'd appreciate it!

He's suggesting that you _don't_ put a generic implementation in
/include/linux/dma-mapping.h and instead add it to _every_
architecture.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
