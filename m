Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76187606A324
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=E7z0B0Sn;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=d9vV+WF0
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJgMq6gP5z2xBK;
	Tue, 03 Nov 2026 18:35:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.52 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793691319;
	cv=pass; b=bgs50IGVIKAmW4BQonEXkZ1HvLg84kNe4MDQO3EvWEcIC289VbFfyVpCMiCmBIs06pKUNb/HpRV1UQOzP4gXhil037Zrp6g0JNjwcKNNnWjyZp0MvwWJi9MqWwPN4BVlfSLB2bHyOI6malVw9h65CKV0aGI0qYYSYzqQURk0J/ZL7lhc5nXnF0zbnOFOkM4FTpD/S6usuKIMAWwU9GCIVHzeDl/fBpo5gMo65JmAAfR21cHh28HSKim4xvkolx/oZ5m4EtcMcDI005cORDEQr1dg9NANnO9RKkbste/mSRFZNiyAujSO94ZZks485UhtgRGLmBbPmDEDA5yiCa9PNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793691319; c=relaxed/relaxed;
	bh=TM508lbDKdcd5EXHHd6B2l1dV60LnDp3fNyOCsxCKYU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=d3jSV9m38BdVO5jLbgvMh6S3b0zbs4Rngjt6+sY05q5Ns0pIQUg6vh8twpFoMp1Oa8Yo/QxoUe8dA6WcBAqeqvCMrNTDCaILqT1ngCyeS91xbgspVoGj5C8B2LHiLBgnifBfSduDBX9cqZytmQKRIMUvxQAp+x7MgDPjwZxU2qu5HKSwhoW9pewItTg/NMiYBYoPi+ty0tmpqnATGHLe4nGDlKK+wLm/uBzhcGiBeDINWHlxaPiKmOT/j9sKc9KlDdG8AgEUBGvJD5XjG7PPvPJcn+MpNhh61fvOrvwbudCDeV0/ePXtzazw1dvnsSjx2NuLWvXudEBmhtrh31m8ZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=E7z0B0Sn; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=d9vV+WF0; dkim-atps=neutral; spf=pass (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=E7z0B0Sn;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=d9vV+WF0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJgMk5plsz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 18:35:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793691303; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i7KOVyWmYVARUJBkUZWvXUfihxkcoikYYlSP2HR+HHflfB8CN42rYJqQ/SkOf/QFAu
    b1KYl8PnL+2ubf7xg2fojTQfRudAOCrrVG0fED5boGYaZXQp4qn5nOugQwhSlmv0U7ZY
    vMny9aDjQGVKzu9W1o15GhHafk4HpIr6uYmpIiAOmDpEUldQfc6QE6j8VeZ43Xgem69c
    gFzuov3X52bGDQcGxRfeQ9YESw4tGrnlZ8gVvjqwSkwc2XJr/lpkOK11OA8H1FHDh132
    NJlyujlOAcCS5DMxuty4ZYDgJcpUeoTs54BEk7d+vv6bxEff2Rbo7wrpMveBn23325SY
    ryaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793691303;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=TM508lbDKdcd5EXHHd6B2l1dV60LnDp3fNyOCsxCKYU=;
    b=XBM8p2wNidmVrloaZ9TmL6VfkGku1sfhVRCm5XUj2yqcQYdK/r5vl0ZPSbCkJ7icF6
    992AxLfbTvGdb19C7zwrMVlYNG65b0TjQLz9IYssfwHyrweuFPB4S3F8gH/EC13I1NLS
    OlOBhaKyV9fUlRVrv/6V/dSP5qIN8QFB4d94nkjOMtuXJb1PyQJT4VxMKLMEV27nb0+X
    eul49MNQsnVbkwdNDzr0hcZ5ywINNqOrZFzEt0hMpsrk4+j9gfkzPB1wx51Vj1uqtz0E
    ljYIznQzxrEb/2a3f2uvDsQkcR73txSC8lpCZrD1oZiTsVbSkytEO6M4PsV3DpVuBfy7
    IY2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793691303;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=TM508lbDKdcd5EXHHd6B2l1dV60LnDp3fNyOCsxCKYU=;
    b=E7z0B0SnK4OAlIVLrvuuKAWUdu0+F1YXkkEU3hP1aeWqHLU+YLK36mfDDQw+m01PYd
    C/7bGHdcX4JbdCT82xPf18Cdg4oHIiiJRE9oMBzqyqatMwGcDel3KeIe7ZFLpfGw8rG1
    pi0zTnicfJiZXieB7M0btFqjNyg88x6Q7l/lKTr5WeZeYyvg2gAMzxLrUt2flDVKtu8s
    R+vPCDyRo0MW0zG7d74tQ3fRF4jJhVXYAARB2MGPLIw9K/LgxzeF5uQ2dZrbxijC6+Xd
    w3T59jP4xWg11yrTZetBzaFoL4S3PeKGL1767JGat9KOhw/ypvY25f3hcpyKCjb0yyWo
    pyVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793691303;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=TM508lbDKdcd5EXHHd6B2l1dV60LnDp3fNyOCsxCKYU=;
    b=d9vV+WF0XyDoAMt2e4rJRd2kJt8kdvr1+sPS0YR0nbvwqkk5yv3virO511TBNWsIlR
    L/4z95T8/JQIXMzU5KDQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jis3jDAXtDOW2DIUk1jJESq0dCA/mrin4I+No="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92A37Z2FaR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 08:35:02 +0100 (CET)
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
Subject: Re: Void PPC: PulseAudio issue with sound updates 7.4-rc1
Date: Tue, 3 Nov 2026 08:34:52 +0100
Message-Id: <DFCEA32C-0340-46B0-BADF-839E8C675FE9@xenosoft.de>
References: <87mrrspo7n.wl-tiwai@suse.de>
Cc: zzzccc427@gmail.com, tiwai@suse.de, perex@perex.cz,
 linux-sound@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <87mrrspo7n.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: iPhone Mail (24B119)
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 01 November 2026 at 04:26 pm, Takashi Iwai <tiwai@suse.de> wrote:

Hm, could you verify whether the below oneliner recovers from your
problem or not?

-- 8< --
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -965,7 +965,8 @@ static int snd_pcm_hw_refine_user(struct snd_pcm_substre=
am *substream,
   if (IS_ERR(params))
       return PTR_ERR(params);

-    err =3D snd_pcm_hw_refine_with_lock(substream, params);
+    //err =3D snd_pcm_hw_refine_with_lock(substream, params);
+    err =3D snd_pcm_hw_refine(substream, params);
   if (err < 0)
       return err;

-- 8< --

If this works, clear this change again, and figure out which check in
snd_pcm_hw_refine_with_lock() gives the error.  The function has three
preliminary checks: PCM_RUNTIME_CHECK(), snd_pcm_buffer_access_lock()
(& unlock()), and hw_parms_state_check.  The first one must be
harmless, and the real problem must be either
snd_pcm_buffer_access_lock() or hw_params_state_check().

```
static int snd_pcm_hw_refine_with_lock(struct snd_pcm_substream *substream,
                      struct snd_pcm_hw_params *params)
{
   struct snd_pcm_runtime *runtime;
   int err;

   if (PCM_RUNTIME_CHECK(substream))
       return -ENXIO;
   runtime =3D substream->runtime;
   err =3D snd_pcm_buffer_access_lock(runtime);
   if (err < 0)
       return err;
   err =3D hw_params_state_check(substream);
   if (err)
       goto unlock;

   err =3D snd_pcm_hw_refine(substream, params);

unlock:
   snd_pcm_buffer_access_unlock(runtime);
   return err;
}
```

OTOH, if the oneliner above doesn't change the behavior, something
else overlooked obviously.

Oh wait, it might be the 32bit compat path?  If so, the call at
snd_pcm_ioctl_hw_params_compat() needs to be tested, instead.


thanks,

Takashi


- - -

Hi Takashi,

Thank you for your patch.

I tested your patch today but unfortunately it doesn=E2=80=99t solve the iss=
ue with PulseAudio on Void PPC.

Thanks for your help,

Christian=


