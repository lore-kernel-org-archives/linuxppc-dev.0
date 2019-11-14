Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A35C43215
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:52:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A7C206EF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A7C206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DJG519Y8zF3cS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 21:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DGTC2T5vzF3mn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:31:43 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 012FDAD2B;
 Thu, 14 Nov 2019 09:31:39 +0000 (UTC)
Date: Thu, 14 Nov 2019 10:31:38 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] Fix wrong message when RFI Flush is disable
Message-ID: <20191114093138.GF11661@kitsune.suse.cz>
References: <20190502210907.42375-1-gwalbon@linux.ibm.com>
 <47DFxM5mVHz9sNT@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47DFxM5mVHz9sNT@ozlabs.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mikey@neuling.org, maurosr@linux.vnet.ibm.com,
 Gustavo Walbon <gwalbon@linux.ibm.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, diana.craciun@nxp.com, paulus@samba.org,
 stable@vger.kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org,
 gwalbon@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 14, 2019 at 08:07:35PM +1100, Michael Ellerman wrote:
> On Thu, 2019-05-02 at 21:09:07 UTC, Gustavo Walbon wrote:
> > From: "Gustavo L. F. Walbon" <gwalbon@linux.ibm.com>
> > 
> > The issue was showing "Mitigation" message via sysfs whatever the state of
> > "RFI Flush", but it should show "Vulnerable" when it is disabled.
> > 
> > If you have "L1D private" feature enabled and not "RFI Flush" you are
> > vulnerable to meltdown attacks.
> > 
> > "RFI Flush" is the key feature to mitigate the meltdown whatever the
> > "L1D private" state.
> > 
> > SEC_FTR_L1D_THREAD_PRIV is a feature for Power9 only.
> > 
> > So the message should be as the truth table shows.
> > CPU | L1D private | RFI Flush |                   sysfs               |
> > ----| ----------- | --------- | ------------------------------------- |
> >  P9 |    False    |   False   | Vulnerable
> >  P9 |    False    |   True    | Mitigation: RFI Flush
> >  P9 |    True     |   False   | Vulnerable: L1D private per thread
> >  P9 |    True     |   True    | Mitigation: RFI Flush, L1D private per
> >     |             |           | thread
> >  P8 |    False    |   False   | Vulnerable
> >  P8 |    False    |   True    | Mitigation: RFI Flush
> > 
> > Output before this fix:
> >  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
> >  Mitigation: RFI Flush, L1D private per thread
> >  # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
> >  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
> >  Mitigation: L1D private per thread
> > 
> > Output after fix:
> >  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
> >  Mitigation: RFI Flush, L1D private per thread
> >  # echo 0 > /sys/kernel/debug/powerpc/rfi_flush
> >  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
> >  Vulnerable: L1D private per thread
> > 
> > Link: https://github.com/linuxppc/issues/issues/243
> > 
> > Signed-off-by: Gustavo L. F. Walbon <gwalbon@linux.ibm.com>
> > Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/4e706af3cd8e1d0503c25332b30cad33c97ed442
> 
> cheers

Fixes: ff348355e9c7 ("powerpc/64s: Enhance the information in
cpu_show_meltdown()")

Thanks

Michal
