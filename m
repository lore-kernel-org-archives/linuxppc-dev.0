Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 294462C0129
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 08:27:11 +1000 (EST)
Date: Fri, 26 Jul 2013 17:27:00 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] kvm: powerpc: set cache coherency only for kernel
 managed pages
To: Gleb Natapov <gleb@redhat.com>
In-Reply-To: <20130725085042.GJ16400@redhat.com> (from gleb@redhat.com on
 Thu Jul 25 03:50:42 2013)
Message-ID: <1374877620.30721.32@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org list" <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 =?UTF-8?b?4oCcdGllanVuLmNoZW7igJ0=?= <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 03:50:42 AM, Gleb Natapov wrote:
> Why ppc uses page_is_ram() for mmap? How should I know? But looking at
> the function it does it only as a fallback if
> ppc_md.phys_mem_access_prot() is not provided. Making access to MMIO
> noncached as a safe fallback makes sense.

There's only one current implementation of =20
ppc_md.phys_mem_access_prot(), which is pci_phys_mem_access_prot(), =20
which also uses page_is_ram().  If page_is_ram() returns false then it =20
checks for write-combining PCI.  But yes, we would want to call =20
ppc_md.phys_mem_access_prot() if present.

Copying from the host PTE would be ideal if doesn't come with a =20
noticeable performance impact compared to other methods, but one way or =20
another we want to be sure we match.

> It is also make sense to allow noncached access to reserved ram =20
> sometimes.

Perhaps, but that's not KVM's decision to make.  You should get the =20
same result as if you mmaped it -- because QEMU already did and we need =20
to be consistent.  Not to mention the large page kernel mapping that =20
will have been done on e500...

-Scott=
