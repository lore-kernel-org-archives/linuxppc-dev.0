Return-Path: <SRS0=GP0G=II=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F64C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 16:20:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95B464F48
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Mar 2021 16:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95B464F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DwckP0nHQz3cVH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 03:20:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Dwck20Zqbz30Mh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Mar 2021 03:20:09 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12AGHuCa032468;
 Wed, 10 Mar 2021 10:17:57 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 12AGHsaD032459;
 Wed, 10 Mar 2021 10:17:54 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 10 Mar 2021 10:17:54 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: PowerPC64 future proof kernel toc, revised for lld
Message-ID: <20210310161754.GK29191@gate.crashing.org>
References: <20210309045638.GI6042@bubble.grove.modra.org>
 <20210310034813.GM6042@bubble.grove.modra.org>
 <3c92968f-7c61-8d36-4001-91f8630de4b1@linux.ibm.com>
 <20210310050722.GN6042@bubble.grove.modra.org>
 <5aa60950-d93c-f700-3b0b-a01f947e8a22@linux.ibm.com>
 <20210310122513.GB29645@bubble.grove.modra.org>
 <df863fb6-2fd6-00d7-b6f3-94a49c2a5405@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df863fb6-2fd6-00d7-b6f3-94a49c2a5405@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: alexey@au1.ibm.com, Alexey Kardashevskiy <aik@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, ellerman@au1.ibm.com,
 Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 10, 2021 at 01:44:57PM +0100, Christophe Leroy wrote:
> 
> 
> Le 10/03/2021 à 13:25, Alan Modra a écrit :
> >On Wed, Mar 10, 2021 at 08:33:37PM +1100, Alexey Kardashevskiy wrote:
> >>One more question - the older version had a construct "DEFINED (.TOC.) ?
> >>.TOC. : ..." in case .TOC. is not defined (too old ld? too old gcc?) but 
> >>the
> >>newer patch seems assuming it is always defined, when was it added? I have
> >>the same check in SLOF, for example, do I still need it?
> >
> >.TOC. symbol support was first added 2012-11-06, so you need
> >binutils-2.24 or later to use .TOC. as a symbol.
> >
> 
> As of today, minimum requirement to build kernel is binutils 2.23, see 
> https://www.kernel.org/doc/html/latest/process/changes.html#current-minimal-requirements

The minimum GCC version required is 4.9, released April 2014, so it
would make sense to require binutils 2.24 at least as well: that was the
last binutils release before the GCC 4.9 release (it was end of 2013).

Generally you should make sure to always have a binutils at least as new
as your GCC (and newer almost always works just fine).


Segher
