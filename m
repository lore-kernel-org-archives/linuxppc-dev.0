Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9846C6786F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 11:47:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4BD20820
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 11:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4BD20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m3Mt0JL0zF3KS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 22:47:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m3KV2YMgzF3N7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 22:45:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42m3KT3g1nz9sPQ;
 Thu,  1 Nov 2018 22:45:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ppc4xx: ocm: fix errnous "failed to create file" errors
In-Reply-To: <20181028161702.9300-1-chunkeey@gmail.com>
References: <20181028161702.9300-1-chunkeey@gmail.com>
Date: Thu, 01 Nov 2018 22:45:00 +1100
Message-ID: <87lg6ddnsz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Paul Mackerras <paulus@samba.org>,
 Markus Elfring <elfring@users.sourceforge.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christian,

Christian Lamparter <chunkeey@gmail.com> writes:
> Previously, the kernel would complain:
>
> | debugfs ppc4xx ocm: failed to create file
>
> But the "info" file was still created and working. This
> is because debugfs_create_file() returns a pointer to a
> struct *dentry on success or -ENODEV when debugfs isn't
> available. This patch fixes both the debugfs_create_dir()
> and debugfs_create_file() check, so this will work as
> expected.
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>
> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
> index 69d9f60d9fe5..e616c8636303 100644
> --- a/arch/powerpc/platforms/4xx/ocm.c
> +++ b/arch/powerpc/platforms/4xx/ocm.c
> @@ -293,13 +293,14 @@ static int ocm_debugfs_init(void)
>  {
>  	struct dentry *junk;
>  
> -	junk = debugfs_create_dir("ppc4xx_ocm", 0);
> -	if (!junk) {
> +	junk = debugfs_create_dir("ppc4xx_ocm", NULL);
> +	if (IS_ERR_OR_NULL(junk)) {
>  		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create dir\n");
>  		return -1;
>  	}
>  
> -	if (debugfs_create_file("info", 0644, junk, NULL, &ocm_debugfs_fops)) {
> +	if (IS_ERR_OR_NULL(debugfs_create_file("info", 0644, junk, NULL,
> +					       &ocm_debugfs_fops))) {
>  		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create file\n");
>  		return -1;
>  	}

Typically we would just make the whole function not compile when DEBUG_FS
is disabled, eg:

diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
index f5bbd4563342..c5293a28545c 100644
--- a/arch/powerpc/platforms/4xx/ocm.c
+++ b/arch/powerpc/platforms/4xx/ocm.c
@@ -286,6 +286,7 @@ static const struct file_operations ocm_debugfs_fops = {
 	.release = single_release,
 };
 
+#ifdef CONFIG_DEBUG_FS
 static int ocm_debugfs_init(void)
 {
 	struct dentry *junk;
@@ -303,6 +304,9 @@ static int ocm_debugfs_init(void)
 
 	return 0;
 }
+#else
+static int ocm_debugfs_init(void) { return 0; }
+#endif
 
 void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
 			int flags, const char *owner)


I don't really mind, but I think the #ifdef approach is simpler to
reason about.

cheers
