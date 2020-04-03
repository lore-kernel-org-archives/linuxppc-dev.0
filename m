Return-Path: <SRS0=ATRk=5T=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8CC43331
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 01:03:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C6120675
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 01:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LiiHwVUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C6120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48thW60T5PzDqxX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 12:02:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=intel.com (client-ip=2a00:1450:4864:20::543;
 helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=LiiHwVUI; dkim-atps=neutral
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48thQc4M6szDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 11:59:04 +1100 (AEDT)
Received: by mail-ed1-x543.google.com with SMTP id w26so7073072edu.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BQQqVVbzAcBVOhSvw4EuxUsJxoKXOFCUVak73SIYWAw=;
 b=LiiHwVUIudIQW4lkFokCYO2kTjTv3HTk/jG+DF4Lu+b1ZWYKETmLRQI1UZRaDqSAgT
 dAofu33P+B/Rn7x7BnCESHpgvkvt0FOet/CKqV0JRoc4o3Eg16l1ZHPh8/ZRb8/axGYn
 wm4yC1KpZ/etMgAsxRBXcxLAVSauNm61v0Cpf/abrt2oDxR5dkv87Dsgq9mYXBU7CndG
 atq7tikbCpESsGHm10Kn4POEAGgh5kZGB/ZgczOoxM8JOdlhsl+4ZHV6cwfPQWN7nhBU
 DbQSPEqTWpDx+rAoqrMT68lIAfl+tjVi1RVFTogH5IUrXl2masLAQQsSxotnRQOShc6M
 ovIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BQQqVVbzAcBVOhSvw4EuxUsJxoKXOFCUVak73SIYWAw=;
 b=TfpStIJMu9w0WbYJn1JQ6OiEnpyuqBXalsDiF7zAEFzd6QhnI+gscjaLmAS8o+CJco
 AQX+I1qnGUiUpRfSoMUCE2bNjaFqEIye+e9Qj1gz/WTWAONo+Kp7AbTAGeKA/9RxB3yr
 GV7RvAS7pMQyx5gRBTJkRnzvp959ODrnL9R2d4OEXsEanyWRbg7WHKWa5EYnIUPqf/Kc
 xu5aqPYmU1HlG3l5rxMLhSK2dyGB562RBOFu3jEFfAU3i3/b5QAL0cDJf1m1zE5g95fE
 0eb+m9WFQrwrWQP7Yens6AHWQT2naOKnWSaeVMCZ3biLd96Uzush8njyXoCI9+gnclV0
 oEfw==
X-Gm-Message-State: AGi0PuZ6nzNjPU6KDKBdoUrT23w7gA0wIK1EhYu4C5c6H9DtjtuK7gt+
 TzIIJvXRlSKjvoRuZ00vOU0q6y3jGd3/A6qR8eXdtg==
X-Google-Smtp-Source: APiQypL0cHlfxDZy3upCWoUKh1OZxIVT/GJBhlQfZAkj46oP9jfLm5k6lN7cCtMjaXB1N7V0H1xb1ZKYeojomT01PWs=
X-Received: by 2002:a50:d847:: with SMTP id v7mr5475185edj.154.1585875540967; 
 Thu, 02 Apr 2020 17:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200331143229.306718-1-vaibhav@linux.ibm.com>
 <20200331143229.306718-2-vaibhav@linux.ibm.com>
 <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
In-Reply-To: <CAPcyv4h5Nu4u-SSSOKtHr14ERGUw97EfH5eZR77ThcnqMqxJLg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 2 Apr 2020 17:58:50 -0700
Message-ID: <CAPcyv4ipo0q-d+N=Bsp1+Mo2QBhT=Q21pGvy20D=Gx95py3tzw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] powerpc/papr_scm: Fetch nvdimm health information
 from PHYP
To: Vaibhav Jain <vaibhav@linux.ibm.com>
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
Cc: Alastair D'Silva <alastair@au1.ibm.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Jeff Moyer <jmoyer@redhat.com>, Oliver O'Halloran <oohall@gmail.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Michael Ellerman <ellerman@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 1, 2020 at 8:08 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> >  * "locked"     : Indicating that nvdimm contents cant be modified
> >                    until next power cycle.
>
> There is the generic NDD_LOCKED flag, can you use that? ...and in
> general I wonder if we should try to unify all the common papr_scm and
> nfit health flags in a generic location. It will already be the case
> the ndctl needs to look somewhere papr specific for this data maybe it
> all should have been generic from the beginning.

The more I think about this more I think this would be a good time to
introduce a common "health/" attribute group under the generic nmemX
sysfs, and then have one flag per-file / attribute. Not only does that
match the recommended sysfs ABI better, but it allows ndctl to
enumerate which flags are supported in addition to their state.

> In any event, can you also add this content to a new
> Documentation/ABI/testing/sysfs-bus-papr? See sysfs-bus-nfit for
> comparison.
