Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B077F1A0405
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 02:05:03 +1100 (AEDT)
Received: by mail-wm0-x229.google.com with SMTP id g62so241291055wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:05:03 -0800 (PST)
Date: Wed, 17 Feb 2016 17:04:56 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
Message-ID: <20160217150456.GA15882@node.shutemov.name>
References: <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
 <20160212231510.GB15142@node.shutemov.name>
 <alpine.LFD.2.20.1602131238260.1910@schleppi>
 <20160215113159.GA28832@node.shutemov.name>
 <20160215193702.4a15ed5e@thinkpad>
 <20160215213526.GA9766@node.shutemov.name>
 <20160216172444.013988d8@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160216172444.013988d8@thinkpad>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 16, 2016 at 05:24:44PM +0100, Gerald Schaefer wrote:
> On Mon, 15 Feb 2016 23:35:26 +0200
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > Is there any chance that I'll be able to trigger the bug using QEMU?
> > Does anybody have an QEMU image I can use?
> > 
> 
> I have no image, but trying to reproduce this under virtualization may
> help to trigger this also on other architectures. After ruling out IPI
> vs. fast_gup I do not really see why this should be arch-specific, and
> it wouldn't be the first time that we hit subtle races first on s390, due
> to our virtualized environment (my test case is make -j20 with 10 CPUs and
> 4GB of memory, no swap).

Could you post your kernel config?

It would be nice also to check if disabling split_huge_page() would make
any difference:

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a75081ca31cf..26d2b7b21021 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3364,6 +3364,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	bool mlocked;
 	unsigned long flags;
 
+	return -EBUSY;
+
 	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
 	VM_BUG_ON_PAGE(!PageAnon(page), page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
-- 
 Kirill A. Shutemov
