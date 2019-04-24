Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894AAC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F8B208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRD4pERi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F8B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q5840kkbzDqQc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 02:17:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mRD4pERi"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q55t1MNPzDq9p
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 02:16:01 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id w25so9553731pfi.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=GU2wNV4N+hDEDop+XExIyNq2YBi5nXdd8ZBs3Gv/eds=;
 b=mRD4pERicTy709OjsPSqSrQ1I4qE1NbT/IhfOl/ujCOasJBqnGeAT/QGcmpuBxaSSK
 peZtqScBmg+7JACy6ZA9wZgyRP9an6E2g8tXC1z0eBQjRW3HfZDmmpv0ua6h8xhPjgtD
 H1soKAdWdaDdg1aQnb2jN0wZEO8DdrBWpxayE8jpT283/BmZanevd8Gym5g2lUh91qa5
 uCXH4AYXEu8vUm9xG7R7vQMV3S0I5BO36fVZLgfrBc8G04wC72t/bZTbVBOuczQk3DVU
 FhWCW4dqo4ndGM/oMsGpTU5z/WHVLXqCA1h8ClaFHAZTRrTUZxCL2k+P+5eSw51dWXsW
 zcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GU2wNV4N+hDEDop+XExIyNq2YBi5nXdd8ZBs3Gv/eds=;
 b=feVEcm8WGnKf6Ortty5Z55b3Mybk34XhGBhPm3uo5dICVYK2HB8/z9w1hkUH38i3IS
 Vih11q4QLzSYo7ZZM/6u78NhQZC0ciZXAWyUYUbdUA6+/7kKC/FuHOdzq6IHcN5Ci8yT
 88iCkAW+Xd88lLHSFewSIWl7zUrRlau5QRivhZSlQTnk6Gx0dXPQ1QG1HEOYzrXR+FyC
 NJwpRk5Y528H+3PNc8SrDIKTYjhgI6Wxu+PJ+CIEgmmYsfp10b5Xj9v9vm3p6awNoSSl
 X5HqufPh3L7fo6y/UKY4F9DJsgg35LbeOc5e1yh0yJTclUuqKJ9M9fpjK5ZRo+FhY2hn
 Ynmw==
X-Gm-Message-State: APjAAAXxUj2xEP6V1Qe4iyYvDKedM9PkyuxEmhNMM8Cel3zon1QZDYOC
 GryU6RVGuG7aynL5qblOzLE=
X-Google-Smtp-Source: APXvYqzt4rLHmzLfttBeV0VMlFHGkZKbdi0qNRhFsgJX+MuaBjxfGEs3eeD1hMJMaLhafFcUp8ay7A==
X-Received: by 2002:a62:ed10:: with SMTP id u16mr33905015pfh.187.1556122558246; 
 Wed, 24 Apr 2019 09:15:58 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id q80sm36349267pfa.66.2019.04.24.09.15.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 09:15:57 -0700 (PDT)
Date: Thu, 25 Apr 2019 00:15:47 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 05/63] Documentation: ACPI: move linuxized-acpica.txt
 to driver-api/acpi and convert to  reST
Message-ID: <20190424161546.vkvaicqdmwdouc22@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-6-changbin.du@gmail.com>
 <20190423175030.7d0cc624@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423175030.7d0cc624@coco.lan>
User-Agent: NeoMutt/20180716
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
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 23, 2019 at 05:50:30PM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:34 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/driver-api/acpi/index.rst       |   1 +
> >  .../acpi/linuxized-acpica.rst}                | 115 ++++++++++--------
> >  2 files changed, 66 insertions(+), 50 deletions(-)
> >  rename Documentation/{acpi/linuxized-acpica.txt => driver-api/acpi/linuxized-acpica.rst} (78%)
> > 
> > diff --git a/Documentation/driver-api/acpi/index.rst b/Documentation/driver-api/acpi/index.rst
> > index 898b0c60671a..12649947b19b 100644
> > --- a/Documentation/driver-api/acpi/index.rst
> > +++ b/Documentation/driver-api/acpi/index.rst
> > @@ -5,3 +5,4 @@ ACPI Support
> >  .. toctree::
> >     :maxdepth: 2
> >  
> > +   linuxized-acpica
> > diff --git a/Documentation/acpi/linuxized-acpica.txt b/Documentation/driver-api/acpi/linuxized-acpica.rst
> > similarity index 78%
> > rename from Documentation/acpi/linuxized-acpica.txt
> > rename to Documentation/driver-api/acpi/linuxized-acpica.rst
> > index 3ad7b0dfb083..f8aaea668e41 100644
> > --- a/Documentation/acpi/linuxized-acpica.txt
> > +++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
> > @@ -1,31 +1,35 @@
> > -Linuxized ACPICA - Introduction to ACPICA Release Automation
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> >  
> > -Copyright (C) 2013-2016, Intel Corporation
> > -Author: Lv Zheng <lv.zheng@intel.com>
> > +============================================================
> > +Linuxized ACPICA - Introduction to ACPICA Release Automation
> > +============================================================
> >  
> > +:Copyright: |copy| 2013-2016, Intel Corporation
> >  
> > -Abstract:
> > +:Author: Lv Zheng <lv.zheng@intel.com>
> >  
> > -This document describes the ACPICA project and the relationship between
> > -ACPICA and Linux.  It also describes how ACPICA code in drivers/acpi/acpica,
> > -include/acpi and tools/power/acpi is automatically updated to follow the
> > -upstream.
> > +:Abstract: This document describes the ACPICA project and the relationship
> > +           between ACPICA and Linux.  It also describes how ACPICA code in
> > +           drivers/acpi/acpica, include/acpi and tools/power/acpi is
> > +           automatically updated to follow the upstream.
> >  
> 
> Same comment as on patch 02: I would keep the abstracts as a chapter,
> in order to make them visible at the index, as this may help readers
> to quickly look at the document's contents.
>
ok, done.

> I'm sure other APCI documents also have abstracts. So, please consider
> this comment also for the other docs.
> 
For short description, I'd keep it. For long case, will make it as a chapter.
Thanks.

> Anyway, this is just a suggestion. I'm also fine with the above.
> Either way, for the conversion itself:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> >  
> > -1. ACPICA Project
> > +ACPICA Project
> > +==============
> >  
> > -   The ACPI Component Architecture (ACPICA) project provides an operating
> > -   system (OS)-independent reference implementation of the Advanced
> > -   Configuration and Power Interface Specification (ACPI).  It has been
> > -   adapted by various host OSes.  By directly integrating ACPICA, Linux can
> > -   also benefit from the application experiences of ACPICA from other host
> > -   OSes.
> > +The ACPI Component Architecture (ACPICA) project provides an operating
> > +system (OS)-independent reference implementation of the Advanced
> > +Configuration and Power Interface Specification (ACPI).  It has been
> > +adapted by various host OSes.  By directly integrating ACPICA, Linux can
> > +also benefit from the application experiences of ACPICA from other host
> > +OSes.
> >  
> > -   The homepage of ACPICA project is: www.acpica.org, it is maintained and
> > -   supported by Intel Corporation.
> > +The homepage of ACPICA project is: www.acpica.org, it is maintained and
> > +supported by Intel Corporation.
> >  
> > -   The following figure depicts the Linux ACPI subsystem where the ACPICA
> > -   adaptation is included:
> > +The following figure depicts the Linux ACPI subsystem where the ACPICA
> > +adaptation is included::
> >  
> >        +---------------------------------------------------------+
> >        |                                                         |
> > @@ -71,21 +75,27 @@ upstream.
> >  
> >                   Figure 1. Linux ACPI Software Components
> >  
> > -   NOTE:
> > +.. note::
> >      A. OS Service Layer - Provided by Linux to offer OS dependent
> >         implementation of the predefined ACPICA interfaces (acpi_os_*).
> > +       ::
> > +
> >           include/acpi/acpiosxf.h
> >           drivers/acpi/osl.c
> >           include/acpi/platform
> >           include/asm/acenv.h
> >      B. ACPICA Functionality - Released from ACPICA code base to offer
> >         OS independent implementation of the ACPICA interfaces (acpi_*).
> > +       ::
> > +
> >           drivers/acpi/acpica
> >           include/acpi/ac*.h
> >           tools/power/acpi
> >      C. Linux/ACPI Functionality - Providing Linux specific ACPI
> >         functionality to the other Linux kernel subsystems and user space
> >         programs.
> > +       ::
> > +
> >           drivers/acpi
> >           include/linux/acpi.h
> >           include/linux/acpi*.h
> > @@ -95,24 +105,27 @@ upstream.
> >         ACPI subsystem to offer architecture specific implementation of the
> >         ACPI interfaces.  They are Linux specific components and are out of
> >         the scope of this document.
> > +       ::
> > +
> >           include/asm/acpi.h
> >           include/asm/acpi*.h
> >           arch/*/acpi
> >  
> > -2. ACPICA Release
> > +ACPICA Release
> > +==============
> >  
> > -   The ACPICA project maintains its code base at the following repository URL:
> > -   https://github.com/acpica/acpica.git. As a rule, a release is made every
> > -   month.
> > +The ACPICA project maintains its code base at the following repository URL:
> > +https://github.com/acpica/acpica.git. As a rule, a release is made every
> > +month.
> >  
> > -   As the coding style adopted by the ACPICA project is not acceptable by
> > -   Linux, there is a release process to convert the ACPICA git commits into
> > -   Linux patches.  The patches generated by this process are referred to as
> > -   "linuxized ACPICA patches".  The release process is carried out on a local
> > -   copy the ACPICA git repository.  Each commit in the monthly release is
> > -   converted into a linuxized ACPICA patch.  Together, they form the monthly
> > -   ACPICA release patchset for the Linux ACPI community.  This process is
> > -   illustrated in the following figure:
> > +As the coding style adopted by the ACPICA project is not acceptable by
> > +Linux, there is a release process to convert the ACPICA git commits into
> > +Linux patches.  The patches generated by this process are referred to as
> > +"linuxized ACPICA patches".  The release process is carried out on a local
> > +copy the ACPICA git repository.  Each commit in the monthly release is
> > +converted into a linuxized ACPICA patch.  Together, they form the monthly
> > +ACPICA release patchset for the Linux ACPI community.  This process is
> > +illustrated in the following figure::
> >  
> >      +-----------------------------+
> >      | acpica / master (-) commits |
> > @@ -153,7 +166,7 @@ upstream.
> >  
> >                  Figure 2. ACPICA -> Linux Upstream Process
> >  
> > -   NOTE:
> > +.. note::
> >      A. Linuxize Utilities - Provided by the ACPICA repository, including a
> >         utility located in source/tools/acpisrc folder and a number of
> >         scripts located in generate/linux folder.
> > @@ -170,19 +183,20 @@ upstream.
> >     following kernel configuration options:
> >     CONFIG_ACPI/CONFIG_ACPI_DEBUG/CONFIG_ACPI_DEBUGGER
> >  
> > -3. ACPICA Divergences
> > +ACPICA Divergences
> > +==================
> >  
> > -   Ideally, all of the ACPICA commits should be converted into Linux patches
> > -   automatically without manual modifications, the "linux / master" tree should
> > -   contain the ACPICA code that exactly corresponds to the ACPICA code
> > -   contained in "new linuxized acpica" tree and it should be possible to run
> > -   the release process fully automatically.
> > +Ideally, all of the ACPICA commits should be converted into Linux patches
> > +automatically without manual modifications, the "linux / master" tree should
> > +contain the ACPICA code that exactly corresponds to the ACPICA code
> > +contained in "new linuxized acpica" tree and it should be possible to run
> > +the release process fully automatically.
> >  
> > -   As a matter of fact, however, there are source code differences between
> > -   the ACPICA code in Linux and the upstream ACPICA code, referred to as
> > -   "ACPICA Divergences".
> > +As a matter of fact, however, there are source code differences between
> > +the ACPICA code in Linux and the upstream ACPICA code, referred to as
> > +"ACPICA Divergences".
> >  
> > -   The various sources of ACPICA divergences include:
> > +The various sources of ACPICA divergences include:
> >     1. Legacy divergences - Before the current ACPICA release process was
> >        established, there already had been divergences between Linux and
> >        ACPICA. Over the past several years those divergences have been greatly
> > @@ -213,11 +227,12 @@ upstream.
> >        rebased on the ACPICA side in order to offer better solutions, new ACPICA
> >        divergences are generated.
> >  
> > -4. ACPICA Development
> > +ACPICA Development
> > +==================
> >  
> > -   This paragraph guides Linux developers to use the ACPICA upstream release
> > -   utilities to obtain Linux patches corresponding to upstream ACPICA commits
> > -   before they become available from the ACPICA release process.
> > +This paragraph guides Linux developers to use the ACPICA upstream release
> > +utilities to obtain Linux patches corresponding to upstream ACPICA commits
> > +before they become available from the ACPICA release process.
> >  
> >     1. Cherry-pick an ACPICA commit
> >  
> > @@ -225,7 +240,7 @@ upstream.
> >     you want to cherry pick must be committed into the local repository.
> >  
> >     Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
> > -   from the ACPICA local repository:
> > +   from the ACPICA local repository::
> >  
> >     $ git clone https://github.com/acpica/acpica
> >     $ cd acpica
> > @@ -240,7 +255,7 @@ upstream.
> >     changes that haven't been applied to Linux yet.
> >  
> >     You can generate the ACPICA release series yourself and rebase your code on
> > -   top of the generated ACPICA release patches:
> > +   top of the generated ACPICA release patches::
> >  
> >     $ git clone https://github.com/acpica/acpica
> >     $ cd acpica
> > @@ -254,7 +269,7 @@ upstream.
> >     3. Inspect the current divergences
> >  
> >     If you have local copies of both Linux and upstream ACPICA, you can generate
> > -   a diff file indicating the state of the current divergences:
> > +   a diff file indicating the state of the current divergences::
> >  
> >     # git clone https://github.com/acpica/acpica
> >     # git clone http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
