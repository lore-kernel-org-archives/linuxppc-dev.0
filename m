Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3061ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:56:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7AB2080A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7AB2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lbd20xfnzF3Gq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 04:56:54 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lbZn415MzF3GW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 04:54:57 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AFEE12027A;
 Wed, 31 Oct 2018 17:54:55 +0000 (UTC)
Received: from oldenburg.str.redhat.com (dhcp-192-212.str.redhat.com
 [10.33.192.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E148B1054FDA;
 Wed, 31 Oct 2018 17:54:54 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
Date: Wed, 31 Oct 2018 18:54:52 +0100
In-Reply-To: <20181031185032.679e170a@naga.suse.cz> ("Michal
 \=\?utf-8\?Q\?Suc\?\= \=\?utf-8\?Q\?h\=C3\=A1nek\=22's\?\=
 message of "Wed, 31 Oct 2018 18:50:32 +0100")
Message-ID: <877ehyf1cj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 31 Oct 2018 17:54:55 +0000 (UTC)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Michal Such=C3=A1nek:

> On Wed, 31 Oct 2018 18:20:56 +0100
> Florian Weimer <fweimer@redhat.com> wrote:
>
>> We tried to use Go to build PIE binaries, and while the Go toolchain
>> is definitely not ready (it produces text relocations and problematic
>> relocations in general), it exposed what could be an accidental
>> userspace ABI change.
>>=20
>> With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
>> relocations like R_PPC64_ADDR16_HA work:
>>=20
> ...
>
>> There are fewer mappings because the loader detects a relocation
>> overflow and aborts (=E2=80=9Cerror while loading shared libraries:
>> R_PPC64_ADDR16_HA reloc at 0x0000000120f0983c for symbol `' out of
>> range=E2=80=9D), so I had to recover the mappings externally.  Disabling=
 ASLR
>> does not help.
>>=20
> ...
>>=20
>> And it needs to be built with:
>>=20
>>   go build -ldflags=3D-extldflags=3D-pie extld.go
>>=20
>> I'm not entirely sure what to make of this, but I'm worried that this
>> could be a regression that matters to userspace.
>
> I encountered the same when trying to build go on ppc64le. I am not
> familiar with the internals so I just let it be.
>
> It does not seem to matter to any other userspace.

It would matter to C code which returns the address of a global variable
in the main program through and (implicit) int return value.

The old behavior hid some pointer truncation issues.

> Maybe it would be good idea to generate 64bit relocations on 64bit
> targets?

Yes, the Go toolchain definitely needs fixing for PIE.  I don't dispute
that.

Thanks,
Florian
