Return-Path: <SRS0=Yz/e=7O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489E3C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 23:58:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F394D2071E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2020 23:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F394D2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bXDY62YczDqQm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 09:58:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mentor.com (client-ip=68.232.141.98; helo=esa2.mentor.iphmx.com;
 envelope-from=joseph_myers@mentor.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codesourcery.com
X-Greylist: delayed 63 seconds by postgrey-1.36 at bilbo;
 Tue, 02 Jun 2020 09:56:26 AEST
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bXBf5lQzzDqNP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 09:56:26 +1000 (AEST)
IronPort-SDR: hxzCBVrTK2vtwKwtqzHlOfYdgcMrsYeEhZwtpgmy955MTCzMj6ZkEOQ/R3jCp9faISxws/j13+
 4WqeOcBaYJAD9r+edoYsO4lVdlJqPbPBVKZjb1VCnxpqnxeSCdNYyFmQIYORcG1URicsM2luqP
 bcYlwHi9/BKyFVvE3Y2JSO54ohANncCPOo7RhB1mB7Eaf0e03WSUsYLQNbDfu2mgtMdfZMM092
 5Bddvjs1W01o8N9TiFdCr1roerbpcuT+jaGYkln91Oj9kjM/ewUQ6rRZ7GUFMtoGimUjiiCAAJ
 zDM=
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; d="scan'208";a="49353005"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 01 Jun 2020 15:55:20 -0800
IronPort-SDR: HUeHxf39ay3j7nX9V3KspxZHlhQ5VVRRnpqoBO4s05smCm4X2WD+eXMdqMvemfNVFYW8/0NHXq
 WWScDTh6BqIftoyCElXgYoqdw6eS92OocDvfXU3brajBmkO6qfzAz5JUuq/mxiECOqjQVdGM27
 v4KY8uHoGvkytHOAWcAO7wIjBT8b1cIQ1g7mBEe4tECASStUKPG2t4IbV61bWJGhfmXjcXuTMC
 EkZOfIsh27y3pmbzts6JHpZa8YsYhYrH9hSz8dUrBBc9GscnihEaNHQ0rV7lmGdkQVewimgtq4
 FV8=
Date: Mon, 1 Jun 2020 23:55:14 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Daniel Kolesa <daniel@octaforge.org>
Subject: Re: ppc64le and 32-bit LE userland compatibility
In-Reply-To: <alpine.DEB.2.21.2006012329420.11121@digraph.polyomino.org.uk>
Message-ID: <alpine.DEB.2.21.2006012351270.11121@digraph.polyomino.org.uk>
References: <2047231.C4sosBPzcN@sheen>
 <alpine.DEB.2.21.2006012119010.11121@digraph.polyomino.org.uk>
 <c821b608-f14f-4a68-bbec-b7b6c1d8bddc@www.fastmail.com>
 <alpine.DEB.2.21.2006012329420.11121@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
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
Cc: libc-alpha@sourceware.org, eery@paperfox.es, musl@lists.openwall.com,
 Will Springer <skirmisher@protonmail.com>,
 Palmer Dabbelt via binutils <binutils@sourceware.org>,
 via libc-dev <libc-dev@lists.llvm.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 1 Jun 2020, Joseph Myers wrote:

> The minimum supported architecture for powerpc64le (POWER8) has VSX.  My 
> understanding was that the suggestion was for 32-bit userspace to run 
> under powerpc64le kernels running on POWER8 or later, meaning that such a 
> 32-bit LE port, and any ABI designed for such a port, can assume VSX is 
> available.  Or does VSX not work, at the hardware level, for 32-bit 
> POWER8?  (In which case you could pick another ABI for binary128 argument 
> passing and return.)

In fact, my understanding is that the ABI for passing binary128 values in 
vector registers is perfectly implementable for processors with just VMX 
(AltiVec) and not VSX.  So if you do want to support binary128 for a new 
ABI for either 32-bit LE or 32-bit or 64-bit BE, you don't need to require 
VSX for that ABI, you just need to change any GCC requirement for VSX for 
binary128 to allow it with VMX when building for your new ABI.

-- 
Joseph S. Myers
joseph@codesourcery.com
