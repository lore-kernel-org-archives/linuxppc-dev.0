Return-Path: <SRS0=MUiv=6C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A69FC2D0EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 12:01:11 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714AB21D79
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 12:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714AB21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 494BPb6n3tzDrpp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 22:01:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=xmission.com
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494BMK5ZBZzDrfq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 21:59:07 +1000 (AEST)
Received: from in01.mta.xmission.com ([166.70.13.51])
 by out01.mta.xmission.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.90_1)
 (envelope-from <ebiederm@xmission.com>)
 id 1jPm7f-0007nX-II; Sat, 18 Apr 2020 05:58:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com) by in01.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1jPm7e-0001Xl-Io; Sat, 18 Apr 2020 05:58:59 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christophe Leroy <christophe.leroy@c-s.fr>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-3-hch@lst.de>
 <87pnc5akhk.fsf@x220.int.ebiederm.org>
 <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
 <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
Date: Sat, 18 Apr 2020 06:55:56 -0500
In-Reply-To: <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr> (Christophe Leroy's
 message of "Sat, 18 Apr 2020 10:05:19 +0200")
Message-ID: <87v9lx3t4j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1jPm7e-0001Xl-Io; ; ; mid=<87v9lx3t4j.fsf@x220.int.ebiederm.org>;
 ; ; hst=in01.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX18UJp5X1nu8GvTzwVNg4DhYMBf3vdPs/94=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-kernel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>, Jeremy Kerr <jk@ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 17/04/2020 =C3=A0 23:09, Eric W. Biederman a =C3=A9crit=C2=A0:
>>
>> To remove the use of set_fs in the coredump code there needs to be a
>> way to convert a kernel siginfo to a userspace compat siginfo.
>>
>> Call that function copy_siginfo_to_compat and factor it out of
>> copy_siginfo_to_user32.
>
> I find it a pitty to do that.
>
> The existing function could have been easily converted to using
> user_access_begin() + user_access_end() and use unsafe_put_user() to copy=
 to
> userspace to avoid copying through a temporary structure on the stack.
>
> With your change, it becomes impossible to do that.

I don't follow.  You don't like temporary structures in the coredump
code or temporary structures in copy_siginfo_to_user32?

A temporary structure in copy_siginfo_to_user is pretty much required
so that it can be zeroed to guarantee we don't pass a structure with
holes to userspace.

The implementation of copy_siginfo_to_user32 used to use the equivalent
of user_access_begin() and user_access_end() and the code was a mess
that was very difficult to reason about.  I recall their being holes
in the structure that were being copied to userspace.

Meanwhile if you are going to set all of the bytes a cache hot temporary
structure is quite cheap.

> Is that really an issue to use that set_fs() in the coredump code ?

Using set_fs() is pretty bad and something that we would like to remove
from the kernel entirely.  The fewer instances of set_fs() we have the
better.

I forget all of the details but set_fs() is both a type violation and an
attack point when people are attacking the kernel.  The existence of
set_fs() requires somethings that should be constants to be variables.
Something about that means that our current code is difficult to protect
from spectre style vulnerabilities.

There was a very good thread about it all in I think 2018 but
unfortunately I can't find it now.

Eric
