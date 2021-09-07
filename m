Return-Path: <SRS0=mwa9=N5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4324C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 07:52:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051A461102
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 07:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 051A461102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H3ctr2Lndz2yJj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Sep 2021 17:52:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=ozMVxvWX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535;
 helo=mail-ed1-x535.google.com; envelope-from=andy.shevchenko@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=ozMVxvWX; dkim-atps=neutral
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H3ct62jGYz2xXl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2021 17:51:56 +1000 (AEST)
Received: by mail-ed1-x535.google.com with SMTP id j13so12615399edv.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Sep 2021 00:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6IndFkSb1Yiibw/M5NalmlPTesP6Xh/pdy6tyUvygQ=;
 b=ozMVxvWXxkl+emax0axRFeeClqY5f6Osmvx6CCs0XIDJ/JGdbQJEzfm91mMjywufZd
 C+CrajFMvscOiHNSB41iK4wLGKohKqgOltVdk/DxklufUdrFXAlB2yJNPnEJjlkqmhve
 LMLh98+h4dDbx800by/TLRbT5TbZ9Euo4uYN1+HwtT+K7Z39YDtTzeI8K9X7+m7KDkpB
 L7Nz8Fg9Ummt47zVNXsYyUq6Vw4Fw3AF4GKH/usJPpCT4U2lJaraVynEsZOXq6YgMIyD
 y3wVuTVuMxdhX+vggaow/qu45NiP4VkFziod8KLeEQSKUXtAg+51nxxI6vySErvBo1TB
 qlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6IndFkSb1Yiibw/M5NalmlPTesP6Xh/pdy6tyUvygQ=;
 b=o9eM3uOnqwDQ5VX3hKAfpKLcrk0plmcSPccIPq3YEdM1jDf2mWBKd11ZiuG3HLOj0K
 819zE0hHHAAjBzCLnGBk5Z7f63vMmMhxT9OsHdQPg2o2oTZyILNedBsEpjhP6LS959OY
 f8BZE7/2H42oNrP8/z9uVC5EarohNsnoiIt4q2XOvZhVoNEWgY8M4Pgq4PV2sIREeFe0
 VwtGIwOTNdr0M2/qiaOictLqfk/IJbA6ovko2m0A/Wi/2yJlzxce+PYLbjzUPGXk1/M8
 6MTzyuiJLxXMFdFHujNXoVoTBgjtmQL+genaVBuTYtRb+1wyZze8pWhlBYtT3susuZ4o
 QkuA==
X-Gm-Message-State: AOAM530JeoEog5f7MoKxB+MZKRSa8roFChsrzSYmAbjEn5S8YCVfp80B
 unNHQj6TGZm9H1p9HyOx+S+TLbU4H4wVAK2Z2/8=
X-Google-Smtp-Source: ABdhPJx5tcHR6VKH3/CJ6YHoRXcJmHRud0LMRXdXY2Dt5BBF40tT5b/NYsnb0yaIEzafeGyKlPxhtYtMC2wTSQGfKis=
X-Received: by 2002:a05:6402:959:: with SMTP id
 h25mr17018341edz.283.1631001110739; 
 Tue, 07 Sep 2021 00:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210906094927.524106-4-schnelle@linux.ibm.com>
 <202109070818.aHlo0OT9-lkp@intel.com>
In-Reply-To: <202109070818.aHlo0OT9-lkp@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 7 Sep 2021 10:51:14 +0300
Message-ID: <CAHp75VeiWH0MoAchctDES7zLk4Q9NwODu=O2y-NYOsu3SBeimg@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: Move pci_dev_is/assign_added() to pci.h
To: kernel test robot <lkp@intel.com>
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
Cc: linux-s390@vger.kernel.org, kbuild-all@lists.01.org,
 Pierre Morel <pmorel@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Linas Vepstas <linasvepstas@gmail.com>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 7, 2021 at 3:26 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Niklas,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on s390/features]
> [also build test ERROR on next-20210906]
> [cannot apply to pci/next powerpc/next v5.14]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Niklas-Schnelle/s390-pci-automatic-error-recovery/20210906-175309
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/404ed8c00a612e7ae31c50557c80c6726c464863
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Niklas-Schnelle/s390-pci-automatic-error-recovery/20210906-175309
>         git checkout 404ed8c00a612e7ae31c50557c80c6726c464863
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):

Obviously drivers/pci/pci.h is not only for the above.

When play with headers always do two test builds: allyesconfig and allmodconfig.

-- 
With Best Regards,
Andy Shevchenko
