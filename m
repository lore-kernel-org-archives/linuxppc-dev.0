Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C14606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VQQTu8Ca;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Riyi6GBz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLly4fQMz2y8F;
	Fri, 13 Nov 2026 00:27:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794490046;
	cv=none; b=jie75/EScUt3XpFJxgcm0rYgF4nBbbX6BPIYtmQABc9V7zjuCn8ssERRw6Zfr/Ky2rmWNCdpzOTS6iXhAdUmPCHznnsHOb5RkUSVha+covaVuNbMiu7CPCqwbEp2GU5OjFo05LOA7y8eHC2CKmEH5DAUslTWqm3OLmljU4wnph1TawH/LQD/MBkh+APwKcxAw9Pzb4dF6VSIJSMRsXD+ErsJW0FZR2g2xrLPGAHS1CCX2arPSwlBG2sIXm7Qm8wOtRIjitkB/a8ThtT7/JNBIM4FUDurJYcgVVmndYFSGaxc6t3yxh8xd19zPaoW8ymr9tzODBi3Bbkk9nNE+Mg2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794490046; c=relaxed/relaxed;
	bh=O2cMjR9yzPx4FjNIH8WeRrejetDLBf3cij4Y+ejCORQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ISoadFuJSTfFaEweXbSFjGfOLTAbP6LjkNyZSmu0ewyWJP+zOVmd78kUjrFbotoC05xqgbagBvi9ZOfVLgetTQZUehk3D6R1Jxu5xrw49AHS+QLNC7yu5IZ7renQNGI5KUkzygLbn7KDAvdChBIGkp7Zuu7z5gnEobikyrjzMhoHWdg2R6BDuukAgnuogTAeWdA2qM1oKLOS1uel02EAlkt1+L18lWIcHpd1btdbLLZ4d6v1SDPwMlLNgJ7RhVlQMajgGwPDGvDrXvCEnpDqfnNEaqsEnhKtmisWwbBLXm9xXmoZPXdNAFRW6LJ1Ecu2r06LgZLWskgJrR/nKFaQ6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VQQTu8Ca; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Riyi6GBz; dkim-atps=neutral; spf=pass (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VQQTu8Ca;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Riyi6GBz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLlt1l0tz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:27:21 +1100 (AEDT)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37DB67A013F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 08:27:18 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 08:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794490027;
	 x=1794576427; bh=O2cMjR9yzPx4FjNIH8WeRrejetDLBf3cij4Y+ejCORQ=; b=
	VQQTu8Ca+GpoqtlLEEHD9zniEnLX1LcLlkvq4k7p+NOwt37jHvnhY3yyW9FgUN65
	0HqHfGXOO8D4z/VHMHpTDBBFqQrLYqwEVaa/wTMv7YPZfmKXdJ2GqAcbIv8Wro5x
	Oi/MK5Q68KcNYdVjaIRImSzvUlNNk+V451RvXqonH6WWLcWrznW2lgvYOzc6bNPX
	HVnNMBkw5yUkC/2iwxleNjrXvASI7NlDLZR/U6BtsVSpUJ5/pqOhnIjthIyVGWpc
	QLckFVdHDENAxIbDxqUJDnjI7tI1Tia6XnZlCPhLRqsk2kt2aDQvcKBYxrr/iUJ/
	nBdqCSqcQYlYomiKlOptvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794490027; x=
	1794576427; bh=O2cMjR9yzPx4FjNIH8WeRrejetDLBf3cij4Y+ejCORQ=; b=R
	iyi6GBz1HGz15e3j6yN33Phda/8+Z0nzmtJ/0qat4vHymgPwVyp3r7fNaXKLt9z6
	x0EC3NTeXb+KTXSLVlatsAHtJbZxrhsrliNVshs4ByuHGjI3p1iwSFOLXwTeNfPB
	0Pu3MfYotvbOjx8YMKVFOq7j9AcZFo0gPW1/jTxygcHtk00WukXSD8BlHxcS7JN8
	coNgLvCIok090MOzpP2maHSnTr3z6HNOlgY6aYe6i5vRu/1rk1Zhsag5QuZt2+JU
	hcC+fZr5SGdrV148aeKrJPDBfm5Uj+NIzmKVQ5xY+SoIFYa8D1vcYzTvMRPvZLSu
	WOtX/qA7goQOrtFMA8XAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794490027; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPg==;
	s=fm2:rsa-sha256:IRgSgVzA7B/oZ2dj2VhTqpRza+pzjgBG6suylj1HtGHNZeM
	BWEl+F3n0pcCyQCS7NOTg362dbN+RtY8VzL8FbGcuTB/x1Z6/i8Vg32dNFJ+RUT3
	JyZZgIiJnnJUtFXKApAWVZzZ/sGPvlpOYIur8SalCgNEwDv74m/+ipEDMrARMS6C
	AOTL5O6XrpJvjwpm9BbY/ta3WuVxEV2xvx7rub7fcJ9bJffsd0iosYPCX2nJP9bH
	8FM/OMmwtEkrJb8qZ0akbNXy+TMvtVomX/G+JQPaujrF1QvddVIwuOHNL+9ogBT0
	k/kU6LTkAEbMqFq5HFoR1GrFLWxb9PsBX6EREiw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Kff0dgzs0zBL+zaPVEZ/FAXWzqOn0OySYPVQarW0/94=:i4c501ZyCD5sNIncROoHKwQMRTWXxYq4u1vDcRxvSsU=;
X-ME-Sender: <xms:o771apIEwU78ImdKJMIXZSKyBmiYRujvDbrz8RvwwXrsgLuEGRi70w>
    <xme:o771av_xcKDi4AJTY8aD2M04WM3Hgk0evqdkIvBIFfTGTEZXwzzCSHFmkyVHfdG1w
    IfT-fhf6AN2oVPP1Dlsyxza_lOct-jiXyPltZs1m1dzBFeGc9eaZNts>
X-ME-Proxy-Cause: dmFkZTGAGn9YXYitrhore6IN0xSvjsAnm1g8uO8G/rBlyoZEPZcGKHflQ4cd1CGyc7u3FY
    lyI4GGDINEaQvUJ60pNMagWhIrAAmeu9PCIX7BpFjMEOhFxQlDI7P9nKCEetRYakx9k4yH
    zOdFMwgpltLtiRGIJAuajTvoZLN9zd//XoA8i6mpYenbg4h1qkOvWDMJWOrgPOhfQm+jjO
    AIiaHcTGn0QmBIfDQ8RW/8HSjasttxmT/eOjUexIPxRf5pM6pH7O9LjCKTOofftixH5TVS
    XwR9P0w80zcjkjtafAhUy+Qs29wJ7VmYwj4OLeB/vOO8N4xQuyEhJ27y32P4N3c9EtiTc6
    i4rjJ2f2Jg9nwgzaQgBsV1Gzsr1y1OTTunwXZDGq+LUDFgF4/qVxEgQSBPbwAKCUmIpfGe
    Q5KfNKy7hG4qBzSjXGCIAdrS4eoB5d7AfFspixFKVSlYRSImzXCPFAGAMTKPswc8Al7RTe
    6mFof4PXlhRqj4PCnrfnAF7Iwcv5/RkbsY8Pp4ND2t99jcjcv8BFRw5m+ji31CCIrm4h+F
    3fCKRBVXM8bCIQk5/UQ2B1SIZdHp/6FuPb8qtYnb7UO5zVMLWRcvfim5icH7eSXCPeNWNT
    0ng4Psnest6tcFpeWklID9IBOLXSI3Pf/8nwvdenN7iYiKVjC/5WW/8w4ajQ
X-ME-Proxy: <xmx:p771aqg1qe7lGBvhbLQgU0oOgVcivaDpZz9ezcs3gCs9C0N__LigEw>
    <xmx:p771av6f8kcPjvAaCtvKmbHAAsVpmPPxVEX07zWmxLCdB1HtwsXTiQ>
    <xmx:p771aqqbgJM7jJcBW4dJ-W8j3SylX-rG7XCxXoBM8gXFWW38YtQ6sw>
    <xmx:p771akhSWCJ9LN8M76dbJIYsHOSgnLyVgZ9WJTYZxCEn4QPdPvhtyA>
    <xmx:q771att1eGrcIwChuJ4viY_p7BF8HjIQDVNJ9_qJY6MtXunpkOKb0HDM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B149132A0099; Thu, 12 Nov 2026 08:26:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: APvT47k4hUj-
Date: Thu, 12 Nov 2026 14:26:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <ba23a789-9820-4223-a6db-d9e99ebcf356@app.fastmail.com>
In-Reply-To: <avWo4NrAPX8BisCY@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org> <avWo4NrAPX8BisCY@kernel.org>
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026, at 12:54, Mike Rapoport wrote:
> On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
>> architecture is left using it, so remove the remnants in common code.
>> 
>> It is likely that further cleanups are possible in the page table
>> code but those are not obvious from the config options.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  include/linux/hugetlb.h | 5 +----
>>  include/linux/mm.h      | 1 -
>>  include/linux/pgtable.h | 9 ---------
>>  3 files changed, 1 insertion(+), 14 deletions(-)
>
> With this and arm HIGHPTE patches applied there are still a few leftovers:
>
> $ git grep  HIGHPTE
> arch/arm/configs/vt8500_v6_v7_defconfig:CONFIG_HIGHPTE=y

This got dropped in patch 5/6 in v2, but I've moved that here now.

> mm/memory.c:     * Dumping the PTE would be nice, but it's tricky with 
> CONFIG_HIGHPTE,

Added the patch below for this. Untested so far.

> mm/pgtable-generic.c: * kmapped if necessary (when CONFIG_HIGHPTE), and 
> locked against concurrent

Updated the comment and also dropped __pte_map() after I noticed that
open-coding the only caller in pte_offset_map_rw_nolock() is consistent
with that comment change:

--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -314,7 +314,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
                pmd_clear_bad(pmd);
                goto nomap;
        }
-       return __pte_map(&pmdval, addr);
+       return pte_offset_kernel(&pmdval, addr);
 nomap:
        rcu_read_unlock();
        return NULL;


> mm/userfaultfd.c:        * index ordering when CONFIG_HIGHPTE is 
> enabled. We mapped dst_pte

Dropped that comment block as it no longer applies.

> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks,

      Arnd
---
Subject: [PATCH] mm: print pte in __print_bad_page_map_pgtable()

HIGHPTE support is gone now, so it's easy enough to print the
PTE here along with the upper level entries.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee..dabeb5568c94 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -528,9 +528,11 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	char p4d_str[PTVAL_STR_MAX];
 	char pud_str[PTVAL_STR_MAX];
 	char pmd_str[PTVAL_STR_MAX];
+	char pte_str[PTVAL_STR_MAX];
 	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
 	pmd_t pmd, *pmdp;
+	pte_t pte, *ptep;
 	pgd_t *pgdp;
 
 	/*
@@ -567,13 +569,18 @@ static void __print_bad_page_map_pgtable(struct mm_struct *mm, unsigned long add
 	pmd = pmdp_get(pmdp);
 	ptval_to_str(pmd_str, pmd_val(pmd));
 
-	/*
-	 * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
-	 * because the table should already be mapped by the caller and
-	 * doing another map would be bad. print_bad_page_map() should
-	 * already take care of printing the PTE.
-	 */
-	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s\n", pgd_str, p4d_str, pud_str, pmd_str);
+	if (!pmd_present(pmd) || pmd_leaf(pmd)) {
+		pr_alert("pgd:%s p4d:%s pud:%s pmd: %s\n",
+			 pgd_str, p4d_str, pud_str, pmd_str);
+		return;
+	}
+
+	ptep = pte_offset_kernel(pmdp, addr);
+	pte = ptep_get(ptep);
+	ptval_to_str(pte_str, pte_val(pte));
+
+	pr_alert("pgd:%s p4d:%s pud:%s pmd:%s pte:%s\n",
+		 pgd_str, p4d_str, pud_str, pmd_str, pte_str);
 }
 
 /*

