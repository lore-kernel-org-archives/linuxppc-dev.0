Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6514C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:45:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2A12339E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2A12339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K2Qf3hFyzDqsp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 22:45:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K2Cv70vhzDrTL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 22:36:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46K2Cv147pz8t6G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 22:36:27 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46K2Ct6F55z9sML; Thu, 29 Aug 2019 22:36:26 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.27; helo=mta-07-4.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from MTA-07-4.privateemail.com (mta-07-4.privateemail.com
 [68.65.122.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46K2Cs71Hhz9sDB
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2019 22:36:24 +1000 (AEST)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
 by MTA-07.privateemail.com (Postfix) with ESMTP id 5E12F60046;
 Thu, 29 Aug 2019 08:36:21 -0400 (EDT)
Received: from APP-04 (unknown [10.20.147.154])
 by MTA-07.privateemail.com (Postfix) with ESMTPA id 39CB260034;
 Thu, 29 Aug 2019 12:36:21 +0000 (UTC)
Date: Thu, 29 Aug 2019 07:36:21 -0500 (CDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org,
 kernel-hardening@lists.openwall.com
Message-ID: <4809745.37851.1567082181205@privateemail.com>
In-Reply-To: <87d0gov2l5.fsf@dja-thinkpad.axtens.net>
References: <20190828034613.14750-1-cmr@informatik.wtf>
 <20190828034613.14750-3-cmr@informatik.wtf>
 <87d0gov2l5.fsf@dja-thinkpad.axtens.net>
Subject: Re: [PATCH v5 2/2] powerpc/xmon: Restrict when kernel is locked down
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev60
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
Cc: ajd@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


> On August 29, 2019 at 2:43 AM Daniel Axtens <dja@axtens.net> wrote:
> 
> 
> Hi,
> 
> > Xmon should be either fully or partially disabled depending on the
> > kernel lockdown state.
> 
> I've been kicking the tyres of this, and it seems to work well:
> 
> Tested-by: Daniel Axtens <dja@axtens.net>
> 

Thank you for taking the time to test this!

>
> I have one small nit: if I enter confidentiality mode and then try to
> enter xmon, I get 32 messages about clearing the breakpoints each time I
> try to enter xmon:
>

Ugh, that's annoying. I tested this on a vm w/ 2 vcpus but should have
considered the case of more vcpus :(

> 
> root@dja-guest:~# echo confidentiality > /sys/kernel/security/lockdown 
> root@dja-guest:~# echo x >/proc/sysrq-trigger 
> [  489.585400] sysrq: Entering xmon
> xmon: Disabled due to kernel lockdown
> xmon: All breakpoints cleared
> xmon: All breakpoints cleared
> xmon: All breakpoints cleared
> xmon: All breakpoints cleared
> xmon: All breakpoints cleared
> ...
> 
> Investigating, I see that this is because my vm has 32 vcpus, and I'm
> getting one per CPU.
> 
> Looking at the call sites, there's only one other caller, so I think you
> might be better served with this:
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 94a5fada3034..fcaf1d568162 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -3833,10 +3833,6 @@ static void clear_all_bpt(void)
>                 iabr = NULL;
>                 dabr.enabled = 0;
>         }
> -
> -       get_output_lock();
> -       printf("xmon: All breakpoints cleared\n");
> -       release_output_lock();
>  }
>  
>  #ifdef CONFIG_DEBUG_FS
> @@ -3846,8 +3842,13 @@ static int xmon_dbgfs_set(void *data, u64 val)
>         xmon_init(xmon_on);
>  
>         /* make sure all breakpoints removed when disabling */
> -       if (!xmon_on)
> +       if (!xmon_on) {
>                 clear_all_bpt();
> +               get_output_lock();
> +               printf("xmon: All breakpoints cleared\n");
> +               release_output_lock();
> +       }
> +
>         return 0;
>  }
>

Good point, I will add this to the next version, thanks!  

>
> Apart from that:
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Regards,
> Daniel
>
