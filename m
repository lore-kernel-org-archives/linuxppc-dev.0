Return-Path: <linuxppc-dev+bounces-23555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C38C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 21:20:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsRVt1vYFz2yZc;
	Sat, 04 Jul 2026 07:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783113638;
	cv=none; b=RF/lw/X2VxaUteXQFJyn/1Pc7RSlnKwStM9Q3cuu7GQrXbYUO9hYGv8htcu1LZGPPy1ebDhugwvhbuZyzaSgGXUrVwCcj9vkcAc/RybHael1xplEsAb8UdyIaF+x1bJa9FaHjxQe7myzJgjE1KiEze3YjuYy3mHhfz+QWRrrPKZR79Yw3MYAAdwBuJZqFz0dz+6QWFNA3ZItX+RUHhTzXGWJCh87pE00VelPBmGeW7TMl6xcJ8LOGcA9UtZWLZFHzGsTPobgsmZ4P2rYiCKTaMCePei4imKp5OK2gVzz8t+U182bhdJEIuFRZ+8SEP4l0RPA2mwbCC+RCJtRWBLbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783113638; c=relaxed/relaxed;
	bh=GmRpAk0oLfd0gWfVh+rqnEOK9BfphxBIPqfUy4WToJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=obriY0BEWvcSFb21NQxki5raG6dkonyCXGZVZGKADchzQqi98FCMt/AGjdgUiroWOoncIl7hHjDkFsRXQumQkKrx7eOedHpXYqkUJkSD46QIrJP+IkebhFEuVNEDOvRy8A8e0M1yvoIAnLlLu/ndFKjQWjUC1B39snWbpk+dzsKh/gL68cfTwryAREcHccB6GM0a0Lqv2EWnFUEw4phlB4iGJkmS2ufVhbDS01e9lSLCc84YE84Mu9Rclx5+wcCoNTyB30ILHRAbwibhN7+k82HIbEPmjGM1BA65/QJl07J1198j4HaObp0XwQfAyhFARBoYiJUH7jYn+jpzeLYV1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026062701 header.b=XsI115ZB; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026062701 header.b=XsI115ZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=2607:7c80:54:3::136; helo=mail.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3::136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsRVr20mzz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 07:20:35 +1000 (AEST)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 663L1ZSA3634717
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 3 Jul 2026 14:01:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 663L1ZSA3634717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1783112500;
	bh=GmRpAk0oLfd0gWfVh+rqnEOK9BfphxBIPqfUy4WToJg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XsI115ZBOQE6RF8kLr3qg2nWr/ZTSr4Cc85qgkCOplrXGEthFkxyO4lr4Oxope3Ei
	 uXNwCi3aZ7FCtu+IMJnAqz2+ucRqWMj1Z7USJtc8sJ3JeZ97gpLik9L3v7EKJiITZs
	 v3dorB7yOn0T5r2CkG54hpyoXlryh4wtyjAKA2DelYGyZEF7zAgS971DjfDngm3ESi
	 xNG5a833nv7cyD8PK/+FW1vBKez1uSFK+Mw4JZVnFQTsSNU/45Xgc7/odbqex1xmxx
	 hXA4rZMcbl0HR+NkDB+kp5lErI+aTQzy/C6IBW2f20LsUByG25W5uHpF7doGhQ6iHG
	 wsGBsVIphvsfg==
Date: Fri, 03 Jul 2026 14:01:29 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Thomas Gleixner <tglx@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>,
        =?ISO-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
CC: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
        richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, chris@zankel.net, jcmvbkbc@gmail.com,
        peterz@infradead.org, wad@chromium.org, thuth@redhat.com,
        ada.coupriediaz@arm.com, linusw@kernel.org, yeoreum.yun@arm.com,
        song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com,
        broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn,
        ryan.roberts@arm.com, yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
        mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
        arnd@arndb.de, thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
        andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v16_01/18=5D_seccomp=3A_Convert?=
 =?US-ASCII?Q?_=5F=5Fsecure=5Fcomputing=28=29_to_return_boolean?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87echjlrs4.ffs@fw13>
References: <20260629130616.642022-1-ruanjinjie@huawei.com> <20260629130616.642022-2-ruanjinjie@huawei.com> <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13> <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz> <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com> <87echjlrs4.ffs@fw13>
Message-ID: <F0993CE8-27EB-42D9-80F7-04A7A73C2395@zytor.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2026 1:52:43 PM PDT, Thomas Gleixner <tglx@kernel=2Eorg> wrote:
>On Fri, Jul 03 2026 at 13:59, Kevin Brodsky wrote:
>> On 03/07/2026 12:27, Michal Such=C3=A1nek wrote:
>>>> If we're changing the return type, it might be worth renaming the
>>>> function something like:
>>>>
>>>> 	seccomp_permits_syscall()
>>> Then not only it is clear which way the boolean value should be
>>> interpreted, it also pervents the accidental inversion of existing
>>> calls=2E Overall great=2E
>>
>> Totally agreed, if we have the opportunity to rename a completely
>> undescriptive function name like "secure_computing" we should take it=
=2E
>
>Absolutely no objections from my side on that=2E
>

Hell yes=2E=20

