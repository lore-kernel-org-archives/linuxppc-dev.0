Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00F0F2C0178
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 01:34:39 +1000 (EST)
Received: by mail-oa0-f44.google.com with SMTP id h1so4586236oag.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 08:34:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130415145834.GR6858@8bytes.org>
References: <1365966722-1804-1-git-send-email-Varun.Sethi@freescale.com>
 <20130415145834.GR6858@8bytes.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 15 Apr 2013 09:34:11 -0600
Message-ID: <CAErSpo7gsSLsa1DOix7-LRqQbpfFuf3=KAubXhwCEuqA7041EQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] iommu: Move swap_pci_ref function to pci.h.
To: Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: stuart.yoder@freescale.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 scottwood@freescale.com, Varun Sethi <Varun.Sethi@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 15, 2013 at 8:58 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Mon, Apr 15, 2013 at 12:42:00AM +0530, Varun Sethi wrote:
>> swap_pci_ref function is used by the IOMMU API code for swapping pci device
>> pointers, while determining the iommu group for the device.
>> Currently this function was being implemented for different IOMMU drivers.
>> This patch moves the function to pci.h so that the implementation can be
>> shared across various IOMMU drivers.
>
> The function is only used in IOMMU code, so I think its fine to keep it
> there (unless Bjorn disagrees and wants it in PCI code).

I agree; I don't think there's much benefit in putting something under
#ifdef CONFIG_IOMMU_API into pci.h.  Maybe there is or could be a
shared iommu header file?

Bjorn
