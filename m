Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EDC46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 22:25:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04322075D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 22:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NXBbxWZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04322075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h1sG123YzF3Dk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 09:25:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NXBbxWZi";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h1pf1YYlzF3BM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 09:22:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NXBbxWZi"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42h1pd62yNz9s9m; Fri, 26 Oct 2018 09:22:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540506169; bh=o/wRGdigzMnMoEKGxEaIMJjHNaBtyfJM+0imOWM1kX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NXBbxWZiE6KVj85O0P1qp5nsAkuKwaqSc6rQs0tPAqe6OyrYDL/cy235+YhFFJKAK
 FYyCFcSwfsZOgBmtvlsgvGmB0AJXV067/hONwQkelWqYRA1r4uLPwO4uewvvSY0bTt
 6HLQFzqfiHyPbdrHioREoqH9q14QEKJ/DMr257pIkgNw7Ga+LoHTRMDTeAaDte9Gkp
 p8QIZvhe6ubtDQhvFN54kKag4qJFgJP9obztsW/jDP2qm6r16BwbypsIqOf9njKs9J
 /VWbAenDVFnNe1Qwb9bIgdELuxQigZ0BDXzv9OqkH54wZFyQpO+80IUx9HD4aCx77z
 kJik3eQidUIlg==
Date: Fri, 26 Oct 2018 08:08:07 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 3/5] powerpc/pseries: Fix stolen time accounting when
 dtl debugfs is used
Message-ID: <20181025210807.GA23232@blackberry>
References: <cover.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
 <16929569199445cd09d9142505b2349620328b38.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16929569199445cd09d9142505b2349620328b38.1540488386.git.naveen.n.rao@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 26, 2018 at 01:55:44AM +0530, Naveen N. Rao wrote:
> When the dtl debugfs interface is used, we usually set the
> dtl_enable_mask to 0x7 (DTL_LOG_ALL). When this happens, we start seeing
> DTL entries for all preempt reasons, including CEDE. In
> scan_dispatch_log(), we add up the times from all entries and account
> those towards stolen time. However, we should only be accounting stolen
> time when the preemption was due to HDEC at the end of our time slice.

It's always been the case that stolen time when idle has been
accounted as idle time, not stolen time.  That's why we didn't check
for this in the past.

Do you have a test that shows different results (as in reported idle
and stolen times) with this patch compared to without?

Paul.
