Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF43AC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1357D208B3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GcXk6ShA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1357D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YqmG2qrvzF3LF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:29:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GcXk6ShA";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Yqfz08wmzF3KP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:24:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="GcXk6ShA"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Yqfy2h5Hz9s9J;
 Tue, 16 Oct 2018 07:24:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539635082;
 bh=Lz4ij2tyxiZO7V+1Ri/ommqQAIxbC9spWXjAfQr67nQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GcXk6ShAIMFdCPHfBKMVomwqmpgAXuKfZQ2h5o9mZKvDjReEdSQ6mnDGmM7uadtR1
 huBQk0zXsgVj19qckHm3Sic/zLBNoa6590Srog9GbW6CWuoIU5gtPJPvKehkVqN7BJ
 BBuAjTFEvypcuVo1jsphU+QEh0TO0UT4qBq94tzYQALncnCsh+cKgTdo/KOxrwyOHA
 RPBwr3gUcKGlClGrMGrt/B+2d1U0MMfocxkY+NSRMEYV3zlyTAughNeP/bqs6hj/0G
 z+0hEpjhqeu4aCi0/dF0t3mi4WQwXd4xY83qz1pIpBgOtBPBtgb5sGKEciOjplxoAJ
 29U1OEk/ootIg==
Date: Tue, 16 Oct 2018 07:24:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: linux-next: Tree for Oct 15
Message-ID: <20181016072439.42613abd@canb.auug.org.au>
In-Reply-To: <20181016071240.3f62816d@canb.auug.org.au>
References: <20181015192546.15faf3a1@canb.auug.org.au>
 <20181015182637.GA16445@roeck-us.net>
 <20181016071240.3f62816d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hFNmF3Jj0D7c+SX.8sV79qt"; protocol="application/pgp-signature"
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
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/hFNmF3Jj0D7c+SX.8sV79qt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 16 Oct 2018 07:12:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 15 Oct 2018 11:26:37 -0700 Guenter Roeck <linux@roeck-us.net> wro=
te:
> >
> > ALl ppc qemu tests (including big endian pseries) also generate a warni=
ng.
> >=20
> > WARNING: CPU: 0 PID: 0 at mm/memblock.c:1301 .memblock_alloc_range_nid+=
0x20/0x68

That is:

static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
                                        phys_addr_t align, phys_addr_t star=
t,
                                        phys_addr_t end, int nid,
                                        enum memblock_flags flags)
{
       if (WARN_ON_ONCE(!align))
                align =3D SMP_CACHE_BYTES;

Looks like patch

  "memblock: stop using implicit alignment to SMP_CACHE_BYTES"

missed some places ...

> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc7-next-20181015 #1
> > NIP:  c000000000f99198 LR: c000000000f99490 CTR: c000000000bb8364
> > REGS: c000000001217a78 TRAP: 0700   Not tainted  (4.19.0-rc7-next-20181=
015)
> > MSR:  0000000080021000 <CE,ME>  CR: 24000422  XER: 20000000
> > IRQMASK: 1=20
> > GPR00: c000000000f99490 c000000001217d00 c00000000121a500 0000000000000=
0c0=20
> > GPR04: 0000000000000000 0000000000000000 0000000000000000 fffffffffffff=
fff=20
> > GPR08: 0000000000000000 00000000000000c0 0000000000000018 0000000000000=
0b7=20
> > GPR12: 0000000000000040 c000000000fe7840 0000000000000000 0000000000000=
000=20
> > GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> > GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> > GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> > GPR28: c000000000000304 c000000001262088 00000000000000c0 c000000000fea=
500=20
> > NIP [c000000000f99198] .memblock_alloc_range_nid+0x20/0x68
> > LR [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > Call Trace:
> > [c000000001217d00] [c000000002a00000] 0xc000000002a00000 (unreliable)
> > [c000000001217d80] [c000000000f99490] .memblock_alloc_base+0x18/0x48
> > [c000000001217df0] [c000000000f7a274] .allocate_paca_ptrs+0x3c/0x74
> > [c000000001217e70] [c000000000f78bf0] .early_init_devtree+0x288/0x320
> > [c000000001217f10] [c000000000f79b6c] .early_setup+0x80/0x130
> > [c000000001217f90] [c000000000000528] start_here_multiplatform+0x68/0x80

--=20
Cheers,
Stephen Rothwell

--Sig_/hFNmF3Jj0D7c+SX.8sV79qt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvE94cACgkQAVBC80lX
0Gx72Af+J7j/HQpnXqTOaoXhTJfrn/kMP1PLBJQ/AqSa43liPmSQ+1KZ5iDtF6GW
p0+1gQyLCEYwnxadat4Pmfs6iadVo4NUoVshTTps9vx8U0xLxO0xEHTR7fwqsc7E
X4thIt2RlvN5W5ikPWaUqMfvtXiFe+5+sHjyHA5ADyDdmX4TqAM0R27Dw2Wd+VJw
5Iw+zqsK6YLtkQGfLea78o3wvOlqKs9N+h9kPws1Rf0p0bCMDkeBPYtQTHEZM8vr
sgDAFuWcVc1wMkEI11i8tzzwOzKpGRt6lLLmrgPdiQldgbX1DHLJ0w7W6stq3MQN
t+KS1u65FdG3t0Qdfb4YzNMjN0nByQ==
=lsXR
-----END PGP SIGNATURE-----

--Sig_/hFNmF3Jj0D7c+SX.8sV79qt--
