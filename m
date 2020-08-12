Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF1DC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:33:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D58CF206DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 19:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58CF206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRfxW4QyxzDqd2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 05:33:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BRfv84KyGzDqV8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2020 05:31:00 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 07CJUX3N023473;
 Wed, 12 Aug 2020 14:30:33 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 07CJUWOw023470;
 Wed, 12 Aug 2020 14:30:32 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 12 Aug 2020 14:30:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/uaccess: Use flexible addressing with
 __put_user()/__get_user()
Message-ID: <20200812193032.GU6753@gate.crashing.org>
References: <c2addbd9d76212242d3d8554a2f7ff849fb08b85.1587040754.git.christophe.leroy@c-s.fr>
 <7b916759-1683-b4df-0d4b-b04b3fcd9a02@csgroup.eu>
 <878sg6862r.fsf@mpe.ellerman.id.au> <875zb98i5a.fsf@mpe.ellerman.id.au>
 <8b751738-a9d1-8f55-8f9b-9264c8ac7ed8@csgroup.eu>
 <faa6759a-8188-104b-a9f9-a5ff3b060cfa@csgroup.eu>
 <c827fd9b-984d-ca86-67e9-512ca10d118f@csgroup.eu>
 <0b63e2b8-a134-9a50-2106-8ff110cf9a31@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b63e2b8-a134-9a50-2106-8ff110cf9a31@csgroup.eu>
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Aug 12, 2020 at 02:32:51PM +0200, Christophe Leroy wrote:
> Anyway, it seems that GCC doesn't make much use of the "m<>" and the 
> pre-update form.

GCC does not use update form outside of inner loops much.  Did you
expect anything else?

> Most of the benefit of flexible addressing seems to be 
> achieved with patch 1 ie without the "m<>" constraint and update form.

Yes.


Segher
