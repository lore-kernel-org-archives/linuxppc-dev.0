Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA47606A324
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Nov 2026 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sgkkj1uq;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=auce2M9l
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jHTjC2qz8z2yRn;
	Sun, 01 Nov 2026 20:16:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.170 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793524575;
	cv=pass; b=AlKOoYntsfBALxPPSijYfnjN+BA+2LSDKzCJNnOH1TcLnKequy6BEFHQWvYsszam61SSbVAJBp2HqT1+4QiMZEdPdDslmzGxBnMNGeTujJPmiZWGWxzOxipLr/8wXbRdtxHJ/2+CuOYPmnZCORJy/jcQAGzBzD7XQJ11uX304sV/38NDduhLuP0isdDhyAP7ghmduayY36yg8YoAwDSmqT+d/GtbwWv4S7uyOOfzvEeXtNhgt2BQG6x+p+y5oysbojVBY7e5drdBke6N2j65PT+28ECA7xmubYpH2ci52V0YWLm+F9oxqnwq7oURACGQjnmDfXfO0T71vJ8xL/enVg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793524575; c=relaxed/relaxed;
	bh=8g2RT8ZOSnoGGAR+ArF59vBen9DTimqtAvKPyxShy9M=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=gtdcL4uOw2qAHBXzUE7+z3l2xgP83cKd4oXayQ8FHFCb8u1NZgu9IgVAFxeg9p61EGMJuXGI1f+9NQ+vQzQTUOCIkSml9EJtw9961KwySlNse9qyWxILAN3xTETs4JPHMn9WZGUMAYfD/nCOyvciXFKQ4+Shv8NQgCFOClO9mXrEAJ72dTPBZnONBfWU9xoryZnhvHPS7N0Lm0TgReHm0RB/qD1iY1uZARGEU09tK4pDk6P6jtVAvHGk8odzFQPW5N8+VRSux//nfAbgB10UuSC3/2LjqKE3I2f9TyrPdr18zBRfC/Y2BTZJr1KOPHA81tEaPNfR8G46p7O1zOCXig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sgkkj1uq; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=auce2M9l; dkim-atps=neutral; spf=pass (client-ip=81.169.146.170; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p02-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sgkkj1uq;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=auce2M9l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p02-ob.smtp.rzone.de (client-ip=81.169.146.170; helo=mo4-p02-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jHTj70p2sz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Nov 2026 20:16:09 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793524547; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=oboHnIFHx2tvpTFzzKDHEVxesOd9NhN6nWBlYcuh7nEiqshui4OcKC/fsh73xitV7B
    kkuxUp6hqg2zzHepp+NRyonqE1r3YHaHWYLP1WDkOYFbcFMWoIzYGl1F3Tbhkyb5avpo
    re5rCW32MrxLoDY0850r04X1FOhqhw1RtjnVvuTJmp4SWzngVxraU205HFE/JbJcCoh/
    cvvy5qBhuDKHz2irbcnNSYek2OQHHrKyXK5H0BDKep59yJZ0/KNOY1KOlsZX2YJRf1nV
    3XqBuAa3m86+0C4Uyb7Nrb5wXKaeaixS+5I3S0E9CNpQqSTAYqI76W9fUVV/FHQI/Mvp
    0iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793524547;
    s=strato-dkim-0002; d=strato.com;
    h=Date:Message-ID:Subject:From:Cc:To:Cc:Date:From:Subject:Sender;
    bh=8g2RT8ZOSnoGGAR+ArF59vBen9DTimqtAvKPyxShy9M=;
    b=jjxzRQ5pLHqSO+Q3B0hAb444XnTQceEkWqfPntc6n1mmym0HkD4x216taNEYtURQ+q
    9B1FLF/6CVVh5G21oG+Cot1pL4IsbP+OyA8bwBtrchDg5k5JSPtU0Ad7izfcnpwpA6pk
    GIhyNJ8FkD5xt0j9PzeefGRAsvWdtQAQ9+9pcIS6JaAr5Kd0qnT3DmjgGz2+ww3uvpr9
    n6IySoHIFn1mHAbOb7TeONQKTh8ngc7sHG76oNm90kwtXNb6hx2Q57M8w6J4dKerBogz
    8UrF47oMR4NMqkukkRs9Np2xANCGl+x/ZDRRykUVQIUlDOFT/Rt0p174kstKHHvNyfBU
    cTuA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793524547;
    s=strato-dkim-0002; d=xenosoft.de;
    h=Date:Message-ID:Subject:From:Cc:To:Cc:Date:From:Subject:Sender;
    bh=8g2RT8ZOSnoGGAR+ArF59vBen9DTimqtAvKPyxShy9M=;
    b=sgkkj1uqxuJiszBPuzH+GvKLnXgEc6TKyM6M+zjRSotE8JfG9WOYO3wo88MG6cgst4
    VxmvL8OCWYBr7ls4AwhElZibQ51yDmPOw0eoxDYaWcT662/nEGASthJ+NwKG6KI0n2mg
    jYactX9LaqzwQUSph/CMleKx64nn9NiicWY8BR/DzN6rsCAdf4XbfYYXk+O3B313W7VH
    +o2amtR8inPEEaM4WeJz3r/49sJ69+v/WHDiSRRMDwUdRl7myqzyHoR4g6KqqgZbRrjV
    sCdicwG3c7T5M9DZIQlw0aan7vtXRPri+vHvpWt6Q0DJSfpEGIJuN7r/k+VNKJgAL+dQ
    inHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793524547;
    s=strato-dkim-0003; d=xenosoft.de;
    h=Date:Message-ID:Subject:From:Cc:To:Cc:Date:From:Subject:Sender;
    bh=8g2RT8ZOSnoGGAR+ArF59vBen9DTimqtAvKPyxShy9M=;
    b=auce2M9l/v+iXqGMmvYu1N0kHsUqZZL27upCyE0m9nB2o3Z6gkdA2dImIDmQm5JY1S
    /Lkj9Lmo5zdFQazf1UAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+m7xzg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id e825d92A19Fl53U
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Nov 2026 10:15:47 +0100 (CET)
To: zzzccc427@gmail.com
Cc: tiwai@suse.de, perex@perex.cz, linux-sound@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "R.T.Dickinson"
 <rtd2@xtra.co.nz>, mad skateman <madskateman@gmail.com>,
 Damien Stewart <hypexed@yahoo.com.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Void PPC: PulseAudio issue with sound updates 7.4-rc1
Organization: A-EON Open Source
Message-ID: <41a2e39a-5637-8afa-f84f-f79e63b3b56e@xenosoft.de>
Date: Sun, 1 Nov 2026 10:15:47 +0100
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Although PulseAudio recognises the sound cards, it is unable to 
successfully initialise the corresponding output profiles on Void PPC 
since the sound updates 7.4-rc1 [1]. The output via ALSA works.

Tested with the onboard HDA ATI SB sound device, Soundblaster LIVE 
Player 1024 PCI card, AMD HDMI audio and with USB audio. Strangely 
enough Pulseaudio can enable the sound devices on MintPPC32. I think the 
latest sound updates are responsible for the issue on Void PPC.

I bisected last week [2] and ad28d2f607d1792c04531f2c5fd9ac0bf5bdcc9c 
(ALSA: pcm: Serialize and check HW_REFINE ioctls) is the first bad commit.

I was able to revert the first bad commit and this solved the issue. [2]

Then I created a patch for reverting the bad commit. [3]

Could you please check the sound updates 7.4-rc1? [1]

Thanks,
Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75c1cb8178fe84403fd95236ddf21754f0a4156c
[2] https://github.com/chzigotzky/kernels/issues/21
[3] 
https://github.com/chzigotzky/kernels/commit/644ec7c1f2f812d5eb89741e643f742596a49b2d
[4] Screenshots:
      - With the sound updates: 
https://i.ibb.co/675Yjxvd/Kernel-7-4-0-with-sound-updates.png
      - With the patched kernel: 
https://i.ibb.co/9HDrnnm1/Kernel-7-4-0-alpha8-Power-PC-1.png and 
https://i.ibb.co/vx77FdHV/Kernel-7-4-0-alpha8-Power-PC-2.png

-- 
Sent with BrassMonkey 35.0.2 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_35.0.2)


