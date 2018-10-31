Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28794ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:31:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEB52054F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEB52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lhNS6d13zF3KZ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 08:31:20 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lhKh66WKzF3KS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 08:28:55 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F041E3081258;
 Wed, 31 Oct 2018 21:28:52 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0AC91054FD7;
 Wed, 31 Oct 2018 21:28:51 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <20181031185032.679e170a@naga.suse.cz>
 <877ehyf1cj.fsf@oldenburg.str.redhat.com>
 <87efc5n73a.fsf@linux.ibm.com>
Date: Wed, 31 Oct 2018 22:28:48 +0100
In-Reply-To: <87efc5n73a.fsf@linux.ibm.com> (Tulio Magno Quites Machado
 Filho's message of "Wed, 31 Oct 2018 18:23:37 -0300")
Message-ID: <87in1hlsa7.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 31 Oct 2018 21:28:53 +0000 (UTC)
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
Cc: "Lynn A. Boger" <laboger@linux.ibm.com>, linux-mm@kvack.org,
 Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Tulio Magno Quites Machado Filho:

> Florian Weimer <fweimer@redhat.com> writes:
>
>> * Michal Such=C3=A1nek:
>>
>>> On Wed, 31 Oct 2018 18:20:56 +0100
>>> Florian Weimer <fweimer@redhat.com> wrote:
>>>
>>>> And it needs to be built with:
>>>>=20
>>>>   go build -ldflags=3D-extldflags=3D-pie extld.go
>>>>=20
>>>> I'm not entirely sure what to make of this, but I'm worried that this
>>>> could be a regression that matters to userspace.
>>>
>>> I encountered the same when trying to build go on ppc64le. I am not
>>> familiar with the internals so I just let it be.
>>>
>>> It does not seem to matter to any other userspace.
>>
>> It would matter to C code which returns the address of a global variable
>> in the main program through and (implicit) int return value.
>
> I wonder if this is restricted to linker that Golang uses.
> Were you able to reproduce the same problem with Binutils' linker?

The example is carefully constructed to use the external linker.  It
invokes gcc, which then invokes the BFD linker in my case.

Based on the relocations, I assume there is only so much the linker can
do here.  I'm amazed that it produces an executable at all, let alone
one that runs correctly on some kernel versions!  I assume that the Go
toolchain simply lacks PIE support on ppc64le.

Thanks,
Florian
