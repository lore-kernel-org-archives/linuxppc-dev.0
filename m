Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94192C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 09:14:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E65D72082D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 09:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E65D72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ghJh60KqzDrp4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 20:14:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ghGn4Yd7zDrbW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 20:12:32 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8D3330F8BEA;
 Thu, 25 Oct 2018 09:12:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-54.ams2.redhat.com
 [10.36.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3668860A9E;
 Thu, 25 Oct 2018 09:12:28 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Michael Sammler <msammler@mpi-sws.org>
Subject: Re: [PATCH] seccomp: Add pkru into seccomp_data
References: <20181024153523.10974-1-msammler@mpi-sws.org>
 <87zhv3nrr0.fsf@oldenburg.str.redhat.com>
 <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org>
Date: Thu, 25 Oct 2018 11:12:25 +0200
In-Reply-To: <11a706bd-060f-41de-118b-bababfd83b3d@mpi-sws.org> (Michael
 Sammler's message of "Thu, 25 Oct 2018 10:39:17 +0200")
Message-ID: <875zxqo0ee.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Oct 2018 09:12:30 +0000 (UTC)
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
Cc: Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>,
 linux-api@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>,
 Andy Lutomirski <luto@amacapital.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Michael Sammler:

> Thank you for the pointer about the POWER implementation. I am not
> familiar with POWER in general and its protection key feature at
> all. Would the AMR register be the correct register to expose here?

Yes, according to my notes, the register is called AMR (special purpose
register 13).

> I understand your concern about exposing the number of protection keys
> in the ABI. One idea would be to state, that the pkru field (which
> should probably be renamed) contains an architecture specific value,
> which could then be the PKRU on x86 and AMR (or another register) on
> POWER. This new field should probably be extended to __u64 and the
> reserved field removed.

POWER also has proper read/write bit separation, not PKEY_DISABLE_ACCESS
(disable read and write) and PKEY_DISABLE_WRITE like Intel.  It's
currently translated by the kernel, but I really need a
PKEY_DISABLE_READ bit in glibc to implement pkey_get in case the memory
is write-only.

> Another idea would be to not add a field in the seccomp_data
> structure, but instead provide a new BPF instruction, which reads the
> value of a specified protection key.

I would prefer that if it's possible.  We should make sure that the bits
are the same as those returned from pkey_get.  I have an implementation
on POWER, but have yet to figure out the implications for 32-bit because
I do not know the AMR register size there.

Thanks,
Florian
