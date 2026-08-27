Return-Path: <linuxppc-dev+bounces-26139-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3E0C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:36:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVsHL6HJ6z2xdb;
	Thu, 27 Aug 2026 16:36:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787812590;
	cv=none; b=TDybh/KnoQdhT26rbx027NImQLVswk8GS/VCN7D0RxQ3K/iZQDCZ055zIti4468xuKKfiVrahNR5S/W/jS2mtGJfeMb4irnWyYNh//4nlYuCkyq8hOG9pXetn1RtWCnKdx30l8Pa1Xh8wYpSvFJAY0XioL/4BqAJhXLU2KipZoN904Las3AlAvtJrIC/BHbm8vlahpGth/GrVeVknY/MYaytMjMoKwr3WXbYo8LB3vZMruAprRdNgDKgeOzzdl16c9V2bLQaMUFmj7d+e5ETzoVFY0xFHzFtylQCRyGwvSrK+91dOcd75uPKm+lPUuz5SysFiGjpOFBA1RCcPPxXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787812590; c=relaxed/relaxed;
	bh=wr3+NuyH395H2SxtwXysQTVGt+fboTOYIxBvrlzYmeQ=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=WDsayhxUqSDyoehH6xJ8seyLBz0ovC2IsOCVXmFDFlmSN1yZkyNmuWqvgvNM7qW673AUqd6fWHGSoDNEPjtj2iZV7uD7d016ziPaVbPmjlcpkQKPWsP6wFMke/wuAAg539vUjAbCl3+n1S+qQsqKQothl6i+YJ9y2V3fLd4Q64yAIPia9xFaeublro8wYHoeb4ubMqJBIp3tALCvJz5xF1gGMlgU0W40wUOObbVsAlfehbzrxGHWmH7H0A6HxgyB2DJEluT3f/M0LpKIsist+h21WjpTB+VozQoAXcoqxsz22lTqQmulHJZeviNWn6Pr4p18I1gx+R7fKxtUPTlMOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVsHK4ztYz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:36:29 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63EE62122B;
	Thu, 27 Aug 2026 06:36:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32CF113354;
	Thu, 27 Aug 2026 06:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jon+Cunaj2rlSgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 06:36:25 +0000
Content-Type: multipart/mixed; boundary="------------Fre0lCbe1fbvdz2iSeF0j0tb"
Message-ID: <4ba35195-5421-4c52-bbe5-ed88e15e394d@suse.de>
Date: Thu, 27 Aug 2026 08:36:24 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: drm/mgag200: Fix big-endian support
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: rene@exactco.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Trevor Dickinson <rtd2@xtra.co.nz>, hypexed@yahoo.com.au,
 mad skateman <madskateman@gmail.com>, Christian Zigotzky <info@xenosoft.de>
References: <1fe9c172-c12c-4827-b9a5-2870c45e67af@suse.de>
 <A1B9BBC7-0CBA-45DC-8DA1-EEC6776CDA62@xenosoft.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <A1B9BBC7-0CBA-45DC-8DA1-EEC6776CDA62@xenosoft.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: 63EE62122B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------Fre0lCbe1fbvdz2iSeF0j0tb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Am 26.08.26 um 19:30 schrieb Christian Zigotzky:
> On 26 August 2026 at 05:23 pm, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> ﻿Hi
>
> Could be that we have to enable access to the ROM first. That's why it returns only 0xffff. Does the card display output when you switch on the computer?
>
> Best regards
> Thomas
>
> - - -
>
> Hello Thomas,
>
> No, the card doesn’t display output when I switch on the computer.

Attached you'll find another patch that also enables ROM access in the 
PCI config options.  I took the code out of the old matroxfb driver 
without further testing. Please try and report back on the results.

Best regards
Thomas



>
> Cheers,
> Christian

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


--------------Fre0lCbe1fbvdz2iSeF0j0tb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-v2-mgag200-go-looking-for-PInS-in-the-video-BIOS-ROM.patch"
Content-Disposition: attachment;
 filename*0="0001-v2-mgag200-go-looking-for-PInS-in-the-video-BIOS-ROM.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAxMDFlZTJjMThhNjQxMDE5NzgwOTEwMDZiNzk3YTdjMzI3ZDI5NWZmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5A
c3VzZS5kZT4KRGF0ZTogV2VkLCAyNiBBdWcgMjAyNiAxMTowMzoxMSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIFt2Ml0gbWdhZzIwMDogZ28gbG9va2luZyBmb3IgUEluUyBpbiB0aGUgdmlk
ZW8gQklPUyBST00gb24KIG5vbi14ODYKCi0tLQogZHJpdmVycy9ncHUvZHJtL21nYWcyMDAv
bWdhZzIwMF9nMjAwLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKystLQogMSBmaWxl
IGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9nMjAwLmMgYi9kcml2ZXJzL2dw
dS9kcm0vbWdhZzIwMC9tZ2FnMjAwX2cyMDAuYwppbmRleCA5ZTZiNDYxOGZhZGQuLjU3Zjg3
ZGZkMjZlYyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9n
MjAwLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL21nYWcyMDAvbWdhZzIwMF9nMjAwLmMKQEAg
LTIzOSw3ICsyMzksNyBAQCBzdGF0aWMgdm9pZCBtZ2FnMjAwX2cyMDBfaW50ZXJwcmV0X2Jp
b3Moc3RydWN0IG1nYWcyMDBfZzIwMF9kZXZpY2UgKmcyMDAsCiAJfTsKIAlzdHJ1Y3QgbWdh
X2RldmljZSAqbWRldiA9ICZnMjAwLT5iYXNlOwogCXN0cnVjdCBkcm1fZGV2aWNlICpkZXYg
PSAmbWRldi0+YmFzZTsKLQljb25zdCB1bnNpZ25lZCBjaGFyICpwaW5zOworCWNvbnN0IHVu
c2lnbmVkIGNoYXIgKnBpbnMgPSBOVUxMOwogCXVuc2lnbmVkIGludCBwaW5zX2xlbiwgdmVy
c2lvbjsKIAlpbnQgb2Zmc2V0OwogCWludCB0bXA7CkBAIC0yNTAsMTYgKzI1MCwzNCBAQCBz
dGF0aWMgdm9pZCBtZ2FnMjAwX2cyMDBfaW50ZXJwcmV0X2Jpb3Moc3RydWN0IG1nYWcyMDBf
ZzIwMF9kZXZpY2UgKmcyMDAsCiAJaWYgKG1lbWNtcCgmYmlvc1s0NV0sIG1hdHJveCwgc2l6
ZW9mKG1hdHJveCkpICE9IDApCiAJCXJldHVybjsKIAorI2lmIGRlZmluZWQoQ09ORklHX1g4
NikKIAkvKiBHZXQgdGhlIFBJblMgb2Zmc2V0LiAqLwogCWlmIChzaXplIDwgTUdBX0JJT1Nf
T0ZGU0VUICsgMikKIAkJcmV0dXJuOwogCW9mZnNldCA9IChiaW9zW01HQV9CSU9TX09GRlNF
VCArIDFdIDw8IDgpIHwgYmlvc1tNR0FfQklPU19PRkZTRVRdOworCWlmIChzaXplIDwgb2Zm
c2V0ICsgNikKKwkJcmV0dXJuOwogCiAJLyogR2V0IFBJblMgZGF0YSBzdHJ1Y3R1cmUuICov
CisJcGlucyA9IGJpb3MgKyBvZmZzZXQ7CisjZWxzZQorCS8qCisJICogT24gT3BlbkZpcm13
YXJlIHN5c3RlbXMgKFBQQywgTUlQUywgU1BBUkMpIHRoZSBvZmZzZXQgaXNuJ3Qgc3RvcmVk
CisJICogYXQgdGhlIGVuZCBvZiB0aGUgQklPUyBpbWFnZS4gTG9vayBmb3IgdGhlIFBJblMg
aGVhZGVyIGluc3RlYWQuCisJICovCisJZm9yIChvZmZzZXQgPSAwIDsgb2Zmc2V0IDwgc2l6
ZSAtIDY7ICsrb2Zmc2V0KSB7CisJCWNvbnN0IHVuc2lnbmVkIGNoYXIgKmJ1ZiA9IGJpb3Mg
KyBvZmZzZXQ7CisKKwkJaWYgKGJ1ZlswXSA9PSAweDJlICYmIGJ1ZlsxXSA9PSAweDQxICYm
ICgoYnVmWzJdID09IDY0KSB8fCAoYnVmWzJdID09IDEyOCkpKSB7CisJCQlwaW5zID0gYnVm
OworCQkJYnJlYWs7CisJCX0KKwl9CiAKLQlpZiAoc2l6ZSA8IG9mZnNldCArIDYpCisJaWYg
KCFwaW5zKQogCQlyZXR1cm47Ci0JcGlucyA9IGJpb3MgKyBvZmZzZXQ7CisjZW5kaWYKKwog
CWlmIChwaW5zWzBdID09IDB4MmUgJiYgcGluc1sxXSA9PSAweDQxKSB7CiAJCXZlcnNpb24g
PSBwaW5zWzVdOwogCQlwaW5zX2xlbiA9IHBpbnNbMl07CkBAIC0zMjAsNiArMzM4LDggQEAg
c3RhdGljIHZvaWQgbWdhZzIwMF9nMjAwX2ludGVycHJldF9iaW9zKHN0cnVjdCBtZ2FnMjAw
X2cyMDBfZGV2aWNlICpnMjAwLAogCX0KIH0KIAorI2RlZmluZSBQQ0lfTUdBX09QVElPTl9C
SU9TRU4gMHg0MDAwMDAwMAorCiBzdGF0aWMgdm9pZCBtZ2FnMjAwX2cyMDBfaW5pdF9yZWZj
bGsoc3RydWN0IG1nYWcyMDBfZzIwMF9kZXZpY2UgKmcyMDApCiB7CiAJc3RydWN0IG1nYV9k
ZXZpY2UgKm1kZXYgPSAmZzIwMC0+YmFzZTsKQEAgLTMyOCwxMSArMzQ4LDIwIEBAIHN0YXRp
YyB2b2lkIG1nYWcyMDBfZzIwMF9pbml0X3JlZmNsayhzdHJ1Y3QgbWdhZzIwMF9nMjAwX2Rl
dmljZSAqZzIwMCkKIAl1bnNpZ25lZCBjaGFyIF9faW9tZW0gKnJvbTsKIAl1bnNpZ25lZCBj
aGFyICpiaW9zOwogCXNpemVfdCBzaXplOworCXUzMiBvcHQ7CisJdTMyIGJpb3NiYXNlOwor
CXUzMiBmYmJhc2U7CiAKIAlnMjAwLT5wY2xrX21pbiA9IDUwMDAwOwogCWcyMDAtPnBjbGtf
bWF4ID0gMjMwMDAwOwogCWcyMDAtPnJlZl9jbGsgPSAyNzA1MDsKIAorCXBjaV9yZWFkX2Nv
bmZpZ19kd29yZChwZGV2LCBQQ0lfTUdBX09QVElPTiwgJm9wdCk7CisJcGNpX3dyaXRlX2Nv
bmZpZ19kd29yZChwZGV2LCBQQ0lfTUdBX09QVElPTiwgb3B0IHwgUENJX01HQV9PUFRJT05f
QklPU0VOKTsKKwlwY2lfcmVhZF9jb25maWdfZHdvcmQocGRldiwgUENJX1JPTV9BRERSRVNT
LCAmYmlvc2Jhc2UpOworCXBjaV9yZWFkX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lfQkFTRV9B
RERSRVNTXzAsICZmYmJhc2UpOworCXBjaV93cml0ZV9jb25maWdfZHdvcmQocGRldiwgUENJ
X1JPTV9BRERSRVNTLCAoZmJiYXNlICYgUENJX1JPTV9BRERSRVNTX01BU0spIHwgUENJX1JP
TV9BRERSRVNTX0VOQUJMRSk7CisKIAlyb20gPSBwY2lfbWFwX3JvbShwZGV2LCAmc2l6ZSk7
CiAJaWYgKCFyb20pCiAJCXJldHVybjsKQEAgLTM1MSw2ICszODAsOSBAQCBzdGF0aWMgdm9p
ZCBtZ2FnMjAwX2cyMDBfaW5pdF9yZWZjbGsoc3RydWN0IG1nYWcyMDBfZzIwMF9kZXZpY2Ug
KmcyMDApCiAJdmZyZWUoYmlvcyk7CiBvdXQ6CiAJcGNpX3VubWFwX3JvbShwZGV2LCByb20p
OworCisJcGNpX3dyaXRlX2NvbmZpZ19kd29yZChwZGV2LCBQQ0lfUk9NX0FERFJFU1MsIGJp
b3NiYXNlKTsKKwlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKHBkZXYsIFBDSV9NR0FfT1BUSU9O
LCBvcHQpOwogfQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IG1nYWcyMDBfZGV2aWNlX2Z1bmNz
IG1nYWcyMDBfZzIwMF9kZXZpY2VfZnVuY3MgPSB7Ci0tIAoyLjU1LjAKCg==

--------------Fre0lCbe1fbvdz2iSeF0j0tb--

