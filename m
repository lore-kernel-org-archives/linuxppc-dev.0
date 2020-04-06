Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B454C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:28:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E832723131
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E832723131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wrvW0DBwzDrBp
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:28:07 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wrPf2KqLzDr6L
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 23:05:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48wrPY1TZKz9sSW; Mon,  6 Apr 2020 23:05:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9e62ccec3ba0a17c8050ea78500dfdd0e4c5c0cc
In-Reply-To: <dd4575c51e31766e87f7e7fa121d099ab78d3290.1584699455.git.msuchanek@suse.de>
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v12 1/8] powerpc: Add back __ARCH_WANT_SYS_LLSEEK macro
Message-Id: <48wrPY1TZKz9sSW@ozlabs.org>
Date: Mon,  6 Apr 2020 23:05:36 +1000 (AEST)
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
Cc: Mark Rutland <mark.rutland@arm.com>, ,
	Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jordan Niethe <jniethe5@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>,
	Rob Herring <robh@kernel.org>, Michael Neuling <mikey@neuling.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nayna Jain <nayna@linux.ibm.com>, el.com@lists.ozlabs.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Valentin Schneider <valentin.schneider@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.int>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Allison Randal <allison@lohutok.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	Eric Richter <erichte@linux.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-03-20 at 10:20:12 UTC, Michal Suchanek wrote:
> This partially reverts commit caf6f9c8a326 ("asm-generic: Remove
> unneeded __ARCH_WANT_SYS_LLSEEK macro")
> 
> When CONFIG_COMPAT is disabled on ppc64 the kernel does not build.
> 
> There is resistance to both removing the llseek syscall from the 64bit
> syscall tables and building the llseek interface unconditionally.
> 
> Link: https://lore.kernel.org/lkml/20190828151552.GA16855@infradead.org/
> Link: https://lore.kernel.org/lkml/20190829214319.498c7de2@naga/
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Patches 1-7 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e62ccec3ba0a17c8050ea78500dfdd0e4c5c0cc

cheers
