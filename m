Return-Path: <SRS0=4hcN=S7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D298BC43219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2019 16:52:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEAA2087B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2019 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEAA2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44t9gp4gdXzDqTL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Apr 2019 02:52:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=metux.net
 (client-ip=217.72.192.74; helo=mout.kundenserver.de;
 envelope-from=lkml@metux.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=metux.net
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44t9fC3qClzDqLB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2019 02:51:13 +1000 (AEST)
Received: from [192.168.1.110] ([77.9.18.117]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsDe-1hTuvS0cZE-008vUo; Mon, 29 Apr 2019 18:50:26 +0200
Subject: Re: serial drivers polishing
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 linux-kernel@vger.kernel.org
References: <1556369542-13247-1-git-send-email-info@metux.net>
 <7471c418-4058-db7b-b2ed-af9a67fff201@c-s.fr>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <5a826a97-4098-7e1e-4f07-5a1a372e66b8@metux.net>
Date: Mon, 29 Apr 2019 18:50:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7471c418-4058-db7b-b2ed-af9a67fff201@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4Az+bKXfpphMCirSkhKFORck7bJVPT2vr0hUbYV1dZ3UTKG5BDU
 TBxxFim3uD9wy42V2JkDIAjQaQq2ReWyoUc1DN0rdiVQkVig/vB99Cx7w1EEfOAYNzuwxhb
 f4/BRWBebII5HZVGg0UvowwXDI1h5ABVpWiuWuh4eTYZtMAEQD4sc1EXMWP3gmaFheqF9bP
 k5GRKc1Y11dojpA/k5Txg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dCFArW9i7V0=:h4nMfqswc3y5+ZupbaXaxc
 tFoKtwMnvQVs0UwzjVcogEfzKBl3arCAwUg+Qu2VWAk2Ilq7u2sNI5O1aMJ6CAJkqNHu2uTPX
 Y3yx3fYjWCtcDy9l6OLkwaa69ZvQvWGQCJp3Ou9S8dkvnJ6UmLCcPgM531kn8G+8Il5uw4Qq4
 fSneffuJsYTee2KWv7CFrjm6vlXv5wrAldDuvE1Khsd6M+A8SZ+jCROvLUS+UdQlH5E+u2nm0
 EvQpAmgUmrj0a5vj/qvnfze1O4+gwOONXa+ocsMc2OKjF5rvp3e+m6YVagAVH+9ogDyKxzBSF
 B4Dr7HSCDnjQD6Mno9OfSajn4UzlVCI24/oGwljbOtIR9C4iKsIrWouZp+d/KBBemRUtjbLGl
 JTv2aGZ8xzgbybG4zdtIBrxnTZ+pRhY7K6AjrqZupXlLsuu5g6xlz6e5BUJQC8D03+qT50g2G
 Bt4JGNeR8100ay+aT7Cn/oKa4OtJqHS8if5wsK1bT10QXwQLOrjjacfC+a6NLdIw8N/1nfAw8
 MiA+uGAceRZskTXQwiQ4Fk5YGHD1WsB3tYZQ00f4eBEpSHSbdIZA3h9rSuna888oPBs9mmvVl
 dxWjwGYboM6MpHRT3CrdtGYHP+aeLUDykmNkW1ZrYfNAUuJV5vyfs1Nn/1C54xLYS3mUKyTHa
 el3kZJNkFRqAGhafsnVMEKWsIZ0GCa6lEfp1Xq1UEieK+Q33XlNGAf6xe1G91Hlz/ziLEXu8L
 nQiV+8UmVcbDgxrr/wHIsn9iAsSE0sxMoLbGDcyYyZ+/IRqAPRWFc7zzB4E=
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
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, macro@linux-mips.org,
 andrew@aj.id.au, gregkh@linuxfoundation.org, slemieux.tyco@gmail.com,
 liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com,
 linux@prisktech.co.nz, matthias.bgg@gmail.com, khilman@baylibre.com,
 linux-serial@vger.kernel.org, sudeep.holla@arm.com, sparclinux@vger.kernel.org,
 jacmet@sunsite.dk, linux-amlogic@lists.infradead.org,
 andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 29.04.19 18:16, Christophe Leroy wrote:

Hi,

> Got the following build  error while compiling for my powerpc board with
> your full series applied. No time to investigate though.

thanks, fixed it. That was the unclean patch where i've forgotten to
add 'rfc' into the title ... turned out that this one needs some
more rework :o

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
