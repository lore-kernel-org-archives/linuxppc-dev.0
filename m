Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58D1C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5770A2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5770A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dTl53JMqzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:11:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dTT16py5zDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 20:59:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43dTSt3ZpZz9sBQ;
 Mon, 14 Jan 2019 20:58:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] arch: add split IPC system calls where needed
In-Reply-To: <87pnsz28k2.fsf@concordia.ellerman.id.au>
References: <20190110162435.309262-1-arnd@arndb.de>
 <20190110162435.309262-15-arnd@arndb.de>
 <87pnsz28k2.fsf@concordia.ellerman.id.au>
Date: Mon, 14 Jan 2019 20:58:52 +1100
Message-ID: <87muo31rxf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Hi Arnd,
>
> Arnd Bergmann <arnd@arndb.de> writes:
>> The IPC system call handling is highly inconsistent across architectures,
>> some use sys_ipc, some use separate calls, and some use both.  We also
>> have some architectures that require passing IPC_64 in the flags, and
>> others that set it implicitly.
...
>
> We already have a gap at 366-377 from when we tried to add the split IPC
> calls a few years back.
>
> I guess I don't mind leaving that gap and using the common numbers as
> you've done here.
>
> But it would be good to add a comment pointing out that we have room
> at 366 for more arch specific syscalls as well.
>
> cheers

Guess I sent that one twice. =F0=9F=A4=A6

cheers
