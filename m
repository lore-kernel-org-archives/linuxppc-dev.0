Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CB6C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 12:00:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9FD60234
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 12:00:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A9FD60234
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmzWx6gMMz3cHm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 22:00:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=FQidGTPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=FQidGTPh; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmzWC5WHbz309j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Aug 2021 21:59:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GmzW15xPNz9sWS;
 Sat, 14 Aug 2021 21:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1628942382;
 bh=g2G5hFPZF1lKhi3yGSAgG83UWIDupBfi4QPY+qfq8Ks=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=FQidGTPhoSPHk+7MUkS1XOt7q1mfSsaWmyfom77eiQuSbVMsn6TqP69Id9NYkwwPW
 nduK249GoXidT8AYETQWmqCbcQKJvMyKrTQl6GskubYpekRwOjZlkmBRhkUFEL1Mi2
 8qWUtBPx3WI6SO9WgTdID53BPzo316jWb0bQxuU3E5Isb52IVpStcBWm4h824hT8Fu
 LGhm34VNFBBWLNyp+gztGESFnSBB3zjGoSpvQrcUC88bm8v9dLbP+At5kBbq/22icG
 mQ2J1rt2Y6nXJVwwsceAGkjwc2qBogmj9TeLU1XDSTp501O9L95w6rjZSEZkYYJR1z
 Isf1s9ZkWN7yg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bill Wendling <morbo@google.com>, Daniel Axtens <dja@axtens.net>,
 Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
In-Reply-To: <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
References: <20210812204951.1551782-1-morbo@google.com>
 <87sfzde8lk.fsf@linkitivity.dja.id.au>
 <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
Date: Sat, 14 Aug 2021 21:59:40 +1000
Message-ID: <87a6lkme37.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Bill Wendling <morbo@google.com> writes:
> On Fri, Aug 13, 2021 at 7:13 AM Daniel Axtens <dja@axtens.net> wrote:
>> Bill Wendling <morbo@google.com> writes:
...
>> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> > index 6505d66f1193..17a9fbf9b789 100644
>> > --- a/arch/powerpc/Makefile
>> > +++ b/arch/powerpc/Makefile
>> > @@ -122,6 +122,7 @@ endif
>> >
>> >  LDFLAGS_vmlinux-y := -Bstatic
>> >  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
>> > +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
...
>
> Unrelated question: Should the "-pie" flag be added with "+= -pie"
> (note the plus sign)?

I noticed that too.

It's been like that since the original relocatable support was added in
2008, commit 549e8152de80 ("powerpc: Make the 64-bit kernel as a
position-independent executable"), which did:

-LDFLAGS_vmlinux	:= -Bstatic
+LDFLAGS_vmlinux-yy := -Bstatic
+LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)


There's no mention of those flags in the change log. But the way it's
written suggests the intention was to not pass -Bstatic for relocatable
builds, otherwise it could have been more simply:

+LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= -Bstatic $(LDFLAGS_vmlinux-yy)


So I think it was deliberate to not use +=, but whether that's actually
correct I can't say. Maybe in the past -Bstatic and -pie were
incompatible?

cheers
