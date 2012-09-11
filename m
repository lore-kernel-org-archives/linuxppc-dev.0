Return-Path: <bhelgaas@google.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 748BC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 00:29:04 +1000 (EST)
Received: by lags15 with SMTP id s15so315749lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2012 07:28:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120911112924.c2206bc738a2c29259f6e2d8@canb.auug.org.au>
References: <20120911112924.c2206bc738a2c29259f6e2d8@canb.auug.org.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Sep 2012 08:28:39 -0600
Message-ID: <CAErSpo5Qoq6J7gB3o7Oc_YwfBXkXy8vHvbBXHkvb93CHYGHb4g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pci tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Yijing Wang <wangyijing@huawei.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 10, 2012 at 7:29 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Bjorn,
>
> After merging the pci tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> arch/powerpc/platforms/powernv/pci-ioda.c: In function 'pnv_pci_window_alignment':
> arch/powerpc/platforms/powernv/pci-ioda.c:1163:13: error: 'struct pci_dev' has no member named 'pcie_type'
>
> Caused by commit ac161fbfdaa2 ("powerpc/powernv: I/O and memory alignment
> for P2P bridges").  pcie_type was removed in commit b2ef39be5744 ("PCI:
> Remove unused field pcie_type from struct pci_dev") (also in the pci
> tree).
>
> I have used the pci tree from next-20120910 for today.

Thanks.

Gavin, Ben, I folded in the trivial fix and updated both my
pci/gavin-window-alignment and next branches.

Ben, I think you'll need to pull in pci/jiang-pcie-cap before
pci/gavin-window-alignment to get both pieces.

Bjorn
