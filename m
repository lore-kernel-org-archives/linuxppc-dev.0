Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2157C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516282081C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 04:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFHtUbzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Cqp52rNjzDqLV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFHtUbzt";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=kernelfans@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XFHtUbzt"; 
 dkim-atps=neutral
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CqMP50lwzDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 15:09:02 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id f9so8287398eds.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 20:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=iWK5A9z+N7V2vktJP7A8hasIdsR6jnF3G9wxeukcd2s=;
 b=XFHtUbztPn/EPdri/RFwwRnbEWm6pI+znmcnsdnPt9G9r5dHlK4V8jKNqRL8+o1Iob
 NRZI1AQnnFDLrTtasHCmU9FFxuH8UbWC77AZ8oeVoNOflvmkyrvIX4T8ZTgFK5d9SsZx
 1naOWGrxPfuvj0jlKKQXEcdURqT5f5weX5syNf/EIHkpcfuWSTbYTyChk2rPa1k6DvUG
 RNJxxbzpVBSUyRFex75hPV1lF+TFcybyE7YNkuTWRKaiO8Jsmhlstl7nPs7Q2U6DWzgF
 pscd+KQy8uOuloyzNbCaORtpUJyy5uayz+MSjFNjfiXn/EFjczARYsTkYu5or5sF+I0v
 Na3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iWK5A9z+N7V2vktJP7A8hasIdsR6jnF3G9wxeukcd2s=;
 b=Xs7ZKHWCMw7L/77EmW+QY9RBJwWj6NuWoUzrqQkgq8Zy6673BubPh/I7DhrGLoUnnx
 Uj8ICoCjj5EWZ63NMgIuAflIaZP39xPE3TymnXEbkE4ylxw+6R15E2NvPJNDjDex1B8u
 6fEVe6YxBPlkqHMOtQRWcAdp9KlSmQr3cWkGfS0anXWnbwuND3/d5uCNQiRf+OJ5MP09
 AX9q7b6K1BFoX9T0Wjv4cPp5TUbJsBHDLL92oFDza2YpCh/YzQizxk2lTsbXhT+BEh0J
 FgF4JU3EvFWvSRRO2SDS4xiuLi4CLksQalXmAuCaTKfXNFKagkAusjiWjUfcFUSd0pKy
 Bjng==
X-Gm-Message-State: AA+aEWa6QnUgYnAepeYaUGoT9NYokDcqCRcQRi5mT9llu9CY9Yq+P9f0
 lH5ULGpgW/ARxU4n4oooXq/bmg9CQzz6GYaCpB3JFhE=
X-Google-Smtp-Source: AFSGD/UGFB3B8ok5SDJlgLfzvdCq99GM6N14jn8hUl8+KP7sVJYLxiI44BbNOryzfGlZLNYEtBm+CCd1LJMRwdsHhjM=
X-Received: by 2002:a17:906:8301:: with SMTP id
 j1-v6mr8532142ejx.60.1544414937119; 
 Sun, 09 Dec 2018 20:08:57 -0800 (PST)
MIME-Version: 1.0
From: Pingfan Liu <kernelfans@gmail.com>
Date: Mon, 10 Dec 2018 12:08:45 +0800
Message-ID: <CAFgQCTsn-v_OKWi72Fa1z0+8hOrSQr1UtoDGm2Ngrj_1GbscHA@mail.gmail.com>
Subject: Is it worth to fix the crashkernel reserved memory blocks the hotplug
 issue?
To: linuxppc-dev@lists.ozlabs.org, Dave Young <dyoung@redhat.com>, 
 Baoquan He <bhe@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,
I found in powerpc code, it is doable to reserve memory region in
movable zone, such as crashkernel does. But in x86 code, it checks the
hotpluggable attribute of memory, hence if manually specifying a
region in hotpluggable region, it will fail.
The x86 code:
/* 0 means: find the address automatically */
if (crash_base <= 0) {
/*
* Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
* as old kexec-tools loads bzImage below that, unless
* "crashkernel=size[KMG],high" is specified.
*/
crash_base = memblock_find_in_range(CRASH_ALIGN,
   high ? CRASH_ADDR_HIGH_MAX
: CRASH_ADDR_LOW_MAX,
   crash_size, CRASH_ALIGN);
if (!crash_base) {
pr_info("crashkernel reservation failed - No suitable area found.\n");
return;
}

} else {
unsigned long long start;

start = memblock_find_in_range(crash_base,  --> this func will check
the hotpluggable attribute of memory and return failure if the
specifying region intersects with it.
      crash_base + crash_size,
      crash_size, 1 << 20);
if (start != crash_base) {
pr_info("crashkernel reservation failed - memory is in use.\n");
return;
}
}

Thanks,
Pingfan
