Return-Path: <kirill@shutemov.name>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com
 [IPv6:2a00:1450:400c:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 012DB1A0518
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 21:32:26 +1100 (AEDT)
Received: by mail-wm0-x236.google.com with SMTP id g62so203245833wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 02:32:26 -0800 (PST)
Date: Tue, 23 Feb 2016 13:32:21 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
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
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [BUG] random kernel crashes after THP rework on s390 (maybe also
 on PowerPC and ARM)
Message-ID: <20160223103221.GA1418@node.shutemov.name>
References: <20160211192223.4b517057@thinkpad>
 <20160211190942.GA10244@node.shutemov.name>
 <20160211205702.24f0d17a@thinkpad>
 <20160212154116.GA15142@node.shutemov.name>
 <56BE00E7.1010303@de.ibm.com> <20160212181640.4eabb85f@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160212181640.4eabb85f@thinkpad>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 12, 2016 at 06:16:40PM +0100, Gerald Schaefer wrote:
> On Fri, 12 Feb 2016 16:57:27 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > > I'm also confused by pmd_none() is equal to !pmd_present() on s390. Hm?
> > 
> > Don't know, Gerald or Martin?
> 
> The implementation frequently changes depending on how many new bits Martin
> needs to squeeze out :-)
> We don't have a _PAGE_PRESENT bit for pmds, so pmd_present() just checks if the
> entry is not empty. pmd_none() of course does the opposite, it checks if it is
> empty.

I still worry about pmd_present(). It looks wrong to me. I wounder if
patch below makes a difference.

The theory is that the splitting bit effetely masked bogus pmd_present():
we had pmd_trans_splitting() in all code path and that prevented mm from
touching the pmd. Once pmd_trans_splitting() has gone, mm proceed with the
pmd where it shouldn't and here's a boom.

I'm not sure that the patch is correct wrt yound/old pmds and I have no
way to test it...

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 64ead8091248..2eeb17ab68ac 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -490,7 +490,7 @@ static inline int pud_bad(pud_t pud)
 
 static inline int pmd_present(pmd_t pmd)
 {
-	return pmd_val(pmd) != _SEGMENT_ENTRY_INVALID;
+	return !(pmd_val(pmd) & _SEGMENT_ENTRY_INVALID);
 }
 
 static inline int pmd_none(pmd_t pmd)
-- 
 Kirill A. Shutemov
