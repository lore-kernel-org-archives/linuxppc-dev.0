Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DDCC7112B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:36:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD70205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 09:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD70205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YYH44SJLzF3Ll
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:36:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YY2b1yWPzF3Dj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:25:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YY2Y6K4xz9sBq;
 Mon, 15 Oct 2018 20:25:41 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 06/24] powerpc/mm: properly set PAGE_KERNEL flags in
 ioremap()
In-Reply-To: <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <52bd80b06bae0d854d04501e1e136575b77fa9fa.1539092111.git.christophe.leroy@c-s.fr>
 <87d0sd19vm.fsf@concordia.ellerman.id.au>
 <87a7nh104q.fsf@concordia.ellerman.id.au>
 <20181014115810.Horde.99_1JiRv0nxT_Jq3cbpMhw1@messagerie.si.c-s.fr>
Date: Mon, 15 Oct 2018 20:25:41 +1100
Message-ID: <87zhvfzhm2.fsf@concordia.ellerman.id.au>
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
Cc: Jens Axboe <axboe@kernel.dk>, Scott Wood <oss@buserror.net>,
 linux-fbdev@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Geoff Levand <geoff@infradead.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, linux-block@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LEROY Christophe <christophe.leroy@c-s.fr> writes:
> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Set PAGE_KERNEL directly in the caller and do not rely on a
>>>> hack adding PAGE_KERNEL flags when _PAGE_PRESENT is not set.
>>>>
>>>> As already done for PPC64, use pgprot_cache() helpers instead of
>>>> _PAGE_XXX flags in PPC32 ioremap() derived functions.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>
>>> Something in here is breaking my p5020ds (both 32-bit and 64-bit):
>>
>> Oh duh.
>>
>> That's because I didn't take patch 4.
>>
>> It didn't have any acks, but I guess I'll just merge it rather than
>> breaking things.
>
> Yes indeed. Maybe should I have followed it more carrefully to ensure=20=
=20
> it gets an ack.

That's OK, I should have paid more attention to what it was actually
doing, I thought it was just a cleanup.

cheers
