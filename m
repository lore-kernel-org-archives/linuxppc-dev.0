Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2E606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f1CWSzzD;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ficQJRWs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJnGF2SQFz2xH9;
	Tue, 03 Nov 2026 23:00:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.166 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793707253;
	cv=pass; b=n4IFWRXUentTwh1OfGb9N153841e9IKDrb6EdF+mP8MCHgChELKFYecGI36G2RmIm28FNs+QY6Nn/jS6g83lzhBrrGL0lM3wj/KCeena93M8mhf/MWeJkGBx8SoSVqwVUiCl5Cy0SPdml/pTB/uSqwBDU4EQQ2m/ereKXxFwpirCbFi6OVrCxLB2YJWlmZgIHH2vsEyoP3ZfO75nbi1yBIYpTBm/boZGBoJXMwS56nC+ibb40mugNGnrfmZsvOBiNMKGIpDx6I8oRYZ+tfj2ELEJbopJSdm3f/LSDKi1z4hNVcThakph+kRK3M2ZJvQkv38vCq6VTVHCb9Qam2a6XA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793707253; c=relaxed/relaxed;
	bh=VCfhyFhtjRWlSALaNGPIzNS7a7BQ/PmFXkQDuImDC3M=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=lDVJ39EhqPOm1RT7gH9ia1nOwSQpcKPqAp3OyNMT+xGpCACUyI5B5EF/6NWVXxelY8l40HKFVraCVZwe3Io175+RgUMyhkV7PfBzeFP7NCZdQh5g+Jm4YDbj/aAm70AGe1o24ugeYwW54zc7e+KutttQVUdIHGGDq7vb71+F1ODzGoBs43UbEb/AnXzVIk2i+QpLilY9s4uQsYUcMC8X4H6HGeJ/87fEYqyFoGxCDxCHRWaDNMLkG0Nlz0zvsj9jctIysepdZ8gtxuBgrxp6/GODfxEgmb4mVODlaniB6uJvG+bVGopAkFG/DgFL8UKMCjFwoTwM2aFP61e8rkPOZg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f1CWSzzD; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ficQJRWs; dkim-atps=neutral; spf=pass (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=f1CWSzzD;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ficQJRWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.166; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJnG85kv3z2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 23:00:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793707236; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hb822UotgDoHgAwd+YHuUT7dWmhIMdC2Rhzny8IEs41+qCl/ynV1StASFVv6lhUqrn
    R1ccrq2Kz+VhI6QlSsFtF44sZvh0oyaJvR8C5wwDlZYAl/WL/ZPjJmabInhnc93Z/f0w
    GuVelhmzOrN+TyAArnTtD5ICNXJHsCPJscW1moCN423IndRJW1suGOpsRHVS+7MQ13el
    tTK3mH2crDxfLRw5qni5RcDuNqQPA08R3MBkhwV9YI8hOAIvBdeotZB3Q5UqaYOpacDi
    ZZQGxrD3Bt+AmcVbxwkINcw1jNYLpjlcXyoQvu0VA60dlrcleXof1uQSPddLyagz4r8x
    Zbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793707236;
    s=strato-dkim-0002; d=strato.com;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=VCfhyFhtjRWlSALaNGPIzNS7a7BQ/PmFXkQDuImDC3M=;
    b=lPM1uRPBc+P1rvLO0V+QTTLX0eEEBGTBg+H9Cj4JEMvYC4m2xBpp3rH6r+OficfWE+
    q6Y/w6ZnuzO2AtytZpaZ7uFsi2LgYL4ikSPbykrY/gMuIjmUX5yvZSPSybKsE58hRLMe
    /zEgeUGQ/BoC9XzIDZ9YZhvf5wGeZDlga32j+reUrr69HekBsbynBasZ67eft68hHDnH
    p3ZzL0vbzrDaNJNt7xNNEEfPM1hPWPIQDQNcPbMqcZchoU8ChdhwYVmn6/1zDVObQ6Te
    OWvHR+bOiFNCVvMWW3utw7hyM1eWNFEZ8OIgUC/U6kq6MDPs47N0ty8Pncp5AOy4+KMG
    BubA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793707236;
    s=strato-dkim-0002; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=VCfhyFhtjRWlSALaNGPIzNS7a7BQ/PmFXkQDuImDC3M=;
    b=f1CWSzzD8mIIBROl646y2/jW/lHG3ZqPzVllpm5Ol+xZG1MhSeH/3FceMBPVnPhv1K
    bTxdJnDlZ76rp+Jz2DUAqtN5C1WDbAXszjTpvG12aVugBeif9dvGcrzGn06wjpbd7Tas
    vLvw4lRk0FJE7bHKEJVrmnMEbUhqmyW+BERr0LtnQeOjnHMrV9IFgbqOKbUsUw6gx2CF
    YhkgFK3dlGIVnharK7TDN1lTc4Vr5bV3aX/ONRfwLEEp61YebddDAUu6HJRcxfIaLf3D
    rRTmq16c5Vd4UtT6tOfAZq8wdb+7nflVRihMlVYWrzHgXBLhB3aD3K4ZmxdGyBKUmaTl
    MQuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793707236;
    s=strato-dkim-0003; d=xenosoft.de;
    h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:From:Cc:Date:
    From:Subject:Sender;
    bh=VCfhyFhtjRWlSALaNGPIzNS7a7BQ/PmFXkQDuImDC3M=;
    b=ficQJRWspo9wFofzQl77fjjSscHWH9UNkl97Y7YgWBtS5h50icl0fOgNpF9kaKPEhc
    ZBUdO9vPVQ0tglTiZaDQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6KxrfO5Oh7V7X5jis3jDAXtDOW2DIUk1jJESq0dCA/mrin4I+No="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id e825d92A3C0ZH6G
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 13:00:35 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Date: Tue, 3 Nov 2026 13:00:24 +0100
Message-Id: <BD226162-844C-449D-A486-8888184DEBF0@xenosoft.de>
References: <874idy2wbe.wl-tiwai@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, zzzccc427@gmail.com, perex@perex.cz,
 linux-sound@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>,
 Christian Zigotzky <info@xenosoft.de>
In-Reply-To: <874idy2wbe.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: iPhone Mail (24B119)
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNWANTED_DEVICE_2
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03 November 2026 at 08:44 am, Takashi Iwai <tiwai@suse.de> wrote:

Have you tried changing the call of snd_pcm_hw_refine_with_lock() in
snd_pcm_ioctl_hw_params_compat(), too?  Or check the call in
snd_pcm_hw_refine_old_user(), too.

If it doesn't change even if you replace all callers of
snd_pcm_hw_refine_with_lock() with snd_pcm_hw_refine(), something
wrong in the test itself.


Takashi

- - -

I have tried it and sound works again.

My modifications:

diff -rupN a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
--- a/sound/core/pcm_compat.c	2026-11-01 22:26:31.000000000 +0100
+++ b/sound/core/pcm_compat.c	2026-11-03 10:01:54.228010513 +0100
@@ -252,7 +252,7 @@ static int snd_pcm_ioctl_hw_params_compa
 		return -EFAULT;
 
 	if (refine) {
-		err = snd_pcm_hw_refine_with_lock(substream, data);
+		err = snd_pcm_hw_refine(substream, data);
 		if (err < 0)
 			return err;
 		err = fixup_unreferenced_params(substream, data);
diff -rupN a/sound/core/pcm_native.c b/sound/core/pcm_native.c
--- a/sound/core/pcm_native.c	2026-11-01 22:26:31.000000000 +0100
+++ b/sound/core/pcm_native.c	2026-11-03 10:02:24.836343549 +0100
@@ -932,29 +932,6 @@ static int snd_pcm_hw_params_user(struct
  * this one should be used for ioctls and other external paths instead of
  * direct call of snd_pcm_hw_refine()
  */
-static int snd_pcm_hw_refine_with_lock(struct snd_pcm_substream *substream,
-				       struct snd_pcm_hw_params *params)
-{
-	struct snd_pcm_runtime *runtime;
-	int err;
-
-	if (PCM_RUNTIME_CHECK(substream))
-		return -ENXIO;
-	runtime = substream->runtime;
-	err = snd_pcm_buffer_access_lock(runtime);
-	if (err < 0)
-		return err;
-	err = hw_params_state_check(substream);
-	if (err)
-		goto unlock;
-
-	err = snd_pcm_hw_refine(substream, params);
-
- unlock:
-	snd_pcm_buffer_access_unlock(runtime);
-	return err;
-}
-
 static int snd_pcm_hw_refine_user(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params __user * _params)
 {
@@ -965,7 +942,7 @@ static int snd_pcm_hw_refine_user(struct
 	if (IS_ERR(params))
 		return PTR_ERR(params);
 
-	err = snd_pcm_hw_refine_with_lock(substream, params);
+	err = snd_pcm_hw_refine(substream, params);
 	if (err < 0)
 		return err;
 
@@ -4247,7 +4224,7 @@ static int snd_pcm_hw_refine_old_user(st
 	if (IS_ERR(oparams))
 		return PTR_ERR(oparams);
 	snd_pcm_hw_convert_from_old_params(params, oparams);
-	err = snd_pcm_hw_refine_with_lock(substream, params);
+	err = snd_pcm_hw_refine(substream, params);
 	if (err < 0)
 		return err;

