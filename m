Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E68C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 00:46:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99167208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 00:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHC2cPC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99167208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qJRD6XykzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 10:46:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHC2cPC9"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qJP55SmfzDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 10:44:57 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id ck15so10170939plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZByeP/U/Xsd+bzaA85yvOt7T/npZJcZ57cO9BOcxw9k=;
 b=MHC2cPC9MLaoJAmE0CQN2S97KWBqkPkLXs9f+lzC+8TPecWG2IM3XWlk4gYZd7AaMD
 20TYn191QK9PLMw5yBzhtLf8+6iS2/O0pVoQsRgHp8Gv3kflNQwkNfGQpgaJPoTiRu8c
 FNW52u2xkj2adCr8HGTYq9Q0v7rjOgp9dRdAcDno1UnknHgKYjI1faCRBpBfpQ8Srb9J
 njMYRHV1PqkT1MLU4IsSFYCM0U39NGDM8i6nKuv5Dxs9ZUKp1AkPpOCKq5JF6a0bZzlM
 XnTkPt5GY3LlwDkH16Usygfj4fExjFxgSQbr+8Deb9GM8KqE6wDqdnLNbCa88ymTeLaK
 ECeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZByeP/U/Xsd+bzaA85yvOt7T/npZJcZ57cO9BOcxw9k=;
 b=M7SAkfdSei8Fx89dD1j79Iz4rHaghuNqaWZz3jwZKdXwYP8IU5DJVG11gXm2k16mvY
 XrM4pmIreHXzMr7oiDvOlepJcoa5q1pzZ/YS7Hg4YV/dlGkz9/lXcJdnhAnPdh2pN/eZ
 Ey1WCg2TgG9XHMA12jkKv8kDaCNNd+VVHmWYp+bLtHnYLJVxfSYcNn+/nATmC5vGzupU
 mZtzKuV0FpAIzWMQsFV9fcFIrw6B4AFVSU+f2LT7g7J1Pceaehz6G/0z9wynx51HGKp8
 COpZMBiYjPXTs7y1y2gtaYgd+4ZtOl2+f47BiQECE8M7X2l+7skA97yOpI7DXj8+Zsq3
 +KzQ==
X-Gm-Message-State: APjAAAV+SdcaLZXwPhzItBv7KL5XFr4YdMnCSBrdEuL78bvwQ3WkjMjV
 Qix0TpHvdgUBeozzVrM7FHU=
X-Google-Smtp-Source: APXvYqwiA2jiYqMbnX8meUdO/rblXtj9B6eFO73auf+KnxKT4SbqW+4arNMPnXTszoQF0bAOgYPKww==
X-Received: by 2002:a17:902:b617:: with SMTP id
 b23mr33814911pls.73.1556153093960; 
 Wed, 24 Apr 2019 17:44:53 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id j9sm42583869pfc.43.2019.04.24.17.44.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 17:44:52 -0700 (PDT)
Date: Thu, 25 Apr 2019 00:44:51 +0000
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190425004450.qdajhnzlanufxhx3@mail.google.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
 <20190424175306.25880-21-changbin.du@gmail.com>
 <20190424151236.776d9678@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424151236.776d9678@coco.lan>
User-Agent: NeoMutt/20180716-508-7c9a6d
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
Cc: fenghua.yu@intel.com, Jonathan Corbet <corbet@lwn.net>,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 03:12:36PM -0300, Mauro Carvalho Chehab wrote:
> Em Thu, 25 Apr 2019 01:53:03 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
> >  Documentation/admin-guide/acpi/index.rst      |  1 +
> >  2 files changed, 40 insertions(+), 32 deletions(-)
> >  rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)
> > 
> > diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > similarity index 51%
> > rename from Documentation/acpi/cppc_sysfs.txt
> > rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
> > index f20fb445135d..a4b99afbe331 100644
> > --- a/Documentation/acpi/cppc_sysfs.txt
> > +++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
> > @@ -1,5 +1,11 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> >  
> > -	Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +Collaborative Processor Performance Control (CPPC)
> > +==================================================
> > +
> > +CPPC
> > +====
> >  
> >  CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
> >  performance of a logical processor on a contigious and abstract performance
> > @@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
> >  
> >  http://uefi.org/specifications
> >  
> > -Some of the CPPC registers are exposed via sysfs under:
> > -
> > -/sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 
> > -
> > -for each cpu X
> 
> Yeah, there it is: you're removing those two lines.
>
They are indented, see below diffs. I did remove "-----...." two lines.
> > +Some of the CPPC registers are exposed via sysfs under::
> >  
> > ---------------------------------------------------------------------------------
> > +  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> As per my reply to v4.
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
