Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B96DC48BD7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 20:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9737208E3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 20:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9737208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZWJF356VzDqkf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 06:11:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.79; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0079.hostedemail.com
 [216.40.44.79])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZWDX3MmRzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 06:08:27 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 16720180A8155;
 Thu, 27 Jun 2019 20:08:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lunch72_ea9665a28052
X-Filterd-Recvd-Size: 2578
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf18.hostedemail.com (Postfix) with ESMTPA;
 Thu, 27 Jun 2019 20:08:20 +0000 (UTC)
Message-ID: <55dc85b3e405821baafe9d8868ef921f99b6d103.camel@perches.com>
Subject: Re: [PATCH v2] powerpc/setup_64: fix -Wempty-body warnings
From: Joe Perches <joe@perches.com>
To: Qian Cai <cai@lca.pw>, mpe@ellerman.id.au
Date: Thu, 27 Jun 2019 13:08:19 -0700
In-Reply-To: <1561665166.5154.90.camel@lca.pw>
References: <1559768018-7665-1-git-send-email-cai@lca.pw>
 <1561665166.5154.90.camel@lca.pw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, tyreld@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-06-27 at 15:52 -0400, Qian Cai wrote:
> On Wed, 2019-06-05 at 16:53 -0400, Qian Cai wrote:
> > At the beginning of setup_64.c, it has,
> > 
> >   #ifdef DEBUG
> >   #define DBG(fmt...) udbg_printf(fmt)
> >   #else
> >   #define DBG(fmt...)
> >   #endif
> > 
> > where DBG() could be compiled away, and generate warnings,
> > 
> > arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> > arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> > empty body in an 'if' statement [-Wempty-body]
> >     DBG("Argh, can't find dcache properties !\n");
> >                                                  ^
> > arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> > empty body in an 'if' statement [-Wempty-body]
> >     DBG("Argh, can't find icache properties !\n");
[]
> > diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
[]
> > @@ -71,7 +71,7 @@
> >  #ifdef DEBUG
> >  #define DBG(fmt...) udbg_printf(fmt)
> >  #else
> > -#define DBG(fmt...)
> > +#define DBG(fmt...) do { } while (0)

I suggest

#define DBG(fmt...) do { if (0) udbg_printf(fmt); } while (0)

so that format and argument are always verified by the compiler.

I would also prefer a more generic form using ##__VA_ARGS__

#ifdef DEBUG
#define DBG(fmt, ...) udbg_printf(fmt, ##__VA_ARGS__)
#else
#define DBG(fmt, ...) do { if (0) udbg_printf(fmt, ##__VA_ARGS__); } while (0)
#endif

or maybe use the no_printk macro like

#ifdef DEBUG
#define DBG(fmt, ...) udbg_printf(fmt, ##__VA_ARGS__)
#else
#define DBG(fmt, ...) no_printk(fmt, ##__VA_ARGS__)
#endif


