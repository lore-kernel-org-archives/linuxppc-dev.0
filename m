Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46419606A31B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Dqhs6ux4;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=en/3zAni
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKxJk2wjVz2xSV;
	Thu, 05 Nov 2026 20:07:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.52 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793869622;
	cv=pass; b=Cp/NTeQwSHGjMH5s+mlhc5mlwCOF0EIO6NWaP2/WkHD2OEkk/ZzbDlCINErveH0Wl1GYYL7o0PaNnQUwSa5yj6oLrOO2zMZKCqMJvBleUZ7ky8p2WJGpO68bRnCulxbDFxDvawnRlGLJ59DT0wpI6Y5PA6d+OU/BDOjDwiMYre8bsdO1dPEMbMJlsa2yeA3GTJqLDetEJr/Rf4w0J7el0gZX9IFW73gTcP7sG9SKsPYWwtIdOKc0rGXIx2cpZeSZbiwiHi/k0h3zI37wn+niGssc1TaPE2aJRprqpMfs9r+MgElAl01nB/nJCBp6agO6EWD6gG6ekfyUEQtdKoDnqg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793869622; c=relaxed/relaxed;
	bh=vdDDMtXuZcI5ST0g2B/YWhJgrol3S1EgLV5st/yxsdo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Jhj31sVaDq5v+ac7DDYwIf+8KGOWSvnn9YGCU9HWAGdVdaUwvoVfE44re8jtdje+F/NoXptKknikkQJ14drxLqHvOBBdddMhKygfhBNKUhF/iQlzisK/Q3YaEJOyRdcEIgyOQjfDZby5y5k51G0QQdha3CVa3kZqylmbRxMLJN7WhMDgRFFfr9HDKwm84VaA//x4cwc18Nq8q2CYzuou+370olEdnI7rGcBB4ZLoltR/nDH3xfka9RTZaybcsnzyPCk8Av6HcC2A+u3wY1KjZGNCjoP895xHxsAc50RXWz1RiM6S0jGWkiGtgDJo0pD6RSl2SJw+nqvQCITQ2+4QSw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Dqhs6ux4; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=en/3zAni; dkim-atps=neutral; spf=pass (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Dqhs6ux4;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=en/3zAni;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKxJd32F4z2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 20:06:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793869599; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KzuDdj62wMjg3lpF2BnQUkUEg1EDpjdGd8wCX/Z54rePmQDGGO0yZpIP1mEFj2KWWR
    Y3WTNtgMGyRlWSYCB3ym67/wbNaHTDhHpSf5ZDf0xhVYZIwIVf6fOzuJPxtoClZcIA6C
    rwQI5cfJKGEDUE989pFYU/Il2q+q9E2gimbXI1HO6TN4KqDLXNCL+SJ9fu8SvhPK2lw8
    zF0hKhLdmNs0APN9byudg2Kb6dJGKhIUFmEPMliU3jDkcRwZO3ntn2eQdMyz8926C/Ol
    PWr/c9s/RRn6QxNX75mA309WjN7j68cDfCQgq5VkvG4cHh0JUl3fY7dWJSqew2Mp808y
    Q7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793869599;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=vdDDMtXuZcI5ST0g2B/YWhJgrol3S1EgLV5st/yxsdo=;
    b=tSKmBlWUo5x386RVHJPhsFS9UxyLnzItZyh9oywUKjJqVTO7sTy30wWsk+qmVsMIZi
    T6rev5UshYXFzE8VLV/KWajr8p0WA8gTTdrjljr2/2rd6/RFn1k5GrXaBG5Lx2kiE5Ej
    5LRcbiGW6GV6ODSBpzs70nxivHbGOsUFXiilerdRzNVCLJaHfZ+0daghLDcjqdtLqTCm
    jglaqb95TBRGP7seEHmMH9WsFRtXOPL22ISAFz8c7zAJSCzkwywC0y9KoGsoeHhf9L9r
    2fXc46pZa85BQnt3CdZHx6YwOc4ULZiXcJphUYQw1VtSeLPkAXg2W8XcQCJxnNSuLzse
    RI/Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793869599;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=vdDDMtXuZcI5ST0g2B/YWhJgrol3S1EgLV5st/yxsdo=;
    b=Dqhs6ux4Wg/WrHZDCrySI24vmjzQgGyBWTIQhn2UX9rWk8VPTb5UnUXBskjxUv6cuL
    EkYBes3e+IhHOCJPYKstOHiB9F1aIGE4D+iBD8xKmnPxmCX/XPLZ7HOvL57SwSDLnIyB
    7QOcpwIJOqvxZwrZ5oBsqvLHj4EiWiJ98tN7cDu5Y8ixt0wopRNKGh9NFTUy6sQBEFkC
    aajNkfapDKXEft9rKz/YXnQNPO/GYXUGuNgbgKBLn33T8SF1nUXONdG1qDIR4qp9PYY8
    mLuaKFxqa/6kzLrHefYR5KbnKV6DrOpW5a0Xu9Koz/mrCsB41c3zOsrSpR1rRSPxaFoB
    GvmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793869599;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=vdDDMtXuZcI5ST0g2B/YWhJgrol3S1EgLV5st/yxsdo=;
    b=en/3zAniDl/LRIYdJeFvnBVq9POSUfDTctQmwnz3zQuR6FUVZFgGH6l0EwGAS1Nuj8
    VxlbZITG9NIuwm3RdpCw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5i1s3mVDnvabcnE8Xz5iRUIWLwPs9mBpLTTaXc="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92A596cO07
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 10:06:38 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christian Zigotzky <chzigotzky@xenosoft.de>
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
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading guest FP and Altivec
Date: Thu, 5 Nov 2026 10:06:27 +0100
Message-Id: <4FED0F6E-890F-4482-99F3-39D7520C48FE@xenosoft.de>
References: <c485c31c-1330-4be2-bb95-447cefa82c1e@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de,
 harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
 venkat88@linux.ibm.com, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <c485c31c-1330-4be2-bb95-447cefa82c1e@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
X-Mailer: iPhone Mail (24B119)
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 02 November 2026 at 2:07 pm, Shrikanth Hegde <sshegde@linux.ibm.com> wrot=
e:

=EF=BB=BFHi.

On 11/1/26 1:58 PM, Christian Zigotzky wrote:

Yes, I can help with testing.

- - -

Thanks Christian.


- - -

Hi all,

Ever since we enabled PREEMPT on our Nemo boards [1], we have been experienc=
ing occasional problems with the kernel stack.

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: s=
rcu_gp_start_if_needed+0x534/0x538
Rebooting in 180 seconds..

We are using the following patches: [2] [3]

We have disabled PREEMPT with a patch [4] again, and since then our Nemo boa=
rds have been running perfectly once more.

As the problem with the kernel stack only occurs sporadically, bisection is i=
mpossible.

I hope you can fix the kernel stack issue.

Thanks,
Christian

[1] https://en.wikipedia.org/wiki/AmigaOne_X1000

[2] https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/pat=
ches/X1000/preempt_v1.patch

[3] https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/pat=
ches/X1000/kvm_powerpc.patch

[4] https://raw.githubusercontent.com/chzigotzky/kernels/refs/heads/main/pat=
ches/X1000/Kconfig.preempt.patch

[5] Kernel config: https://raw.githubusercontent.com/chzigotzky/kernels/31c0=
64092e3aab0875c47d44838443c9515b2970/configs/x1000_defconfig





