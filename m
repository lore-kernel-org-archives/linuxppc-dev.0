Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE7C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 09:34:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 323BC20868
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 09:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323BC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WjNT0QMDzF3S2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 20:34:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WjLM3Y6fzF3JY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 20:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42WjLM25Qvz9s3l; Fri, 12 Oct 2018 20:32:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42WjLM0GMQz9s2P;
 Fri, 12 Oct 2018 20:32:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4/4] powerpc: Add -Wimplicit-fallthrough to arch CFLAGS
In-Reply-To: <d86b4613-af42-02ab-6a0c-c1ea0e78f601@embeddedor.com>
References: <20181010051308.25422-1-mpe@ellerman.id.au>
 <20181010051308.25422-4-mpe@ellerman.id.au>
 <CAGXu5jJqX6ogFgX1q9czwWtufK_nvzUnfN3Xf-74eOBOpcXWVg@mail.gmail.com>
 <874ldt2uhd.fsf@concordia.ellerman.id.au>
 <d86b4613-af42-02ab-6a0c-c1ea0e78f601@embeddedor.com>
Date: Fri, 12 Oct 2018 20:32:53 +1100
Message-ID: <87woqn1pdm.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Gustavo A. R. Silva" <gustavo@embeddedor.com> writes:

> Hi Michael,
>
> On 10/11/18 2:32 AM, Michael Ellerman wrote:
>
>> It still pops a few errors, including in linux/signal.h & compat.h, so
>> it's somewhat aspirational until we can get those fixed up :)
>> 
>
> I wonder if you have a log containing those warnings that you can
> share with me.

Sure. The kbuild report up thread has some or most of them.

But here's a full list:

Failed 279/290
http://kisskb.ellerman.id.au/kisskb/head/1d59e2c78793d8aea9949ca71323c4583c78f488/
  Failed: powerpc-next/ppc64_defconfig/powerpc-gcc8		(http://kisskb.ellerman.id.au/kisskb/buildresult/13542791/log/)
    /kisskb/src/arch/powerpc/platforms/powermac/feature.c:1477:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/compat.h:495:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/compat.h:496:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/compat.h:494:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
  Failed: powerpc-next/corenet64_smp_defconfig/powerpc-gcc8		(http://kisskb.ellerman.id.au/kisskb/buildresult/13542786/log/)
    /kisskb/src/include/linux/compat.h:494:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/compat.h:495:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
    /kisskb/src/include/linux/compat.h:496:51: error: this statement may fall through [-Werror=implicit-fallthrough=]
  Failed: powerpc-next/ppc64le_defconfig/powerpc-gcc8		(http://kisskb.ellerman.id.au/kisskb/buildresult/13542777/log/)
    /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
  Failed: powerpc-next/powernv_defconfig/powerpc-gcc8		(http://kisskb.ellerman.id.au/kisskb/buildresult/13542776/log/)
    /kisskb/src/include/linux/signal.h:180:22: error: this statement may fall through [-Werror=implicit-fallthrough=]

cheers
