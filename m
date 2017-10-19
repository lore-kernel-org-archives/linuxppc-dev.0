Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHYC92gCZzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 13:43:33 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id t188so5414711pfd.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 19:43:33 -0700 (PDT)
Date: Thu, 19 Oct 2017 13:43:19 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: jglisse@redhat.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrea Arcangeli
 <aarcange@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Joerg
 Roedel <jroedel@suse.de>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Optimize mmu_notifier->invalidate_range callback
Message-ID: <20171019134319.1b856091@MiWiFi-R3-srv>
In-Reply-To: <20171017031003.7481-1-jglisse@redhat.com>
References: <20171017031003.7481-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 16 Oct 2017 23:10:01 -0400
jglisse@redhat.com wrote:

> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> (Andrew you already have v1 in your queue of patch 1, patch 2 is new,
>  i think you can drop it patch 1 v1 for v2, v2 is bit more conservative
>  and i fixed typos)
>=20
> All this only affect user of invalidate_range callback (at this time
> CAPI arch/powerpc/platforms/powernv/npu-dma.c, IOMMU ATS/PASID in
> drivers/iommu/amd_iommu_v2.c|intel-svm.c)
>=20
> This patchset remove useless double call to mmu_notifier->invalidate_range
> callback wherever it is safe to do so. The first patch just remove useless
> call

As in an extra call? Where does that come from?

> and add documentation explaining why it is safe to do so. The second
> patch go further by introducing mmu_notifier_invalidate_range_only_end()
> which skip callback to invalidate_range this can be done when clearing a
> pte, pmd or pud with notification which call invalidate_range right after
> clearing under the page table lock.
>

Balbir Singh.
