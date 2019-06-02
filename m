Return-Path: <SRS0=Rp/q=UB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE588C282DC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Jun 2019 07:45:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F5B27849
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Jun 2019 07:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F5B27849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Gqwj4WhnzDqY1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Jun 2019 17:45:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sina.com
 (client-ip=202.108.3.162; helo=mail3-162.sinamail.sina.com.cn;
 envelope-from=hdanton@sina.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sina.com
X-Greylist: delayed 135 seconds by postgrey-1.36 at bilbo;
 Sun, 02 Jun 2019 17:42:26 AEST
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn
 [202.108.3.162])
 by lists.ozlabs.org (Postfix) with SMTP id 45GqsG4tLmzDqR7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Jun 2019 17:42:24 +1000 (AEST)
Received: from unknown (HELO localhost.localdomain)([123.112.52.63])
 by sina.com with ESMTP
 id 5CF37D4B00006234; Sun, 2 Jun 2019 15:39:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 820312401022
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/16] sparc64: use the generic get_user_pages_fast code
Date: Sun,  2 Jun 2019 15:39:48 +0800
Message-Id: <20190601074959.14036-11-hch@lst.de>
In-Reply-To: <20190601074959.14036-1-hch@lst.de>
References: <20190601074959.14036-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <https://lore.kernel.org/lkml/20190601074959.14036-11-hch@lst.de/>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Jun 2019 17:44:24 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: x86@kernel.org, Rich Felker <dalias@libc.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Nicholas Piggin <npiggin@gmail.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 Andrey Konovalov <andreyknvl@google.com>, sparclinux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190602073948.2kuFtdc0b_v-5gIWDV0bJYfn8VqgRRBUEKe2NuYTUi8@z>


Hi Christoph 

On Sat,  1 Jun 2019 09:49:53 +0200 Christoph Hellwig wrote:
> 
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index a93eca29e85a..2301ab5250e4 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -1098,6 +1098,24 @@ static inline unsigned long untagged_addr(unsigned long start)
>  }
>  #define untagged_addr untagged_addr
>  
> +static inline bool pte_access_permitted(pte_t pte, bool write)
> +{
> +	u64 prot;
> +
> +	if (tlb_type == hypervisor) {
> +		prot = _PAGE_PRESENT_4V | _PAGE_P_4V;
> +		if (prot)

Feel free to correct me if I misread or miss anything.
It looks like a typo: s/prot/write/, as checking _PAGE_PRESENT_4V and
_PAGE_P_4V makes prot always have _PAGE_WRITE_4V set, regardless of write.

> +			prot |= _PAGE_WRITE_4V;
> +	} else {
> +		prot = _PAGE_PRESENT_4U | _PAGE_P_4U;
> +		if (write)
> +			prot |= _PAGE_WRITE_4U;
> +	}
> +
> +	return (pte_val(pte) & (prot | _PAGE_SPECIAL)) == prot;
> +}
> +#define pte_access_permitted pte_access_permitted
> +
>  #include <asm/tlbflush.h>
>  #include <asm-generic/pgtable.h>

BR
Hillf

