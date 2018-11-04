Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC159C32789
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 15:59:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9622081B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Nov 2018 15:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vT2uZ8vP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9622081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42p0rB17RnzDrhR
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 02:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="vT2uZ8vP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vT2uZ8vP"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42p0n52zXJzDrTk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Nov 2018 02:57:13 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so6805227wre.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Nov 2018 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cp5wPw+puxPc6NcVg/06fYO6VIahuLw3Ksa0tpfS/IY=;
 b=vT2uZ8vP1HrgkbGIfjQ85cCfnScXSCG1U+8kqIomnPYsDnnSVaRnUHD74hOQm0vy1c
 OH63WlNdQbbMFMlOZKWYyHFz36p7PVX3cSq4pBxQWFXzT5lSA6CH8ktRJLeKy9pLVpRs
 A11Y5CCWje+WajcB4nkLESqSlPCPF/fHbTWvMYaPlxrsGL+7jz/0khT40uGbGPxJ40aI
 NaesJUrUVddV0KAV6IK8+ytqs8jW4mwC6zlP9nlxO5/sFXSa8tC9I4HzJz/rP6XbtfnN
 xqR6BTcun63ykMiLXlPmBVfqWX+zRGha12oEaTbJjDMLAqbT597iWh6Cp40brTxLV5aN
 tYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cp5wPw+puxPc6NcVg/06fYO6VIahuLw3Ksa0tpfS/IY=;
 b=S3rPVu7LfHNlvBlhzmPkwCy7Cp/HjHr4fps/7qTMUWNW0FCq+5ScDGjrvWO+JZKOok
 ZBdOIam4Yg12wVWCGLk7HLto/iw9QkkcJXtLbluBPML17km1U3bhXd5p3seoRv0xV7cJ
 zywEGKKgeUubYBxhZrIg5lIArycRDL3kA4tPQniwwU+izZi9dugBO9sBNld9DBC06o3S
 nQJEDwUHMFyty5KWkLNJzEt5uDoLXSDn8uozZGtKEROij22tRKvg0Wxzid1lwIcvrgqe
 F0UzPYIxCpwxr1ORFA+yv/R963YuA8u55r4WuzFuq/wkwFhPvlLuS8veS/m1dsCfaot/
 w4IA==
X-Gm-Message-State: AGRZ1gLajWNpBYX2XUrGa/HkAcmgpFenTnftbmyYcoK+d07IJMXsps/D
 +HUNStkfJmmkXgtYAo6xVwQ=
X-Google-Smtp-Source: AJdET5fR65bGlGeqG64DSrJwBMy/RwDIcFWvihXy+Y7LexX/8q+Qt8rTUW7PENaD3ldUYuLqsJZVug==
X-Received: by 2002:adf:ee47:: with SMTP id
 w7-v6mr7230424wro.173.1541347030054; 
 Sun, 04 Nov 2018 07:57:10 -0800 (PST)
Received: from debian64.daheim (p5B0D79A7.dip0.t-ipconnect.de. [91.13.121.167])
 by smtp.gmail.com with ESMTPSA id u13-v6sm26557402wrn.11.2018.11.04.07.57.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 04 Nov 2018 07:57:09 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gJKlw-0003ho-EU; Sun, 04 Nov 2018 16:57:08 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ppc4xx: ocm: fix errnous "failed to create file" errors
Date: Sun, 04 Nov 2018 16:57:08 +0100
Message-ID: <1970429.tMWINa5tMm@debian64>
In-Reply-To: <87lg6ddnsz.fsf@concordia.ellerman.id.au>
References: <20181028161702.9300-1-chunkeey@gmail.com>
 <87lg6ddnsz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Markus Elfring <elfring@users.sourceforge.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thursday, November 1, 2018 12:45:00 PM CET Michael Ellerman wrote:
> Hi Christian,
> 
> Christian Lamparter <chunkeey@gmail.com> writes:
> > Previously, the kernel would complain:
> >
> > | debugfs ppc4xx ocm: failed to create file
> >
> > But the "info" file was still created and working. This
> > is because debugfs_create_file() returns a pointer to a
> > struct *dentry on success or -ENODEV when debugfs isn't
> > available. This patch fixes both the debugfs_create_dir()
> > and debugfs_create_file() check, so this will work as
> > expected.
> >
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> >
> > diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
> > index 69d9f60d9fe5..e616c8636303 100644
> > --- a/arch/powerpc/platforms/4xx/ocm.c
> > +++ b/arch/powerpc/platforms/4xx/ocm.c
> > @@ -293,13 +293,14 @@ static int ocm_debugfs_init(void)
> >  {
> >  	struct dentry *junk;
> >  
> > -	junk = debugfs_create_dir("ppc4xx_ocm", 0);
> > -	if (!junk) {
> > +	junk = debugfs_create_dir("ppc4xx_ocm", NULL);
> > +	if (IS_ERR_OR_NULL(junk)) {
> >  		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create dir\n");
> >  		return -1;
> >  	}
> >  
> > -	if (debugfs_create_file("info", 0644, junk, NULL, &ocm_debugfs_fops)) {
> > +	if (IS_ERR_OR_NULL(debugfs_create_file("info", 0644, junk, NULL,
> > +					       &ocm_debugfs_fops))) {
> >  		printk(KERN_ALERT "debugfs ppc4xx ocm: failed to create file\n");
> >  		return -1;
> >  	}
> 
> Typically we would just make the whole function not compile when DEBUG_FS
> is disabled, eg:
> diff --git a/arch/powerpc/platforms/4xx/ocm.c b/arch/powerpc/platforms/4xx/ocm.c
> index f5bbd4563342..c5293a28545c 100644
> --- a/arch/powerpc/platforms/4xx/ocm.c
> +++ b/arch/powerpc/platforms/4xx/ocm.c
> @@ -286,6 +286,7 @@ static const struct file_operations ocm_debugfs_fops = {
>  	.release = single_release,
>  };
>  
> +#ifdef CONFIG_DEBUG_FS
>  static int ocm_debugfs_init(void)
>  {
>  	struct dentry *junk;
> @@ -303,6 +304,9 @@ static int ocm_debugfs_init(void)
>  
>  	return 0;
>  }
> +#else
> +static int ocm_debugfs_init(void) { return 0; }
> +#endif
>  
>  void *ppc4xx_ocm_alloc(phys_addr_t *phys, int size, int align,
>  			int flags, const char *owner)
> 
> 
> I don't really mind, but I think the #ifdef approach is simpler to
> reason about.
> 
> cheers


Thank you. I'll post a v2 right away.


