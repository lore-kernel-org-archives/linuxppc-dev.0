Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E6C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 18:02:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73D1206B7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 18:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="efET++oR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73D1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P19M2XcDzDqK9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 05:02:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.73; helo=rcdn-iport-2.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="efET++oR"; 
 dkim-atps=neutral
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P17J2CmlzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 05:00:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1458; q=dns/txt; s=iport;
 t=1553018444; x=1554228044;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hkDJrqDrjP+48F5yFNTom+YferlLrS+lWagGJSC0H10=;
 b=efET++oRw/SSmauR7vWiXGUkNQWU2T4t4rOr2zGqSqBLjNI0S3T7J79j
 mr9cZ6hib98JZSUhETzjLzm3q0mVSEbm21n2iMbKXSFBra0u7VK0DqqiY
 yr3N5g8FtVQegCCsSZa2mS0Gk2lw2oqhQtcuIRNIFQpeRnjXT3p2lofo4 8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAACcLZFc/4oNJK1jGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUwIBAQEBAQsBgWYqgTgzl3mCDY4/iXOBewsBAYRsAoR?=
 =?us-ascii?q?rIjYHDQEBAwEBCQEDAm0ohUoBAQEDATo/BQsLGAklDy0bBoUjCKtiijIigQ0?=
 =?us-ascii?q?BizEXgUA/hCOBKBkBiSADkhySTQmCS5BVJQyBcJFijCORbAIEBgUCFW9fDCW?=
 =?us-ascii?q?BVjMaCBsVgyiCFQwLgQABDo0vHwOQEQEB?=
X-IronPort-AV: E=Sophos;i="5.60,245,1549929600"; d="scan'208";a="540465412"
Received: from alln-core-5.cisco.com ([173.36.13.138])
 by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 19 Mar 2019 18:00:38 +0000
Received: from zorba ([10.41.50.85])
 by alln-core-5.cisco.com (8.15.2/8.15.2) with ESMTPS id x2JI0aN2020396
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 Mar 2019 18:00:37 GMT
Date: Tue, 19 Mar 2019 11:00:37 -0700
From: Daniel Walker <danielwa@cisco.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PULL REQUEST] powerpc generic command line
Message-ID: <20190319180037.slcazic3yddebapv@zorba>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <878sxb7jck.fsf@concordia.ellerman.id.au>
 <20190319153842.vgrm5dc7wwc4u44l@zorba>
 <3739e843-0fe4-1295-bd9b-e4a6df614147@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3739e843-0fe4-1295-bd9b-e4a6df614147@c-s.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Outbound-SMTP-Client: 10.41.50.85, [10.41.50.85]
X-Outbound-Node: alln-core-5.cisco.com
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
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 19, 2019 at 06:42:35PM +0100, Christophe Leroy wrote:
> Well, that's what I started with, but at the end my main worry has been that
> you bring a non exciting set of complicated macros and code to replace
> simple code, and you break something out of generic OF code to a new brand
> new generic one, instead of updating the existing generic OF code.
 
Even if we update the generic OF code it only changes the powerpc changes slightly.
Because in arch/powerpc/kernel/prom_init.c there is a second version of the same
thing, which doesn't use OF.

We're not replacing simple macro's in powerpc with in-kind replacements, we're
adding a feature which we want. So yes our macros are more complicated, but in
the grand scheme of things they are very simple macros. If you think my stuff is
complicated, you haven't seen complicated.

I didn't see anyplace in your comments when you found code which would cause a
problem ? Did you find breakage which I missed?

> I like the idea behind your series very much, but I don't like too much the
> way it is proposed to be implemented. If you give me one week or two, I will
> come with a lighter proposal that should achieve the same goal.

It's fine with us, we just want the feature set. We'll continue with our version
tho, unless you decide to submit something.

I will incorporate your comments now, but immediately prior to a pull request I
couldn't add them.

Daniel
