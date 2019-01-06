Return-Path: <SRS0=3mqf=PO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C5C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jan 2019 23:37:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33652070C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jan 2019 23:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33652070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Xw0x1QzczDqG0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 10:37:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43XvzF6T8DzDqDf
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 10:35:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43XvzD45bCz9s7h;
 Mon,  7 Jan 2019 10:35:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Date: Mon, 07 Jan 2019 10:36:10 +1100
Message-ID: <8736q5xst1.fsf@concordia.ellerman.id.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
>> +static ssize_t ppc_nvram_get_size(void)
>> +{
>> +       if (ppc_md.nvram_size)
>> +               return ppc_md.nvram_size();
>> +       return -ENODEV;
>> +}
>
>> +const struct nvram_ops arch_nvram_ops = {
>> +       .read           = ppc_nvram_read,
>> +       .write          = ppc_nvram_write,
>> +       .get_size       = ppc_nvram_get_size,
>> +       .sync           = ppc_nvram_sync,
>> +};
>
> Coming back to this after my comment on the m68k side, I notice that
> there is now a double indirection through function pointers. Have you
> considered completely removing the operations from ppc_md instead
> by having multiple copies of nvram_ops?
>
> With the current method, it does seem odd to have a single
> per-architecture instance of the exported structure containing
> function pointers. This doesn't give us the flexibility of having
> multiple copies in the kernel the way that ppc_md does, but it adds
> overhead compared to simply exporting the functions directly.

Yeah TBH I'm not convinced the arch ops is the best solution.

Why can't each arch just implement the required ops functions? On ppc
we'd still use ppc_md but that would be a ppc detail.

Optional ops are fairly easy to support by providing a default
implementation, eg. instead of:

+	if (arch_nvram_ops.get_size == NULL)
+		return -ENODEV;
+
+	nvram_size = arch_nvram_ops.get_size();
+	if (nvram_size < 0)
+		return nvram_size;


We do in some header:

#ifndef arch_nvram_get_size
static inline int arch_nvram_get_size(void)
{
	return -ENODEV;
}
#endif

And then:

	nvram_size = arch_nvram_get_size();
	if (nvram_size < 0)
		return nvram_size;


But I haven't digested the whole series so maybe I'm missing something?

cheers
