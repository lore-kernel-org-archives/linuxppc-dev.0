Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D9AC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:04:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23702084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23702084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z5rb5x3jzDqHv
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:04:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z5pR68N1zDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:02:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Z5pR2RwHz8xRS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:02:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Z5pR1PTzz9sSQ; Thu,  4 Apr 2019 00:02:39 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.24; helo=new-02.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from NEW-02.privateemail.com (new-02.privateemail.com [68.65.122.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Z5pQ1lrxz9sPF
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2019 00:02:37 +1100 (AEDT)
Received: from MTA-07-1.privateemail.com (unknown [10.20.147.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by NEW-02.privateemail.com (Postfix) with ESMTPS id 23133603A8;
 Wed,  3 Apr 2019 13:02:34 +0000 (UTC)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id ECF6A60045;
 Wed,  3 Apr 2019 09:02:33 -0400 (EDT)
Received: from APP-04 (unknown [10.20.147.154])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id D65A260043;
 Wed,  3 Apr 2019 13:02:33 +0000 (UTC)
Date: Wed, 3 Apr 2019 09:02:33 -0400 (EDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Message-ID: <302206558.18553.1554296553840@privateemail.com>
In-Reply-To: <81765ce2-af34-6776-a5f6-f69d265cd3c2@au1.ibm.com>
References: <20190329042153.25698-1-cmr@informatik.wtf>
 <81765ce2-af34-6776-a5f6-f69d265cd3c2@au1.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: add read-only mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev54
X-Originating-Client: open-xchange-appsuite
X-Virus-Scanned: ClamAV using ClamSMTP
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On March 29, 2019 at 12:49 AM Andrew Donnellan <andrew.donnellan@au1.ibm.com> wrote:
> 
> 
> On 29/3/19 3:21 pm, cmr wrote:
> > Operations which write to memory should be restricted on secure systems
> > and optionally to avoid self-destructive behaviors.
> 
> For reference:
>   - https://github.com/linuxppc/issues/issues/219
>   - https://github.com/linuxppc/issues/issues/232
> 
> Perhaps clarify what is meant here by "secure systems".
> 
> Otherwise commit message looks good.
> 

I will reword this for the next patch to reflect the verbiage in the referenced
github issue -- ie. Secure Boot and not violating secure boot integrity by using xmon.

> 
> > ---
> >   arch/powerpc/Kconfig.debug |  7 +++++++
> >   arch/powerpc/xmon/xmon.c   | 24 ++++++++++++++++++++++++
> >   2 files changed, 31 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> > index 4e00cb0a5464..33cc01adf4cb 100644
> > --- a/arch/powerpc/Kconfig.debug
> > +++ b/arch/powerpc/Kconfig.debug
> > @@ -117,6 +117,13 @@ config XMON_DISASSEMBLY
> >   	  to say Y here, unless you're building for a memory-constrained
> >   	  system.
> >   
> > +config XMON_RO
> > +	bool "Set xmon read-only mode"
> > +	depends on XMON
> > +	default y
> > +	help
> > +	  Disable state- and memory-altering write operations in xmon.
> 
> The meaning of this option is a bit unclear.
> 
>  From the code - it looks like what this option actually does is enable 
> RO mode *by default*. In which case it should probably be called 
> XMON_RO_DEFAULT and the description should note that RW mode can still 
> be enabled via a cmdline option.
>

Based on Christophe's feedback the default will change for this option in the
next patch. I will also add the cmdline options to the description for clarity.

>
> > +
> >   config DEBUGGER
> >   	bool
> >   	depends on KGDB || XMON
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index a0f44f992360..c13ee73cdfd4 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> > @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
> >   #endif
> >   static unsigned long in_xmon __read_mostly = 0;
> >   static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> > +static int xmon_ro = IS_ENABLED(CONFIG_XMON_RO);
> >   
> >   static unsigned long adrs;
> >   static int size = 1;
> > @@ -1042,6 +1043,8 @@ cmds(struct pt_regs *excp)
> >   			set_lpp_cmd();
> >   			break;
> >   		case 'b':
> > +			if (xmon_ro == 1)
> > +				break;
> 
> For all these cases - it would be much better to print an error message 
> somewhere when we abort due to read-only mode.
> 

I included print messages initially but then thought about how xmon is intended
for "power" users. I can add print statements to avoid confusion and frustration
since the operations are just "silently" dropped -- *if* that aligns with xmon's
"philosophy".
