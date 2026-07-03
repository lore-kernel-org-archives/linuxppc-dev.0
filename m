Return-Path: <linuxppc-dev+bounces-23473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8F2C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 09:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs7rQ2kK0z2xdb;
	Fri, 03 Jul 2026 19:34:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783071286;
	cv=none; b=ne+21QCNZYPUt7+iyFWlS24xTKQiQ6evezzjAxjmWkxpFOfwTnwfR9D7W1q+i0cCsm61wxNjd1OFRguO7Hd7ERr5Xz3KTNkbp8pxhQc1/OIV7DyGgziyRbPQ2IAqjj/S8Hk1ucgH3puPwtEqDRciL1bX0GjKLbdXh38aZLsKT15OyXXGz3rGyrhMi2GIgfb0hFUIBE/qVl1W+bUh8MAauXQKyCBL6QdCpgUPSE8HAI2UZJK2V7D3IRXz8mdW1sm0/M5GWPCMof4qB96iR+KEoy+Lx7alnOPuiJhqSjIaYvWYPZfGWlT24STlMjRPM2YFOlDcwOHLVTXDbze8TrYcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783071286; c=relaxed/relaxed;
	bh=nMY8UZyvI/HF5Rdv1bSkWyNbGRbx1G27seV2ZaZUbN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A4jEWXBnyrvJ4hwsd4CcA8EoJu/GwqTa7WMRFkbu3MzD/Q02cwF1mPaKN3+FieXg43sTwEe6RKU+QRwPoOjlCEggEiRwEJyLhFRhbe9rGVMayLbMDsHBCSnYkT8iGLWvNygfEd4krMKz+zcVCkJkN7hQWPvbllMrAwEhVBjX1rrSJKG2xehKa0cvNeP9j6CEIuINPsvtHT5dDlfSBz5ulH3oyYL7a4rlzrJ4r45XCFUpns+yIExJdILSrF4o1fk+Et5YzW77gcpURue2YwuJeUiCv7Cko3M9rGnIi97yqekHbKMEY+qPendGv9tkIldeqj63ax5G82I46RQzOKzRGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4JQ6Zc8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4JQ6Zc8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs7rP30xhz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:34:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D09566001A;
	Fri,  3 Jul 2026 09:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B011F000E9;
	Fri,  3 Jul 2026 09:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783071282;
	bh=nMY8UZyvI/HF5Rdv1bSkWyNbGRbx1G27seV2ZaZUbN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K4JQ6Zc8TPguGmkEN1toHL2v5PXz61h6EWt7zZ8rNB04Nv/OFyWtRbIK7/fVYv1YG
	 B2iavueYbkcwMfN5GGnSDuP3/Y2ypQOlduP9C9EH0oHedTCI4eVb8GN99XZ7K3gk2U
	 mKiWTX7nFzp9NihhXbgvqGtv6EZe36azyYLF8fKo4DpnPtV9M5EwlFIg4kabWNJ5dR
	 ivYvj8LWnh2+s/7LGPHBUsOszJO62d4z94v7KFjNFI2CueHXILKryvycsxAeIyGtSG
	 s98h3rggiuosCqsSmQ0MRnvTtW2Y2rrZ6VdGUVtB9Peojv9MYzNR0W2Zxz87hN6G4/
	 UM7w31V/ebUew==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Ryan Roberts <ryan.roberts@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>, Lukas Gerlach <lukas.gerlach@cispa.de>, Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akdqlO0eJ6jKH-wU@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <878q7tprau.ffs@fw13>
 <akZPakNl6JT_jgGd@kunlun.suse.cz> <87jyrdnmrh.ffs@fw13>
 <akdqlO0eJ6jKH-wU@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 11:34:39 +0200
Message-ID: <87ik6wmn68.ffs@fw13>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03 2026 at 09:53, Michal Such=C3=A1nek wrote:
> On Thu, Jul 02, 2026 at 10:45:54PM +0200, Thomas Gleixner wrote:
>> > When the syscall number was -1 to start with it's not possible to
>> > determine if the syscall was fileterd from the return value. s390
>> > returns the filtered state in a flag it sets on the regs structure,
>> > avoiding this problem.
>>=20
>> What needs to determine whether the syscall was filtered or not?
>
> The code that executes syscall_enter_from_user_mode() needs to determine
> that.
>
> After syscall_enter_from_user_mode() returns the syscall needs to be
> executed or skipped.
>
> 'Executing' an invalid syscall boils down to setting the return value to
> -ENOSYS.
>
> But if the syscall number returned is -1 was the syscall filtered and
> the return value set by syscall_enter_from_user_mode() or should it be
> set by the caller to -ENOSYS?

See the explanation I gave to Peter. It's conclusive, but admittedly not
intuitive.

The fact, that s390 decided to have the syscall number and the return
value in the same register is a different problem, but as I pointed out
to Sven it could have been solved completely without that flag.

Thanks,

        tglx

