Return-Path: <SRS0=HG9l=EZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5156C56201
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 16:04:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A458522253
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 16:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjVyncsQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2DF+ca2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A458522253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CcPcr1WkbzDqq3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 03:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=216.205.24.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=oleg@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=MjVyncsQ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P2DF+ca2; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CcPZd60QszDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 03:02:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605801728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gfcSfWuzLrD9SijmafEfAdUeDPupEiDhjQNw30FxyxU=;
 b=MjVyncsQ2xGjSJE9tjKcQuqAl7wDRDdPArrRvK6NOHX4sVCZdEFWLogAHDU+yY9ZpEPkzU
 eeQ3Lii7OehV+2+bFuPPQ9Ve7GJBJekF80YHCoh/6cVRua/82mI6I/SbcmCF8tMH82xUv/
 wkzQiNXfQNqrLU5aib17w8WsCuJLvSI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605801729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gfcSfWuzLrD9SijmafEfAdUeDPupEiDhjQNw30FxyxU=;
 b=P2DF+ca22QCPnl2TjOkUAISWc/xqUjLC3fWn6GeToCrP4ZLvZmGpQ9RzqFbzyDItkuqfKM
 FXXVOc8ikDMZVuQA2ni62kAg+7siM+4Ir+Chpeu69eKMhbkUtB8qLAbn6zKeGdwig5dhKB
 bbmYv9ZywfzsNpcZJnYY1RbQ3Tr7d08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-eDEA2GMSMfCin-lOUXq_wg-1; Thu, 19 Nov 2020 11:02:05 -0500
X-MC-Unique: eDEA2GMSMfCin-lOUXq_wg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EECF1842140;
 Thu, 19 Nov 2020 16:02:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.164])
 by smtp.corp.redhat.com (Postfix) with SMTP id 455415D6AC;
 Thu, 19 Nov 2020 16:01:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
 oleg@redhat.com; Thu, 19 Nov 2020 17:02:02 +0100 (CET)
Date: Thu, 19 Nov 2020 17:01:54 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 0/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201119160154.GA5183@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Jan Kratochvil <jan.kratochvil@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Can we finally fix this problem? ;)

My previous attempt was ignored, see

	https://lore.kernel.org/lkml/20190917121256.GA8659@redhat.com/

Now that gpr_get() was changed to use membuf API we can make a simpler fix.

Sorry, uncompiled/untested, I don't have a ppc machine.

Oleg.

 arch/powerpc/kernel/ptrace/ptrace-tm.c   | 21 ++++++++++++---------
 arch/powerpc/kernel/ptrace/ptrace-view.c | 21 ++++++++++++---------
 include/linux/regset.h                   | 12 ++++++++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

