Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9225C3815B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:45:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843A42074F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843A42074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495cc64J1pzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 05:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495cX327HNzDqvx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 05:41:39 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7FF0AAEAC;
 Mon, 20 Apr 2020 19:41:33 +0000 (UTC)
Date: Mon, 20 Apr 2020 21:41:32 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: crash in cpuidle_enter_state with 5.7-rc1
Message-ID: <20200420194132.GM25468@kitsune.suse.cz>
References: <20200417160348.GE25468@kitsune.suse.cz>
 <871roiisxg.fsf@mpe.ellerman.id.au>
 <20200420065030.GL25468@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420065030.GL25468@kitsune.suse.cz>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 20, 2020 at 08:50:30AM +0200, Michal Suchánek wrote:
> Hello,
> 
> On Mon, Apr 20, 2020 at 04:15:39PM +1000, Michael Ellerman wrote:
> > Michal Suchánek <msuchanek@suse.de> writes:
...
> > 
> > 
> > And I've just hit it with your config on a machine here, but the crash
> > is different:
> That does not look like it.
> You don't have this part in the stack trace:
> > [    1.234899] [c000000007597420] [0000000000000000] 0x0
> > [    1.234908] [c000000007597720] [0000000000000a6d] 0xa6d
> > [    1.234919] [c000000007597a20] [0000000000000000] 0x0
> > [    1.234931] [c000000007597d20] [0000000000000004] 0x4
> which is somewhat random but at least on such line is always present in
> the traces I get. Also I always get crash in cpuidle_enter_state
..
> > I'm going to guess it's STRICT_KERNEL_RWX that's at fault.
> I can try without that as well.
Can't reproduce without STRICT_KERNEL_RWX either.

Thanks

Michal
