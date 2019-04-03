Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F11C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:19:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532432075E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VtXF0QKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532432075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z8rT14P6zDqKf
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 02:19:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=web.de
 (client-ip=217.72.192.78; helo=mout.web.de;
 envelope-from=markus.elfring@web.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=web.de header.i=@web.de header.b="VtXF0QKv"; 
 dkim-atps=neutral
X-Greylist: delayed 325 seconds by postgrey-1.36 at bilbo;
 Thu, 04 Apr 2019 01:29:39 AEDT
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z7kq2CY9zDqLM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 01:29:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1554301774;
 bh=yLanSsWQDAbT24V98EHzftp/emW8dqpvJFH9gryEI5g=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=VtXF0QKvD6MUGfj3zC/GlpysB+oijZqvRoQqLCukd5yNq16BYfkOmdktXSzmGESP0
 eO9gIZurd1g+3vZVKyO/DnHJOHnTnNNQ1z9tokRLDpiMt7A+Pfp2sKsN+QUm9YeOmb
 dhN+b/toVFExtqPP/zPxemonbkMprrYrjQb6QBck=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.115.60]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNcV4-1hIrnr2KWQ-007FNl; Wed, 03
 Apr 2019 16:23:57 +0200
References: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Subject: Re: [5/7] cpufreq/pasemi: Checking implementation of
 pas_cpufreq_cpu_init()
To: Wen Yang <wen.yang99@zte.com.cn>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c0c9c429-a09f-41ba-611d-123b64e410c8@web.de>
Date: Wed, 3 Apr 2019 16:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554082674-2049-6-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3s/asdTdcxZ1lSGA/kR668i/m0CEywgCZlQOwvwZo4Hh9XSQCuY
 mJvCUhPpP9MraubGwRF8XG8Z2ugPn5bgLOs5u9/GXtrwlnaT83mV3KcURPdf+fiGPtenD7b
 ObletnjW3BV7lQvWMVm+PXYS2k3Iok3yU3+QTr+g9191FtnIrhjlubdZB4UR2jGbojVvP7V
 p8+7Bcz7HULFySZacWJ/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e/QK2+ARoko=:ltND8cKzTB8X3ClUpkbnT/
 U7DRPlfE29DUxeK/C6zLkZAftGhDs5XrEAzCCqOsOjAF+BjhVLqOO22QeNwKiWuFvsWKcWE5B
 WHGFD05h9BxiOd+FDRmVP6lFIOo0AsChVisZ88BYwHoScRmuBuOIGSFKmBEHiCHGRNlFzTn8E
 Nvj6WNSsi3ZvfFsY+mMbhGXAD/3/Clf1lto/63ywBLBst745bBY8bPmF0gM0M/jgt+Ku33yTB
 lY4X9FpBnCG3usYvQR4/Wtc+gxM/Q8ONFJzvo/4uwgb98FnqvsXNmS1FrW6d6XiH0vgfgcbv+
 jajXt2XE24jZo9EVSRQOfChvwKyJMoBWci4OhdDdal/tGOyBcrzL3FIXxN3J7k1uSoRbEsfzm
 t3WDUrlwOXCm681b3BeJTCNTiiXJFnEOq2iOV90qhDQ619p1rfhopzotkMZ5kt/XoiKmUBJvL
 S+CMc8mwFuo+wU/rxv3i/N+AOhAjQ5fvtXRRxmu7L4TremDlYO8nCPSG0rBEeF9yCBYd7kP5P
 wnIYkhUt1HWMvpz3Vm6sfXu85TiCWk6O88XIp+CWwOCFS0kQXs9/qAWUOcnI5PaHo5l8tv+Cg
 QU2YiGwpAXRTiuStUOa1yptc7xK1DXF71vPxTcfqN250/HPk/GjD8s4yuaPgA1ng1YRhuExvC
 Jm+PTAl/zZ4eJZPWp1JC7wP8wDkxr0d3Dt2STJ6Jnuv7EQTv/Pan5TlxPCBc+DfgOpFIyCS2D
 wCXCwMmrcmN1Ra7rbjj4nfu7YO40x+xROQhu1FtWs19hzUvAuOxyLmMCKKKuxIV8kn2sNXSwJ
 HVLfymlKRIlUAQ2kyjy1j60eVGWOfW12ZPtkAHDTXpMt4T+uYDYKv2Et8SWWbQgN/3iWhphC8
 f08xjJIeL9JRJIvr39/scrUba4tkBAY6GEusy/Wsd7pGmtvEpp+9ne1IYXsTcnc7CSpwWTD8P
 dIru2UjCKoQ==
X-Mailman-Approved-At: Thu, 04 Apr 2019 02:18:13 +1100
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

> @@ -146,6 +146,7 @@  static int pas_cpufreq_cpu_init(struct cpufreq_poli=
cy *policy)
>
>  	cpu =3D of_get_cpu_node(policy->cpu, NULL);
>
> +	of_node_put(cpu);
>  	if (!cpu)
>  		goto out;

Can the statement =E2=80=9Creturn -ENODEV=E2=80=9D be nicer as exception h=
andling
in the if branch of this source code place?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/d=
rivers/cpufreq/pasemi-cpufreq.c?id=3Dbf97b82f37c6d90e16de001d0659644c57fa4=
90d#n137

Regards,
Markus
