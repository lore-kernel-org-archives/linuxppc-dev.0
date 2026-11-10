Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C79606A325
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LFB9YLC0;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VWAHcmuN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPDSS1dYcz2xlY;
	Wed, 11 Nov 2026 04:40:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794332408;
	cv=pass; b=eYZreJIJyWyWL8AYzTnTR6Ax2sShrBMdoR400l96OI/oQbwqG155iuz5GPsD2urObml8NoOeYtxoY+aMrtu8SRI1BOC1xWP1CY1yYMo5ubrGo9mopgGSsU+9elbSONrZ1sqesfc1PWBXVFxSTKgF3bLx8eliBD0mvjkHo5z3oOAyz8iekIS4xJQ+Wgc/WpBlpUS9RHf+6me+xFELYu7vs608H4exsRXUTM2yMc7/COdwb1VSBVaP2AaXEcTm7QGdAY1bEQpIC99Er6Fu6RrZM0CPSd3URCn5t5wZW3XwwkVDbTYVLtDkN0FNIFrKYjN6dtH6IOe+fj+M55s0giSwxA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794332408; c=relaxed/relaxed;
	bh=TfBLrrNXwj9PDzJLXqf9MPbdj5kOF5LdyfVsHqX5orE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X+JEEwWDGV9k+/twqy0tSIj75bPeJDfGIYLKDxF8co48iYul8Ja7tF5DDSKFRITBRpxt0b71OkXxIFJqkmkDTHzXcYncLhkZw1R4vJZNKePNgmJ8s+R3bp/ntgLarCH/LWKYJbBcvDNlVk4Rip37njkWrP03kLHajw84BmAG1+rwP/EyhdunS0uc1rLU35pJbs65kcw2DQwgo/0iD2qBtBS45rDr6yar5B55TqAYgG0bqfB4iP86VXlqVz4eNnDjh0geAK5C41W8Sp6eOIMpHOWuOcnyOz/Dl4HE+FojoUHh1T6tHJbPyfaiLneJUT2WloEA5FRr/5vnDnpxiNQnpA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LFB9YLC0; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VWAHcmuN; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=LFB9YLC0;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=VWAHcmuN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPDSM2X1Xz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 04:40:00 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1794332395; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sPHXkF/RBruqZgEMLsmbH7+0xniN5TVzzvtuEe1lYfaiFdNe0+FD5t9WFO+HefaAeI
    fIpZ6l6SW8EQ+jWrI8uftQRiadYRDHiCEiyHh20kg12FHefwZr4xTs8kcHEzTymu4U0T
    J3ZfTxcrq/rKzsYD+RcIcFXWvm/ZFHpha3WSN1UKnFiSHKGG6LYwZrFC2BalKiQgEZuv
    0v1iAIjeamdWb4VG1gee5tRGlXwe63AXonxbyZUPqG388WpqAL9nyaPXX1/pmvkgQELj
    zdiOmfMeaXD3Etn6adD7xWsipuIIv7JClB8JvG2aNuVyIevNNl8raCvQDFFsCfBWDIVF
    XeuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794332395;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TfBLrrNXwj9PDzJLXqf9MPbdj5kOF5LdyfVsHqX5orE=;
    b=m08KbpvwgsN2bx268zW9fXuyhLVGwcM8vy/gt/FUjSmK378Kc76Ui1+I9BLY1i1B0n
    splNLdYy0THd99k9/BJqARnKxlAY9DLvq0S4jkjLVAQAqZmhHMEYPsJaLjPDEGLI5J+B
    qXH0D55H4bk325VD7UFhJs/6MkOushJyrLAmkPi4dsBpaGZ7HcDRg87SzySCi7eF9aXO
    LPnAhEcrgS0bDup0O9s0TzcrADglfhLIuHhkdK04SXsUhP2a4bLvFJt8RaWrNLDfimnc
    8k09yYR619X6mjkm7aAMjxpD+eiIVCj43G3ACaKxXV83CgJdNOkmSq5clFZdAt7dEPdD
    UoMA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794332395;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TfBLrrNXwj9PDzJLXqf9MPbdj5kOF5LdyfVsHqX5orE=;
    b=LFB9YLC0+d82j0Crw0Cj/NzFyDCb7IJhCvq2LJZhuwu5e8e6tG9U8m7cNFBQM7+SPR
    Du3uvZtzkLhDWbKYc8jpMkFYwMgUbluZWu4FMO+GYaP5PhJzBlFZ6GGBdEdEoNJROIVD
    h+mCpBCRec+xIYWZxFbMXoFgp1XoFWFZ3sj9okIVNy9gN86wcq9TMoaydbRmPwWYJ43l
    e6huYo/16aYsyWWl+ELUwMLpyrwuVO/Cb6WVpZ9hqMOG1vCjlTjmS+DFQzDlunWDwRfX
    xB7YgOp9NLze+eeyGIhvzzlJbEKz8L9ozx26ammgrqWDQE224P76cKlgG4l9PlF1bH+M
    bvpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794332395;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=TfBLrrNXwj9PDzJLXqf9MPbdj5kOF5LdyfVsHqX5orE=;
    b=VWAHcmuNxt67l+OLByVVf+oFGjQtveIzuLDwfhBm1q6T8SQVIrRFp5+/mNaXrkO/4y
    sThiQYB6+1Kvk6HG+/Ag==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+l5Bzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92AAHdrhx0
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 10 Nov 2026 18:39:53 +0100 (CET)
Subject: Re: [PATCH v2 0/3] KVM: PPC: BookE: Fix boot hang on preemptible
 kernels
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
 harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
 venkat88@linux.ibm.com, nnmlinux@linux.ibm.com, mkchauras@gmail.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>, Christian Zigotzky <info@xenosoft.de>
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <519cb2b2-5c3d-a75e-6919-d5d0784bae63@xenosoft.de>
Date: Tue, 10 Nov 2026 18:39:52 +0100
X-Mailer: BrassMonkey/35.0.2
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261110053238.3794500-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/26 06:32, Shrikanth Hegde wrote:
> Christian Zigotzky had reported that preemptible kernels don't boot on
> his FSL Cyrus+ board. The board freezes on running either full/lazy
> preemption and has been an issue for a while now (years!).
>
> https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t
>
> After 7.0, there is only preempt=full/lazy which removed the
> preempt=none/voluntary workaround used to mask the issue. There was
> challenge is getting the console logs which made the fixes difficult since
> one couldn't know where the issue is.
>
> Thanks to Michal for helping in getting the logs. That pointed at few
> places where the issue could be. This series is an attempt at fixing
> those.
>
> Christian, I haven't taken the tested-by tag since patches have
> changed quite a bit.
> Please help in *testing* the patches again.
>
> v1->v2:
> - Re-order to avoid preempt count dance (Narayana Murty N)
> - Do only hard_irq_disable on PPC64 to avoid second warning. On PPC32
>    use local_irq_disable to acheive the same. (Ritesh Harjani)
>
> v1: https://lore.kernel.org/all/20260928110411.844582-1-sshegde@linux.ibm.com/
>
> New API ppc_hard_irq_disable could potentially be used in other places.
> There is similar pattern of doing both local and hard irq disable and
> likely not all callsites need both. But it is a larger effort and due to
> my time limit, it will be taken up subsequently.
>
> Shrikanth Hegde (3):
>    powerpc/irq: Add ppc_hard_irq_disable()
>    KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
>    KVM: PPC: Use ppc_hard_irq_disable before guest entry
>
>   arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
>   arch/powerpc/kvm/booke.c          |  7 +++++--
>   arch/powerpc/kvm/powerpc.c        | 14 +++-----------
>   3 files changed, 25 insertions(+), 13 deletions(-)
>

I patched the RC2 of kernel 7.4 with these three new patches and 
compiled it again [1]. The patched RC2 preempt kernel works with KVM HV 
without any problems.

Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>

Thanks a lot for your help! :-)

[1] https://github.com/chzigotzky/kernels/releases/tag/v7.4.0-rc2-2

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


