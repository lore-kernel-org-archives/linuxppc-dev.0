Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E1C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 10:28:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A942086D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 10:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A942086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hYty0qllzDqSm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 21:28:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hYsM6twbzDq7X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 21:27:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43hYsM695fz9sBQ; Sat, 19 Jan 2019 21:27:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43hYsM4ZLHz9s2P;
 Sat, 19 Jan 2019 21:27:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/4] powerpc/64s: Support shrinking the SLB for debugging
In-Reply-To: <20190119011314.45cb9864@naga>
References: <20190117121328.13395-1-mpe@ellerman.id.au>
 <20190117121328.13395-4-mpe@ellerman.id.au> <20190119011314.45cb9864@naga>
Date: Sat, 19 Jan 2019 21:27:21 +1100
Message-ID: <87won12b92.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Thu, 17 Jan 2019 23:13:28 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> On machines with 1TB segments and a 32-entry SLB it's quite hard to
>> cause sufficient SLB pressure to trigger bugs caused due to badly
>> timed SLB faults.
>>=20
>> We have seen this in the past and a few years ago added the
>> disable_1tb_segments command line option to force the use of 256MB
>> segments. However even this allows some bugs to slip through testing
>> if the SLB entry in question was recently accessed.
>>=20
>> So add a new command line parameter for debugging which shrinks the
>> SLB to the minimum size we can support. Currently that size is 3, two
>> bolted SLBs and 1 for dynamic use. This creates the maximal SLB
>
> Doesn't this violate the power of 2 requirement stated in 2/4?

Yes. Good point. This was originally a hack patch in my tree, back when
SLB_NUM_BOLTED was 3 and before Nick even added the slb_used_bitmap, so
back then it was a power of 2 but it also didn't matter :)

I think I'll rework the slb_full_bitmap patch anyway and remove the
power of 2 requirement, so then this patch will be OK.

Thanks for the review!

cheers
