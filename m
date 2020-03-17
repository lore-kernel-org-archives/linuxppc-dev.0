Return-Path: <SRS0=VLUV=5C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA135C10F29
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 08:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0987C205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 08:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHukt0tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0987C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48hRKv2jf3zDqc6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2020 19:34:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.74;
 helo=us-smtp-delivery-74.mimecast.com; envelope-from=bhe@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PHukt0tU; 
 dkim-atps=neutral
X-Greylist: delayed 306 seconds by postgrey-1.36 at bilbo;
 Tue, 17 Mar 2020 19:33:11 AEDT
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [63.128.21.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48hRJR66l1zDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2020 19:33:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584433987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zv526Cug7eY3LYo4JWW5rNWpX9kZexTXBv9hVKgtHOI=;
 b=PHukt0tUvQffyv+s6wyyIfT+lAo1NasCfP417ddIf8FUc1bPGvhY0yQM1HbGYsbdJKEg01
 tURh/kr50bFAQO+4roUyGPJcl8FDL6z3JGQy5v6IZiEVLfhCfGvwNpqOtx0Lx9QP2KkC/F
 +eom0f/WFCnhgM5mN0d4LJ6aPkT39D4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-s_xHe4yRNWGQaioXiN7t1Q-1; Tue, 17 Mar 2020 04:25:57 -0400
X-MC-Unique: s_xHe4yRNWGQaioXiN7t1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08E28017DF;
 Tue, 17 Mar 2020 08:25:55 +0000 (UTC)
Received: from localhost (ovpn-12-34.pek2.redhat.com [10.72.12.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D46D69CA3;
 Tue, 17 Mar 2020 08:25:53 +0000 (UTC)
Date: Tue, 17 Mar 2020 16:25:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] mm/hugetlb: Fix build failure with HUGETLB_PAGE but not
 HUGEBTLBFS
Message-ID: <20200317082550.GA3375@MiWiFi-R3L-srv>
References: <7e8c3a3c9a587b9cd8a2f146df32a421b961f3a2.1584432148.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e8c3a3c9a587b9cd8a2f146df32a421b961f3a2.1584432148.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nick Piggin <npiggin@suse.de>, Andi Kleen <ak@suse.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Adam Litke <agl@us.ibm.com>,
 Nishanth Aravamudan <nacc@us.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/17/20 at 08:04am, Christophe Leroy wrote:
> When CONFIG_HUGETLB_PAGE is set but not CONFIG_HUGETLBFS, the
> following build failure is encoutered:

From the definition of HUGETLB_PAGE, isn't it relying on HUGETLBFS?
I could misunderstand the def_bool, please correct me if I am wrong.

config HUGETLB_PAGE
        def_bool HUGETLBFS

> 
> In file included from arch/powerpc/mm/fault.c:33:0:
> ./include/linux/hugetlb.h: In function 'hstate_inode':
> ./include/linux/hugetlb.h:477:9: error: implicit declaration of function 'HUGETLBFS_SB' [-Werror=implicit-function-declaration]
>   return HUGETLBFS_SB(i->i_sb)->hstate;
>          ^
> ./include/linux/hugetlb.h:477:30: error: invalid type argument of '->' (have 'int')
>   return HUGETLBFS_SB(i->i_sb)->hstate;
>                               ^
> 
> Gate hstate_inode() with CONFIG_HUGETLBFS instead of CONFIG_HUGETLB_PAGE.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://patchwork.ozlabs.org/patch/1255548/#2386036
> Fixes: a137e1cc6d6e ("hugetlbfs: per mount huge page sizes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  include/linux/hugetlb.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1e897e4168ac..dafb3d70ff81 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -390,7 +390,10 @@ static inline bool is_file_hugepages(struct file *file)
>  	return is_file_shm_hugepages(file);
>  }
>  
> -
> +static inline struct hstate *hstate_inode(struct inode *i)
> +{
> +	return HUGETLBFS_SB(i->i_sb)->hstate;
> +}
>  #else /* !CONFIG_HUGETLBFS */
>  
>  #define is_file_hugepages(file)			false
> @@ -402,6 +405,10 @@ hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
>  	return ERR_PTR(-ENOSYS);
>  }
>  
> +static inline struct hstate *hstate_inode(struct inode *i)
> +{
> +	return NULL;
> +}
>  #endif /* !CONFIG_HUGETLBFS */
>  
>  #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
> @@ -472,11 +479,6 @@ extern unsigned int default_hstate_idx;
>  
>  #define default_hstate (hstates[default_hstate_idx])
>  
> -static inline struct hstate *hstate_inode(struct inode *i)
> -{
> -	return HUGETLBFS_SB(i->i_sb)->hstate;
> -}
> -
>  static inline struct hstate *hstate_file(struct file *f)
>  {
>  	return hstate_inode(file_inode(f));
> @@ -729,11 +731,6 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>  	return NULL;
>  }
>  
> -static inline struct hstate *hstate_inode(struct inode *i)
> -{
> -	return NULL;
> -}
> -
>  static inline struct hstate *page_hstate(struct page *page)
>  {
>  	return NULL;
> -- 
> 2.25.0
> 
> 

