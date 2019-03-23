Return-Path: <SRS0=CEjL=R2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA8C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 16:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEB7D21902
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Mar 2019 16:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB7D21902
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44RQv95XR5zDqRW
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 03:28:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=goodmis.org
 (client-ip=216.40.44.33; helo=smtprelay.hostedemail.com;
 envelope-from=rostedt@goodmis.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
X-Greylist: delayed 570 seconds by postgrey-1.36 at bilbo;
 Sun, 24 Mar 2019 03:27:12 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0033.hostedemail.com
 [216.40.44.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44RQsX2DnSzDqMm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2019 03:27:10 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id 919CD18011E7F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Mar 2019 16:17:49 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id 459CF18224B82;
 Sat, 23 Mar 2019 16:17:35 +0000 (UTC)
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-HE-Tag: son66_7c5c51044e845
X-Filterd-Recvd-Size: 1284
Received: from grimm.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225]) (Authenticated sender: rostedt@goodmis.org)
 by omf08.hostedemail.com (Postfix) with ESMTPA;
 Sat, 23 Mar 2019 16:17:34 +0000 (UTC)
Date: Sat, 23 Mar 2019 12:17:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: ppc64le: ftrace self-tests and $(CC_FLAGS_FTRACE) broken?
Message-ID: <20190323121732.59533e78@grimm.local.home>
In-Reply-To: <20190323131950.GA30948@redhat.com>
References: <20190323131950.GA30948@redhat.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 23 Mar 2019 09:19:50 -0400
Joe Lawrence <joe.lawrence@redhat.com> wrote:

> Perhaps this is gcc version specific?  I didn't see any other reports,
> so maybe its specific to my config.  If I run make V=1, I can see that
> gcc is called with '-pg -mprofile-kernel', but then the record_mcount
> script is skipped.  Any ideas?

But you see it running the script if you remove that commit? Do you
happen to see -mrecord-mcount at all in a V=1 make?

-- Steve
