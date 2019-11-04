Return-Path: <SRS0=P9+W=Y4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B721CA9EB5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 10:31:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7045A222C2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 10:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SF7ijRpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7045A222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4768HB2QfGzF325
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 21:31:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=asteinhauser@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="SF7ijRpz"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4768DD2VPfzF4sK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2019 21:29:10 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id q28so11841609lfa.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Nov 2019 02:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d642xmgkuaRAmIFZSmvoisrIorNgI4itdqBbyRZ971w=;
 b=SF7ijRpzeaauiPgy1JeAP0YOPsWk4MKuO8oKW3fd5LbvZ8UOV0vhMP7GjbCpwQB2Wj
 U0pIBkSS8IUUUUIuWlvTsFbUQJVl0Tz4zu++EEUxT9u4peaRvGcEUargqxMJLQ0G0Efs
 ogoBV3N3HPafJ3jqBZs0+e+4lBx5yIynAlcnBjMbnGAoEPUBO5zkE7pzh9RhTDoGdfPX
 Nwnn9455AiK6JlHDwJIn9yQ07b0+7QHKeA3w+ShgI5SkHB99/3tqfXd1r/sW/WhWg6eS
 Zyf3dbh9/VYg3TplbERlS9IDOQTpcOnyBGkA9dcf7caN/pBDmWAoDWdgDkhVCZkb0SoW
 d9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d642xmgkuaRAmIFZSmvoisrIorNgI4itdqBbyRZ971w=;
 b=lCunqE2C4JBoTcofoAKLOb4Ux6pjBX04YouTU7Z40lyMcG10lYtrDeC3TyjTV6yCyb
 rMoaE3phIKJLny7Ua31R1Z5yqDwxpjKJZ8L0iTb5Lq8YzFpd6fdApedhX/ATgP0paqB+
 hulmJMmLIvkBkQRZdmb8IKBy8MzyX1wJt7euIdESThoNrsrp5f5xGHfg5rKMeVlU/d8K
 xas0NDUdm5sHeNDn62jJq/hOd490VtZEn3utkYJFx+Cyq2B2gKRYprAeZUfuClIKuLUD
 cOlCHNlEC/L8kP21c+ODQ03/iEJpeeDcNyW4qr/25yspOLAHMAVQAKMiletvP7Rn8nK9
 i18A==
X-Gm-Message-State: APjAAAUDTCRZWWbsDZFNShMKOhcurdXr1wjCsZY9dQDU/Ac3xtUrvO/L
 6xlSi4l2trTVmkdBw0MAPtT6irMgu+6AyT0NdCHI
X-Google-Smtp-Source: APXvYqzBJzZEWaIZ411jabW2HYG6NdUSqRRzw1w5eo9PWiiQY5WwQis24z2NVZJF2LBpdSlZ9nPkm2GgrXe/QEKxJNM=
X-Received: by 2002:a19:ec02:: with SMTP id b2mr13177571lfa.121.1572863345119; 
 Mon, 04 Nov 2019 02:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20191029190759.84821-1-asteinhauser@google.com>
 <87zhhe1qjy.fsf@mpe.ellerman.id.au>
In-Reply-To: <87zhhe1qjy.fsf@mpe.ellerman.id.au>
From: Anthony Steinhauser <asteinhauser@google.com>
Date: Mon, 4 Nov 2019 11:28:55 +0100
Message-ID: <CAN_oZf348sQqRJhOHKUeOXEc26fO6Ksh1-7CDowjCNYQHmSX1Q@mail.gmail.com>
Subject: Re: [PATCH] L1TF support in PowerPC SYSFS.
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: diana.craciun@nxp.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

I tested in on Power9 Talos II Boston 004e 1202, PowerNV T2P9D01.
Links can be naturally dropped. They're just for explanation.

Best,


On Sat, Nov 2, 2019 at 12:11 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Hi Anthony,
>
> Thanks for the patch.
>
> asteinhauser@google.com writes:
> > From: Anthony Steinhauser <asteinhauser@google.com>
> >
> > PowerPC CPUs are vulnerable to L1TF to the same extent as to Meltdown.
> > It is also mitigated by flushing the L1D on privilege transition.
> > Currently the SYSFS gives a false negative on L1TF on CPUs that I verified
> > to be vulnerable.
>
> Can you include the details of which CPUs you tested?
>
> > https://www.ibm.com/blogs/psirt/potential-impact-processors-power-family/
> > https://github.com/google/safeside/pull/52
> > Signed-off-by: Anthony Steinhauser <asteinhauser@google.com>
> > ---
>
> I don't usually retain links in the change log, because they bit rot, so
> I'll drop those, but they will remain in the email archive.
>
> > diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> > index 7cfcb294b11c..a1a5017c5170 100644
> > --- a/arch/powerpc/kernel/security.c
> > +++ b/arch/powerpc/kernel/security.c
> > @@ -135,7 +135,8 @@ void setup_spectre_v2(void)
> >  #endif /* CONFIG_PPC_FSL_BOOK3E */
> >
> >  #ifdef CONFIG_PPC_BOOK3S_64
> > -ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
> > +static ssize_t cpu_show_delayed_fault_common(
>
> I guess that's an accurate name.
>
> I probably would have just had cpu_show_l1tf() call cpu_show_meltdown(),
> but I guess either approach is fine.
>
> cheers
>
>
> > @@ -167,6 +168,16 @@ ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, cha
> >
> >       return sprintf(buf, "Vulnerable\n");
> >  }
> > +
> > +ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     return cpu_show_delayed_fault_common(dev, attr, buf);
> > +}
> > +
> > +ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     return cpu_show_delayed_fault_common(dev, attr, buf);
> > +}
> >  #endif
> >
> >  ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, char *buf)
> > --
> > 2.24.0.rc0.303.g954a862665-goog
