Return-Path: <grantgrundler@gmail.com>
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com
 [IPv6:2a00:1450:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C28E1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 03:56:30 +1000 (AEST)
Received: by wibhh20 with SMTP id hh20so40594441wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 10:56:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439398807.2825.51.camel@HansenPartnership.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
 <1439398807.2825.51.camel@HansenPartnership.com>
Date: Wed, 12 Aug 2015 10:56:26 -0700
Message-ID: <CAP6odjhfTHzgEivDUxXyU=VBG4U85ETxv1gcogE9GVGoGQ37-w@mail.gmail.com>
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
From: Grant Grundler <grantgrundler@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk,
 dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
 alex.williamson@redhat.com, Grant Grundler <grundler@parisc-linux.org>,
 open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2015 at 10:00 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2015-08-12 at 09:05 +0200, Christoph Hellwig wrote:
...
>> However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
>> to be operate mostly on virtual addresses.  It's a fairly odd concept
>> that I don't fully grasp, so I'll need some help with those if we want
>> to bring this forward.

James explained the primary function of IOMMUs on parisc (DMA-Cache
coherency) much better than I ever could.

Three more observations:
1) the IOMMU can be bypassed by 64-bit DMA devices on IA64.

2) IOMMU enables 32-bit DMA devices to reach > 32-bit physical memory
and thus avoiding bounce buffers. parisc and older IA-64 have some
32-bit PCI devices - e.g. IDE boot HDD.

3) IOMMU acts as a proxy for IO devices by fetching cachelines of data
for PA-RISC systems whose memory controllers ONLY serve cacheline
sized transactions. ie. 32-bit DMA results in the IOMMU fetching the
cacheline and updating just the 32-bits in a DMA cache coherent
fashion.

Bonus thought:
4) IOMMU can improve DMA performance in some cases using "hints"
provided by the OS (e.g. prefetching DMA data or using READ_CURRENT
bus transactions instead of normal memory fetches.)

cheers,
grant
