Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AEFC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79BA21906
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGVjJDZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79BA21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q6ht5dwHzDqSG
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:27:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IGVjJDZl"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6b00clzzDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:22:51 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id n2so568522pgg.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eoZsO429e0b+dEVgO5JVsEp5EuD0o0GJNOTorofbhd0=;
 b=IGVjJDZlidZsAbiJUsDRZQzrGzGEcQwGdZDVp5GgTF8izs4Vfi6ynWeO+Pdqcyi+/N
 C7/9w3RS5D3LT9p5Bd3/Gms2bf7xmwBF95Tak2vcxsJgUeHVyljIAu5lhZInoKy20Tfi
 tfv10j13D5Fl+eADMH/7ndD940/cTKSs4Btehx3aLQ61iMG7ja8ULyTgmz72zYj0la51
 wiSuVuegknSR+8upONyWx+hfrWEK+XqlYEEpGDN1y5ZrbQiaLJhuG9d6NghjuVP4iO7J
 uTuS6Zm2zpu1Ft9ivA/7L+6EMmHpGo/FiRodlzxadw31ea2yqgUnbbVEeFQemGI7dnYN
 r28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eoZsO429e0b+dEVgO5JVsEp5EuD0o0GJNOTorofbhd0=;
 b=rdEnw36T7Zs4SoRiqxJt3dkGHy+wk43dWVLAcyI00w/y7ZsBq3DZdY+Fn3wvCeKHlV
 v+JBnT6tASyLnh1cOTeUJvedn5f2oZCo/4F+qqCge/qlF8y7yX/U4NbGcMPo4AMQNI1o
 UpZVHrE4IrW/1caD2zRH2txZBJLUTe07uV+vtTNTBmUKKfwAw0bIEajbcTE7lWAhMzGq
 MF7lts882QvkbI8TGYg+B0renaBKQDhqu7XDDxfVa5AO4ch7AMMAlXmjQpWS5ECd6fLe
 xO9oE2HA0TmYeCjDBMz9VK8bKplxiRyy7gUWyTDFuXB9Mr7OCbkhcCMmOYcssvmfJLzL
 dqZw==
X-Gm-Message-State: APjAAAVM+S3ElbVirD4hWnlstKYj5WvaRPQ/Y7Yr3ST6dTxLh0N06Hiy
 OhaZKmEIxzOtN4sKIPTM3gM=
X-Google-Smtp-Source: APXvYqxnpPk8YPTttYq6iD6geRJxmT/PnYrWdlm9nnsCYFTFBiRuuLfHN3ESOhDwzhPiAzWPNf7byQ==
X-Received: by 2002:a65:4302:: with SMTP id j2mr31468636pgq.291.1556126569766; 
 Wed, 24 Apr 2019 10:22:49 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id w190sm2410231pfb.101.2019.04.24.10.22.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 10:22:49 -0700 (PDT)
Date: Thu, 25 Apr 2019 01:22:34 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 21/63] Documentation: ACPI: move cppc_sysfs.txt to
 admin-guide/acpi and convert to reST
Message-ID: <20190424172232.qtzogm6sweaa4gva@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-22-changbin.du@gmail.com>
 <20190424114844.5de4cfa5@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424114844.5de4cfa5@coco.lan>
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

On Wed, Apr 24, 2019 at 11:48:44AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:50 +0800
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
> > -
> 
> 
> > -for each cpu X
> 
> Hmm... removed by mistake?
>
I comfirmed that no content removed.

> > +Some of the CPPC registers are exposed via sysfs under::
> >  
> > ---------------------------------------------------------------------------------
> > +  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> Did you parse this with Sphinx? It doesn't sound a valid ReST construction
> to my eyes, as:
> 
> 1) I've seen some versions of Sphinx to abort with severe errors when 
>    there's no blank line after the horizontal bar markup;
> 
> 2) It will very likely ignore the "::" (I didn't test it myself), as you're
>    not indenting the horizontal bar. End of indentation will mean the end
>    of an (empty) literal block.
> 
> So, I would stick with:
> 
> 
> 	Some of the CPPC registers are exposed via sysfs under:
> 
> 	  /sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 	---------------------------------------------------------------------------------
> 
> 	for each cpu X::
> 
> 
> or:
> 
> 	Some of the CPPC registers are exposed via sysfs under:
> 
> 		/sys/devices/system/cpu/cpuX/acpi_cppc/
> 
> 	for each cpu X
> 
> 	--------------------------------------------------------------------------------
> 
> 	::
> 
> (with is closer to the original author's intent)
> 
> Same applies to the other similar changes on this document.
>
I didn't seen any warning here and the generated html is good. So I think it is
ok.

> >  
> > -$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
> > -/sys/devices/system/cpu/cpu0/acpi_cppc/:
> > -total 0
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
> > --r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
> > +for each cpu X::
> >  
> > ---------------------------------------------------------------------------------
> > +  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
> > +  /sys/devices/system/cpu/cpu0/acpi_cppc/:
> > +  total 0
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
> > +  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
> >  
> >  * highest_perf : Highest performance of this processor (abstract scale).
> > -* nominal_perf : Highest sustained performance of this processor (abstract scale).
> > +* nominal_perf : Highest sustained performance of this processor
> > +  (abstract scale).
> >  * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
> >    power savings (abstract scale).
> >  * lowest_perf : Lowest performance of this processor (abstract scale).
> > @@ -48,22 +51,26 @@ total 0
> >  * feedback_ctrs : Includes both Reference and delivered performance counter.
> >    Reference counter ticks up proportional to processor's reference performance.
> >    Delivered counter ticks up proportional to processor's delivered performance.
> > -* wraparound_time: Minimum time for the feedback counters to wraparound (seconds).
> > +* wraparound_time: Minimum time for the feedback counters to wraparound
> > +  (seconds).
> >  * reference_perf : Performance level at which reference performance counter
> >    accumulates (abstract scale).
> >  
> > ---------------------------------------------------------------------------------
> >  
> > -		Computing Average Delivered Performance
> > +Computing Average Delivered Performance
> > +=======================================
> > +
> > +Below describes the steps to compute the average performance delivered by
> > +taking two different snapshots of feedback counters at time T1 and T2.
> > +
> > +  T1: Read feedback_ctrs as fbc_t1
> > +      Wait or run some workload
> >  
> > -Below describes the steps to compute the average performance delivered by taking
> > -two different snapshots of feedback counters at time T1 and T2.
> > +  T2: Read feedback_ctrs as fbc_t2
> >  
> > -T1: Read feedback_ctrs as fbc_t1
> > -    Wait or run some workload
> > -T2: Read feedback_ctrs as fbc_t2
> > +::
> >  
> > -delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
> > -reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
> > +  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
> > +  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
> >  
> > -delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
> > +  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
> > diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> > index d68e9914c5ff..9049a7b9f065 100644
> > --- a/Documentation/admin-guide/acpi/index.rst
> > +++ b/Documentation/admin-guide/acpi/index.rst
> > @@ -10,3 +10,4 @@ the Linux ACPI support.
> >  
> >     initrd_table_override
> >     dsdt-override
> > +   cppc_sysfs
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
