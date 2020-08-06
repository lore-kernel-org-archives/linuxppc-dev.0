Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C25C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:34:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A804222E00
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8KATEOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A804222E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMnwk4d9RzDqn1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 22:33:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=acme@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=G8KATEOt; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMndl20BRzDqlB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 22:20:59 +1000 (AEST)
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60F6122D03;
 Thu,  6 Aug 2020 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596716455;
 bh=BNTPnjp8uCLBloIL6H7X+Nr6ROKedHB8cPRuja71qEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G8KATEOtPaitqZWGuUsl2fHoO8xBt3tgvMmFiZgtVh5NzuE7ZrqefXIN9OPVRt/DL
 QJFQkHXggwdIvlal4KR/kXOaKujQK1iyb7qTQFZi9LjBApdNYA/doU0HYqQZ3N7r9b
 X4QqGAzCEs05K0v3PxSDYwzFkW34bzPMQ3DcjiUQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
 id 1467B40524; Thu,  6 Aug 2020 09:20:53 -0300 (-03)
Date: Thu, 6 Aug 2020 09:20:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V5 0/4] powerpc/perf: Add support for perf extended regs
 in powerpc
Message-ID: <20200806122052.GC71359@kernel.org>
References: <1595870184-1460-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <27D1CE26-A506-4CFF-B1C2-E0545F26E637@linux.vnet.ibm.com>
 <20200730195048.GA1484375@krava>
 <CA3D75F3-5F63-425B-A3C1-00C181E41108@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA3D75F3-5F63-425B-A3C1-00C181E41108@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>, maddy@linux.vnet.ibm.com,
 kjain@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Fri, Jul 31, 2020 at 11:04:14PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 31-Jul-2020, at 1:20 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Thu, Jul 30, 2020 at 01:24:40PM +0530, Athira Rajeev wrote:
> >> 
> >> 
> >>> On 27-Jul-2020, at 10:46 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> >>> 
> >>> Patch set to add support for perf extended register capability in
> >>> powerpc. The capability flag PERF_PMU_CAP_EXTENDED_REGS, is used to
> >>> indicate the PMU which support extended registers. The generic code
> >>> define the mask of extended registers as 0 for non supported architectures.
> >>> 
> >>> Patches 1 and 2 are the kernel side changes needed to include
> >>> base support for extended regs in powerpc and in power10.
> >>> Patches 3 and 4 are the perf tools side changes needed to support the
> >>> extended registers.
> >>> 
> >> 
> >> Hi Arnaldo, Jiri
> >> 
> >> please let me know if you have any comments/suggestions on this patch series to add support for perf extended regs.
> > 
> > hi,
> > can't really tell for powerpc, but in general
> > perf tool changes look ok
> > 
> 
> Hi Jiri,
> Thanks for checking the patchset.

So I'dd say you submit a v6, split into the kernel part, that probably
should go via the PPC arch tree, and I can pick the tooling part, ok?

- Arnaldo
