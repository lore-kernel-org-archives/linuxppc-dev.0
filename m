Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B057C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:50:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08932339E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08932339E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=informatik.wtf
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K2X773QJzDr3F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 22:50:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K2Gb6zfgzDrTK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 22:38:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46K2Gb3vkXz8t6G
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 22:38:47 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46K2Gb24fpz9sML; Thu, 29 Aug 2019 22:38:47 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=informatik.wtf
 (client-ip=68.65.122.29; helo=mta-09-4.privateemail.com;
 envelope-from=cmr@informatik.wtf; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=informatik.wtf
Received: from MTA-09-4.privateemail.com (mta-09-4.privateemail.com
 [68.65.122.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46K2GZ5S46z9sDB
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2019 22:38:46 +1000 (AEST)
Received: from MTA-09.privateemail.com (localhost [127.0.0.1])
 by MTA-09.privateemail.com (Postfix) with ESMTP id DFDC460049;
 Thu, 29 Aug 2019 08:38:43 -0400 (EDT)
Received: from APP-04 (unknown [10.20.147.154])
 by MTA-09.privateemail.com (Postfix) with ESMTPA id BAB6C6004F;
 Thu, 29 Aug 2019 12:38:43 +0000 (UTC)
Date: Thu, 29 Aug 2019 07:38:43 -0500 (CDT)
From: Christopher M Riedl <cmr@informatik.wtf>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org,
 kernel-hardening@lists.openwall.com
Message-ID: <1128494624.37921.1567082323737@privateemail.com>
In-Reply-To: <87ef14v5j0.fsf@dja-thinkpad.axtens.net>
References: <20190828034613.14750-1-cmr@informatik.wtf>
 <20190828034613.14750-2-cmr@informatik.wtf>
 <87ef14v5j0.fsf@dja-thinkpad.axtens.net>
Subject: Re: [PATCH v5 1/2] powerpc/xmon: Allow listing and clearing
 breakpoints in read-only mode
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

> On August 29, 2019 at 1:40 AM Daniel Axtens <dja@axtens.net> wrote:
> 
> 
> Hi Chris,
> 
> > Read-only mode should not prevent listing and clearing any active
> > breakpoints.
> 
> I tested this and it works for me:
> 
> Tested-by: Daniel Axtens <dja@axtens.net>
> 
> > +		if (xmon_is_ro || !scanhex(&a)) {
> 
> It took me a while to figure out what this line does: as I understand
> it, the 'b' command can also be used to install a breakpoint (as well as
> bi/bd). If we are in ro mode or if the input after 'b' doesn't scan as a
> hex string, print the list of breakpoints instead. Anyway, I'm now
> happy with it, so:
>

I can add a comment to that effect in the next version. That entire section
of code could probably be cleaned up a bit - but that's for another patch.
Thanks for testing!

> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Regards,
> Daniel
> 
> >  			/* print all breakpoints */
> >  			printf("   type            address\n");
> >  			if (dabr.enabled) {
> > -- 
> > 2.23.0
