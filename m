Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12165C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 17:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAED2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 17:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAED2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dg5F1n6kzDqWg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dg1y5HkRzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 04:09:39 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C17E49D432;
 Mon, 14 Jan 2019 17:09:37 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B7565D744;
 Mon, 14 Jan 2019 17:09:34 +0000 (UTC)
Date: Mon, 14 Jan 2019 11:09:32 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: ppc64le reliable stack unwinder and scheduled tasks
Message-ID: <20190114170932.awhuv7livfxhrcee@treble>
References: <7f468285-b149-37e2-e782-c9e538b997a9@redhat.com>
 <87bm4ocbbt.fsf@suse.de> <20190111010808.GA17858@redhat.com>
 <87fttzbpid.fsf@suse.de> <20190114040937.GA6739@redhat.com>
 <877ef7bt6j.fsf@suse.de> <20190114164659.GA18643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190114164659.GA18643@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 14 Jan 2019 17:09:38 +0000 (UTC)
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
Cc: Nicolai Stange <nstange@suse.de>, linux-kernel@vger.kernel.org,
 Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>,
 live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 14, 2019 at 11:46:59AM -0500, Joe Lawrence wrote:
> @@ -158,11 +158,21 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  			return 1; /* invalid backlink, too far up. */
>  		}
>  
> +		/* We can only trust the bottom frame's backlink, the rest
> +		 * of the frame may be uninitialized, continue to the next. */
> +		if (firstframe--)
> +			goto next;

Won't this decrement firstframe on every iteration, so when firstframe
is 0, it will decrement it to -1, causing it to 'goto next' on all
future iterations?

-- 
Josh
