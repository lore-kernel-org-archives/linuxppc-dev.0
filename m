Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8AC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:52:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33C82080A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 17:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33C82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lbX33y1xzF3Jy
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 04:52:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lbTp18FxzF3Jh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 04:50:37 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A8841B044;
 Wed, 31 Oct 2018 17:50:33 +0000 (UTC)
Date: Wed, 31 Oct 2018 18:50:32 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Florian Weimer <fweimer@redhat.com>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
Message-ID: <20181031185032.679e170a@naga.suse.cz>
In-Reply-To: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 31 Oct 2018 18:20:56 +0100
Florian Weimer <fweimer@redhat.com> wrote:

> We tried to use Go to build PIE binaries, and while the Go toolchain
> is definitely not ready (it produces text relocations and problematic
> relocations in general), it exposed what could be an accidental
> userspace ABI change.
>=20
> With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
> relocations like R_PPC64_ADDR16_HA work:
>=20
...

> There are fewer mappings because the loader detects a relocation
> overflow and aborts (=E2=80=9Cerror while loading shared libraries:
> R_PPC64_ADDR16_HA reloc at 0x0000000120f0983c for symbol `' out of
> range=E2=80=9D), so I had to recover the mappings externally.  Disabling =
ASLR
> does not help.
>=20
...
>=20
> And it needs to be built with:
>=20
>   go build -ldflags=3D-extldflags=3D-pie extld.go
>=20
> I'm not entirely sure what to make of this, but I'm worried that this
> could be a regression that matters to userspace.

I encountered the same when trying to build go on ppc64le. I am not
familiar with the internals so I just let it be.

It does not seem to matter to any other userspace. Maybe it would be
good idea to generate 64bit relocations on 64bit targets?

Thanks

Michal
