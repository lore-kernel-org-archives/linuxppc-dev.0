Return-Path: <SRS0=gB3U=IH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D81C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:30:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC5A6023B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC5A6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dw10c3kgRz3clg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 03:30:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fHD4d33y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fHD4d33y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=fHD4d33y; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=fHD4d33y; 
 dkim-atps=neutral
X-Greylist: delayed 87 seconds by postgrey-1.36 at boromir;
 Wed, 10 Mar 2021 03:30:05 AEDT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dw0zx09lzz3dLs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Mar 2021 03:30:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Iv7BBIxQ8+W8sz1TqvejVKfcifyHSm+wQDXMt7okOA=;
 b=fHD4d33yAvOZq2MvskNAmOPW88Lw05OK1axl1YeGpBzkCqN3hkroJJ8v3z+NCFLeyQk+5j
 4JAiuBdNsFglgc1uLXRhOH0BRFZhc7hEYmBxRkn+A3OBlZtkpWrPqVvObj6npc1twozN0s
 a0mak+NcRRfwFBsT3LXNQCcI/jKciF4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615307402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Iv7BBIxQ8+W8sz1TqvejVKfcifyHSm+wQDXMt7okOA=;
 b=fHD4d33yAvOZq2MvskNAmOPW88Lw05OK1axl1YeGpBzkCqN3hkroJJ8v3z+NCFLeyQk+5j
 4JAiuBdNsFglgc1uLXRhOH0BRFZhc7hEYmBxRkn+A3OBlZtkpWrPqVvObj6npc1twozN0s
 a0mak+NcRRfwFBsT3LXNQCcI/jKciF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-2LKAOAxWMcKIauY_Ng6y0g-1; Tue, 09 Mar 2021 11:28:28 -0500
X-MC-Unique: 2LKAOAxWMcKIauY_Ng6y0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CCD108BD0B;
 Tue,  9 Mar 2021 16:28:26 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E403E10023AE;
 Tue,  9 Mar 2021 16:28:16 +0000 (UTC)
Subject: Re: [PATCH 5/9] vmw_balloon: remove the balloon-vmware file system
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
References: <20210309155348.974875-1-hch@lst.de>
 <20210309155348.974875-6-hch@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8bdd6f30-3cd1-ad7f-df95-bbb85623ae64@redhat.com>
Date: Tue, 9 Mar 2021 17:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309155348.974875-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
> Just use the generic anon_inode file system.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/misc/vmw_balloon.c | 24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 5d057a05ddbee8..be4be32f858253 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -16,6 +16,7 @@
>   //#define DEBUG
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>   
> +#include <linux/anon_inodes.h>
>   #include <linux/types.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -1735,20 +1736,6 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
>   
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
> -
> -static int vmballoon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, BALLOON_VMW_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type vmballoon_fs = {
> -	.name           	= "balloon-vmware",
> -	.init_fs_context	= vmballoon_init_fs_context,
> -	.kill_sb        	= kill_anon_super,
> -};
> -
> -static struct vfsmount *vmballoon_mnt;
> -
>   /**
>    * vmballoon_migratepage() - migrates a balloon page.
>    * @b_dev_info: balloon device information descriptor.
> @@ -1878,8 +1865,6 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>   		iput(b->b_dev_info.inode);
>   
>   	b->b_dev_info.inode = NULL;
> -	kern_unmount(vmballoon_mnt);
> -	vmballoon_mnt = NULL;
>   }
>   
>   /**
> @@ -1895,13 +1880,8 @@ static void vmballoon_compaction_deinit(struct vmballoon *b)
>    */
>   static __init int vmballoon_compaction_init(struct vmballoon *b)
>   {
> -	vmballoon_mnt = kern_mount(&vmballoon_fs);
> -	if (IS_ERR(vmballoon_mnt))
> -		return PTR_ERR(vmballoon_mnt);
> -
>   	b->b_dev_info.migratepage = vmballoon_migratepage;
> -	b->b_dev_info.inode = alloc_anon_inode_sb(vmballoon_mnt->mnt_sb);
> -
> +	b->b_dev_info.inode = alloc_anon_inode();
>   	if (IS_ERR(b->b_dev_info.inode))
>   		return PTR_ERR(b->b_dev_info.inode);
>   
> 

Same comment regarding BALLOON_VMW_MAGIC and includes (mount.h, 
pseudo_fs.h).

Apart from that looks good.

-- 
Thanks,

David / dhildenb

