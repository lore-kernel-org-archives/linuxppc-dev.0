Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D449C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:57:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1508B20837
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1508B20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BDYC6QXyzDr30
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 00:57:03 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BDMZ6cq3zDqfL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 00:48:42 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 78017AF92;
 Fri,  7 Dec 2018 13:48:39 +0000 (UTC)
Date: Fri, 7 Dec 2018 14:48:38 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 3/4] powerpc/tm: Unset MSR[TS] if not recheckpointing
Message-ID: <20181207144838.4f0382c6@naga.suse.cz>
In-Reply-To: <1543263121-9590-3-git-send-email-leitao@debian.org>
References: <1543263121-9590-1-git-send-email-leitao@debian.org>
 <1543263121-9590-3-git-send-email-leitao@debian.org>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 Stable <stable@vger.kernel.org>, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 26 Nov 2018 18:12:00 -0200
Breno Leitao <leitao@debian.org> wrote:

> There is a TM Bad Thing bug that can be caused when you return from a
> signal context in a suspended transaction but with ucontext MSR[TS] unset.
>=20
> This forces regs->msr[TS] to be set at syscall entrance (since the CPU
> state is transactional). It also calls treclaim() to flush the transaction
> state, which is done based on the live (mfmsr) MSR state.
>=20
> Since user context MSR[TS] is not set, then restore_tm_sigcontexts() is n=
ot
> called, thus, not executing recheckpoint, keeping the CPU state as not
> transactional. When calling rfid, SRR1 will have MSR[TS] set, but the CPU
> state is non transactional, causing the TM Bad Thing with the following
> stack:
>=20

Works for me on Linux 4.4 and 4.12

Tested-by: Michal Such=C3=A1nek <msuchanek@suse.de>

Thanks
