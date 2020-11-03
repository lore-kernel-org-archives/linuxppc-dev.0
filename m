Return-Path: <SRS0=iSul=EJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EA7C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 19:09:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8411420786
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 19:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8411420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=depni.sinp.msu.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQfVQ54jvzDqf4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 06:09:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=depni.sinp.msu.ru (client-ip=213.131.7.21;
 helo=depni-mx.sinp.msu.ru; envelope-from=belyshev@depni.sinp.msu.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=depni.sinp.msu.ru
X-Greylist: delayed 584 seconds by postgrey-1.36 at bilbo;
 Wed, 04 Nov 2020 06:08:08 AEDT
Received: from depni-mx.sinp.msu.ru (depni-mx.sinp.msu.ru [213.131.7.21])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CQfSS0x7yzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2020 06:08:08 +1100 (AEDT)
Received: from spider (unknown [176.192.246.239])
 by depni-mx.sinp.msu.ru (Postfix) with ESMTPSA id 4CE1F1BF450;
 Tue,  3 Nov 2020 21:58:22 +0300 (MSK)
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Setup the early hash table at all time.
References: <b8f8101c368b8a6451844a58d7bd7d83c14cf2aa.1601566529.git.christophe.leroy@csgroup.eu>
 <87wnz8vizm.fsf@igel.home> <87y2jouw8k.fsf@mpe.ellerman.id.au>
 <87v9esaxlv.fsf@igel.home>
 <20201030140047.Horde.TJJqKGzG9vSGbMRNIj-MPg7@messagerie.c-s.fr>
 <87pn4zc0zl.fsf@igel.home>
 <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu>
Date: Tue, 03 Nov 2020 21:58:17 +0300
In-Reply-To: <1f8494cd-36db-e3a2-8ea4-28fb976468e7@csgroup.eu> (Christophe
 Leroy's message of "Tue, 3 Nov 2020 08:41:38 +0100")
Message-ID: <875z6mmfna.fsf@depni.sinp.msu.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> Would you mind checking that with that patch reverted, you are able to
> boot a kernel built with CONFIG_KASAN ?

I can reproduce the same problem on a powerbook G4, and no,
CONFIG_KASAN=y kernel with that patch reverted also does not boot with
the same symptom: white screen at the bootloader right after "Booting Linux
via __start() @ 0x0140000 ..."
