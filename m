Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648EDC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:56:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B7B2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B7B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVKt0xNrzDqQD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:56:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVFg3r4zzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:52:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVFg1bDqz9sPC;
 Wed, 20 Mar 2019 23:52:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: Make some functions static
In-Reply-To: <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
References: <20190312203140.31785-1-malat@debian.org>
 <607b412d-e5a2-5d08-7fb9-53a24e6c76d4@c-s.fr>
 <CA+7wUszPviAFVjyU-=qAJfOpe_NxmimWd2-tc148NLUEc4Oj0w@mail.gmail.com>
Date: Wed, 20 Mar 2019 23:52:53 +1100
Message-ID: <87tvfxyafu.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:
> On Tue, Mar 12, 2019 at 10:14 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>>
>> Le 12/03/2019 =C3=A0 21:31, Mathieu Malaterre a =C3=A9crit :
>> > In commit cb9e4d10c448 ("[POWERPC] Add support for 750CL Holly board")
>> > new functions were added. Since these functions can be made static,
>> > make it so. While doing so, it turns out that holly_power_off and
>> > holly_halt are unused, so remove them.
>>
>> I would have said 'since these functions are only used in this C file,
>> make them static'.
>>
>> I think this could be split in two patches:
>> 1/ Remove unused functions, ie holly_halt() and holly_power_off().
>> 2/ Make the other ones static.
>
> Michael do you want two patches ?

That would be better if it's not too much trouble. A patch with a title
of "Make some functions static" shouldn't really be deleting functions
entirely.

cheers
