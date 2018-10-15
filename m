Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A20C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 08:23:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F2620853
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 08:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I/C2epyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F2620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YWg05jzyzF3Dj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 19:23:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I/C2epyF";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YWbq6C8szF3FF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:20:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="I/C2epyF"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YWbq2L1dz9s3l;
 Mon, 15 Oct 2018 19:20:55 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1539591655;
 bh=ZK02ou1ENqeKBYor7Z4GiZKMX/xD4lC6BEuauhOUpKU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=I/C2epyFU8Ui/bUl9bpto/nM5bjIRpf1uaeW0nFHMMdqFRReK8KGXbPUaQh21C2u7
 LxFE4lyAmPSDxodWYu/STQAIxlDV557wwCIhZFKsFVesWvnzUqNDHm31ngHDe2fLsj
 D1Ffw2FrmRZRh3HVF19Q4UHI0MwoneCnv8xNbRsuYPGwZMCklY0Wo3XFRE4aZ/Ubd2
 +us8C2ENHyochUrJOtArHmoei/l50s/8sP0/sKlP4AYNsDwC85+aWOk0C3PMa+w6ZW
 KKQs0b/ItdbRDwSDyatG/brL14V1spBmisOzDmn/cW3bqIYlVIRGCt+r5mZG6d6Rwp
 YE/kEM3bPEFSg==
Date: Mon, 15 Oct 2018 19:20:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: qemu boot failures with today's linux-next
Message-ID: <20181015192053.12642c96@canb.auug.org.au>
In-Reply-To: <20181015191859.2f600de5@canb.auug.org.au>
References: <20181015191859.2f600de5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vu.At.mRm/vQ+CfwE8pWC90"; protocol="application/pgp-signature"
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/Vu.At.mRm/vQ+CfwE8pWC90
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Oct 2018 19:18:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next tree does not boot in qemu (with kvm or without).
> Here is the (non-kvm) boot log (the kvm one is basically the same):

I should have said that the kernel build is pseries_le_defconfig.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vu.At.mRm/vQ+CfwE8pWC90
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvETeUACgkQAVBC80lX
0GyihAf/T7TG1Jkgu7LYC1xKwuMumSd1BdFvzsE048n6nd/deH1zDnOMS4sEhSHb
XXZEcwtzpYw0QDZnT4VMHsG1nTLOxsfOrZeBxUCF64EN/0Y6yMI5m06sOyl7pb4b
svkshYhvct6YHrocIRIj6fJWQ9diYsAz6IHX6ou17asO9DjKWMU7L9O6S3DF/qVF
QLcQ6rS0J4ksYQtp47UNxfTPpEx2wR1+oG3rjeILwzQYMYxZH7zyZbukPTOBAwRI
Sr+HL16/1wqFs8KiIW7SAqKJNS1KiWIuMOc2AYyc9UU0Bjyr8QknYeCfHCcz1FqA
KwvRdPR02QqxuvFrTbmgq1qpW8LoJg==
=R3Xk
-----END PGP SIGNATURE-----

--Sig_/Vu.At.mRm/vQ+CfwE8pWC90--
