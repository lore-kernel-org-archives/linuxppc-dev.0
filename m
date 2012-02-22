Return-Path: <bhelgaas@google.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96951B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 09:47:24 +1100 (EST)
Received: by wgbdt12 with SMTP id dt12so456874wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 14:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329946909.20389.10.camel@pasglop>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
 <1329946909.20389.10.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Feb 2012 14:47:00 -0800
Message-ID: <CAErSpo7bMNbZgEZFmezJwTvGGoRsCe-qZavBJZS_q4DmnNAE7A@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2012 at 1:41 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>> We already use pci_flags, so this just sets pci_flags directly and remov=
es
>> the intermediate step of figuring out pci_probe_only, then using it to s=
et
>> pci_flags.
>
> Ah yes, those flags are now common indeed.
>
>> The PCI core provides a pci_flags definition (currently __weak), so drop
>> the powerpc definitions in favor of that. =A0Note that we must set the p=
pc64
>> default (PCI_PROBE_ONLY set) in the 64-bit setup_arch() before calling
>> the platform .setup_arch() method, which may override the default.
>
> Ah wait, I have a patch about to hit -next that flips the ppc64
> default...
>
> Maybe it's easier if you just pick it up and stick it in your series,
> that will avoid integration clashes..
>
> http://patchwork.ozlabs.org/patch/141225/

Sure, I'll pick up that patch and repost the series.  I'll wait until
tomorrow or so in case anybody else has comments.

Thanks,
  Bjorn
