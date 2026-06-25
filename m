Return-Path: <linuxppc-dev+bounces-22991-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5439CDB479
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:42:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmNNs28SSz2y8p;
	Fri, 26 Jun 2026 01:42:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782402173;
	cv=none; b=JueEcUbTBX7riywUh3F31R5qFYgqvQTUbGFWgbd4ec7dEZ/M0vFIbqx2a76uREwAfo0pDwIthlgQ+gN/shdEMQQZI96mEbQlvzJZAgV6nNbExP5i81zma6gsO0UQyFyKynP5hBM/LkvJ71NY7rFCbb+jXTZdKn0D57ZZ59QLqDsvz88SpLnlPEFBkdPJXRG0lujrg5/solnCzbQdkuARoKmtbVWUxAVrw8cohHrviwmXXYrxSmdINurp5W/Gxph1tRIvYT0w6iEi5+YSXFSYk6jLvAAqO2+plOSOCamauV1W8A8XpmZon6hZeayCCM9XS3iK1gZDjXv5kdKBbxWtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782402173; c=relaxed/relaxed;
	bh=gB23+sd00tzG2OsfIn9GO4d0OXAtSMMUBTk/3RoFTHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4HY+TZBYbb1eAxnb47VGJBnJ6Whdub5uvWsk9A7bUiTZfK5KrcZxSa93iczow1Vg5ngqltNOAryl+NcaOGHp+s+3X+fKh4ZbYrgOHW4Olk++yH8quARiycYxu/6+qdMcryOe6rwmRCDG7iL0XuEz3aPUBidf7fj/74VGfCKl3ju45VFlbo6mH/9YYb4oROLQP3p4N8htiRsdfLxg9OpkeIymsHGe89xiHGpl4izoUY88plGzKnLNP3mCFeNgKq9fmEWykrMfn4bupPNJ26NV0K0fH+AQ1vXFukbmbNY0/xyAX/35SGkC4bPJqcNJUOTkRbEoxL2MtgAWd9MeYQhXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Zyxi5RRG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Zyxi5RRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=pmladek@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmNNq6mnvz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 01:42:51 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-4624c1409c9so2017538f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 08:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782402168; x=1783006968; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gB23+sd00tzG2OsfIn9GO4d0OXAtSMMUBTk/3RoFTHA=;
        b=Zyxi5RRG2306ESkwpEbSDUNr5pAq1ibwbCyAQnJKkACBMhplAo3oMhILTk+V3zCTVr
         zNtXoUT9OBVrMeWLFXuqDFMwfnX9PK/RNctAve9PBgw8k2eb17f3lWWbOIJLge2sasfR
         oN/rz0TI4mcaLW1mlRci1QSO+dm4B0577oFqw9bHJ7SagXBUAeDKkWv/WZKKHniFsaAG
         scWeZX8JkijI8bucSkne+2z+ZdHw8soiSOVRhmIHvwV20Wl2BauW8JcsqoaYMAmLvDGv
         tkqVtKhgBjJW4XSxGBQzH6OLnI5HhlM8TBVX1F203O8aTh8OJmAoQwZ3cgycV0cvug8d
         jvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402168; x=1783006968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB23+sd00tzG2OsfIn9GO4d0OXAtSMMUBTk/3RoFTHA=;
        b=X64InTfHAO7WRhZr+ZP+cPhkNEKiQWdphfJv2Pr5LWs0nCxi0Odx4sOhwCo/jRF1PW
         KUbDRsDKxCGM44q362EQdgy8AjwMNWSPgyUYPOpPIIOnjrdrOuntgKoNAg/LNSH9MPws
         ZDsV2yPmvSJn0CkWpWkYkEpbRDk0Nru4oXG+1vSFUaEPdynuTowtfU/EYWVSOixGYnhK
         m2GyMNo3SYRAHxtuhSuHlLBCstq9kpr1/ePzm2v+ihEsi8wrfB+iDqqeRSHuGxMR8G7f
         kTdnh5xr59hKAYZGrT1Dpu6O7DiopVsO8qB7k1skoJG9Rz00Ok/P/S79G41Ii1MYbzQA
         NkWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnsuEhwjQOUFAcaDCA4WZ6+yZurU4Mbglj0m/x0vrMY1YPcZ0ZzSXYInx8sGYC38yKjq/3zuk48pPy+RE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOoBqAPODLxY2Tlc0o3AfsHHpBw4r1YMJZRiCFeuFdqqLSIgwI
	0VCHl7+BQW0JRqZuF+QOu4YHHzTU4QCbZlQjbdfBLJRccCine2fhxrF+9CrZAHVEbOc=
X-Gm-Gg: AfdE7ckuu99wdiCTIlocD8sk/7O5IsR35vmCVT41CQ6bmw/8PR7vicDiasLsjImxhbp
	dIfA7KHjJVVf1iBMRNXR4wIEbG6SchnLaqyJulXsx7MN0RlNba6MtBc+Qja7eKUvFxls1vzUes5
	+hiIbfQqfKwCb6hNXIhOlZ3+QRUPh7TBv2uVSPy7Pl9nPMr6OYkB7Z60mfkGajEAzfyKs0XF9Zu
	fXGFgp1wO/10znze3fYoM94W3Zs0s/WBmUqvs7aTFqgJzKQW9ywbW+L0syIRhwCjbVLs7Q+IJ85
	BnRRdu/tLAQGscvSnKf4fDfbs/zlxn2KkxJAO2vhQC+nfVDeAzqt5jKFQYm1rbd3Bht6m6IBrX2
	Y9GiM/lR0v0yuylohchXKI+QV8K2aGJFwr8r/gxfWeGLqiQrO4gCoHbndlMXy0Guyt3MR8nj55D
	dDopv6225LI3bp0nw=
X-Received: by 2002:a05:6000:708:b0:45e:edc8:d440 with SMTP id ffacd0b85a97d-46dbec3fc5amr5453031f8f.1.1782402168242;
        Thu, 25 Jun 2026 08:42:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46de7effe5bsm5033765f8f.5.2026.06.25.08.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:42:47 -0700 (PDT)
Date: Thu, 25 Jun 2026 17:42:44 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bradley Morgan <include@grrlz.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Kees Cook <kees@kernel.org>, Rio <rioo.tsukatsukii@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Pnina Feder <pnina.feder@mobileye.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Mayank Rungta <mrungta@google.com>, Tejun Heo <tj@kernel.org>,
	Zhenguo Yao <yaozhenguo1@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper
 for callers that handle all_bt
Message-ID: <aj1MdKcXP3uIW7AX@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
 <20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
 <aj1Jh57McGH94gGY@pathway.suse.cz>
 <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EEB33A51-758A-4A67-8AC5-7200B53F8C1D@grrlz.net>

On Thu 2026-06-25 16:31:47, Bradley Morgan wrote:
> On June 25, 2026 4:30:15 PM GMT+01:00, Petr Mladek <pmladek@suse.com>
> wrote:
> >On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> >> On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net>
> >wrote:
> >> 
> >> > Some callers handle SYS_INFO_ALL_BT themselves before calling
> >sys_info().
> >> > Add a helper that strips that bit without turning an all_bt only mask
> >into
> >> > a kernel_sys_info fallback.
> >> 
> >> I assume this patch wants a Fixes: and a cc:stable also.
> >> 
> >> It would be nice to have the conventional [0/N] cover letter to tell
> >> readers what this is all about.
> >> 
> >> The patches all have different Fixes: targets.  This risks inviting the
> >> -stable maintainers to merge only some of the patches into some
> >> kernels, resulting in an untested combination and which might break
> >> things.
> >
> >I do not agree here. The Fixes tag should should point to a commit
> >which introduced the regression into the given code. And finding
> >some magic common point beause there is some magic undocumented
> >process for maintaining stable kernels sounds like a way to hell
> >to me.
> >
> >Best Regards,
> >Petr
> 
> 
> oh no.
> I added the generic tag to V4, no worries, it is the earliest possible
> fixes tag. But I really don't wanna be doing a V5 just to revert my
> fixes tags.

This is the risk when sending 4 versions of a fix within 5 days.
A good practice is to wait at least one week before sending another
version. It gives people chance to react and helps the discussion
to settle.

That said, I am not going to block this because of the fixes tags.
But I suggest to wait longer next time.

Best Regards,
Petr

