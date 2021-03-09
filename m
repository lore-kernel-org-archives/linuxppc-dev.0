Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AC0C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:29:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D800601FB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D800601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dw0zb0011z3cX8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 03:29:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ILOAqBHi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=No7cj+LO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ILOAqBHi; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=No7cj+LO; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dw0z54YQWz2yjL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 03:29:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19LP5gRKwmwH1jc81ul4akn1QbWUor1+lZY/TUhT8Cc=;
 b=ILOAqBHi8X6bZU3I5lDUIBDTE1qG1fVrwJ8TX086qi/ouaP/QZcUY7wo8KjBj+FBJhVkVH
 Qk1CJ+FeByCUutBFT3XwCMvuQx5XCh3MCfARgvy87EazSKQSumrapRRbVABkGFEs8WfrAi
 rLCj0LnyJBkMrOvvQ115Tm+Enaou1kI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19LP5gRKwmwH1jc81ul4akn1QbWUor1+lZY/TUhT8Cc=;
 b=No7cj+LO+R8RKXt9jHOAjSiQPNmMDAyk3+Sxb4lmAyNraplCQSzkrtoj21iC26zvDTNBXh
 lILzlAfgYwyw7Pjx947F8/2GbptcId5H8DzDpJgKDRi6sd26X7nBKyZw7TIsGLjF3ATYtv
 dy1swrgfuvulYwQ4jwqb+k/5vowzgFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-6dAmojhlMgOOkpbQO0364g-1; Tue, 09 Mar 2021 11:22:58 -0500
X-MC-Unique: 6dAmojhlMgOOkpbQO0364g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 411A310199A6;
 Tue,  9 Mar 2021 16:22:56 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADE225C233;
 Tue,  9 Mar 2021 16:22:46 +0000 (UTC)
Subject: Re: [PATCH 2/9] fs: add an argument-less alloc_anon_inode
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-3-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a0ca78b1-e663-8521-e69c-edae30b8082c@redhat.com>
Date: Tue, 9 Mar 2021 17:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>, Nadav Amit <namit@vmware.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Nitin Gupta <ngupta@vflare.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 09.03.21 16:53, Christoph Hellwig wrote:
> Add a new alloc_anon_inode helper that allocates an inode on
> the anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/anon_inodes.c            | 15 +++++++++++++--
>   include/linux/anon_inodes.h |  1 +
>   2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> index 4745fc37014332..b6a8ea71920bc3 100644
> --- a/fs/anon_inodes.c
> +++ b/fs/anon_inodes.c
> @@ -63,7 +63,7 @@ static struct inode *anon_inode_make_secure_inode(
>   	const struct qstr qname = QSTR_INIT(name, strlen(name));
>   	int error;
>   
> -	inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +	inode = alloc_anon_inode();
>   	if (IS_ERR(inode))
>   		return inode;
>   	inode->i_flags &= ~S_PRIVATE;
> @@ -225,13 +225,24 @@ int anon_inode_getfd_secure(const char *name, const struct file_operations *fops
>   }
>   EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);
>   
> +/**
> + * alloc_anon_inode - create a new anonymous inode
> + *
> + * Create an inode on the anon_inode file system and return it.
> + */
> +struct inode *alloc_anon_inode(void)
> +{
> +	return alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +}
> +EXPORT_SYMBOL_GPL(alloc_anon_inode);
> +
>   static int __init anon_inode_init(void)
>   {
>   	anon_inode_mnt = kern_mount(&anon_inode_fs_type);
>   	if (IS_ERR(anon_inode_mnt))
>   		panic("anon_inode_init() kernel mount failed (%ld)\n", PTR_ERR(anon_inode_mnt));
>   
> -	anon_inode_inode = alloc_anon_inode_sb(anon_inode_mnt->mnt_sb);
> +	anon_inode_inode = alloc_anon_inode();
>   	if (IS_ERR(anon_inode_inode))
>   		panic("anon_inode_init() inode allocation failed (%ld)\n", PTR_ERR(anon_inode_inode));
>   
> diff --git a/include/linux/anon_inodes.h b/include/linux/anon_inodes.h
> index 71881a2b6f7860..b5ae9a6eda9923 100644
> --- a/include/linux/anon_inodes.h
> +++ b/include/linux/anon_inodes.h
> @@ -21,6 +21,7 @@ int anon_inode_getfd_secure(const char *name,
>   			    const struct file_operations *fops,
>   			    void *priv, int flags,
>   			    const struct inode *context_inode);
> +struct inode *alloc_anon_inode(void);
>   
>   #endif /* _LINUX_ANON_INODES_H */
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

