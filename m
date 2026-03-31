Return-Path: <linuxppc-dev+bounces-19113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C510F9303
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 20:54:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flgMj0ry3z2yjs;
	Wed, 01 Apr 2026 07:54:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774990449;
	cv=none; b=bK6wnaIhDO1441Nlll7ozk3vmm+KST4UonCP2U/7gowHOX1CaRjNdG+cfsxM6R6GOgrXZ3FA46WBC4Ol0eYlrIKHYWYwRpgF4bqswmeZOwLlLqUFwLtVdGQygeCxOI/Hfwk3hy17G0P3Ab6FGESgTQFVnfn0TuV6VPlXB/sgIyAM4ETkcvlisW5vaKLwDcCQVwNNBwPKicpzbnnpZ81NCrwvNcLCOMB3cWq2miU2UBNP0KbJtcSaVTBKxwukq9/ibMohpWnn9P8Ctgvay9tbAdC7OjH8d05Po8/2TBMEaTSuTDciCbf2Z19SYLdNLGN4QNI2ky3a4iEcnHScQ40TYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774990449; c=relaxed/relaxed;
	bh=ZspNX5rs+mbfHqezyzp4ll5OJtm1yyo5L/3asPtSr14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTy4Ge6gbkU6oDVR7Uiqia8ohaEUhgemg8sZu0IFt57Mcsb8r4kKaYsxwSgP31uLCUwLWiVOLgsAO1w/638dD5m34rOMjp90FKd8UAjG39WsrL11sn7TeYpqnHDKeiqJZEc7mpRWVY1mbrKZNwZ/0fpSeLGYanqmLxm16+yOgFV+mv1HJ0JEHRPYF3NYuyeQFwY7GDjqvmi+i0XaedeJDy+9vC/8S/ivC/JZ+FeQpoDw/1T3eL9ZwaVzd4avFq9qEEUy14YVieLuwWA1F4DBYjTsqNO10+aaUco9ro0exhYYZ/FROzk/QGil+ZXEJBQeW9SFzJniT/O9e5xou/F4hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddShxiHr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ddShxiHr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122a; helo=mail-dl1-x122a.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com [IPv6:2607:f8b0:4864:20::122a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flgMg3t1Yz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 07:54:06 +1100 (AEDT)
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1271195d2a7so514388c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774990444; x=1775595244; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZspNX5rs+mbfHqezyzp4ll5OJtm1yyo5L/3asPtSr14=;
        b=ddShxiHrt6aYjVthLqF7vCfJEzvg/tcDXJCsTprvW20dCKBWWLHfKMWY2QwRStFDcq
         DiaFpiv57rgFFUSxA1HHAxVX8936UAUCCXYcQAAg8kFUjYYpZXiERyTharjdCcBKDLO0
         PQtkRZkpVSu0eMxTvLw/NkZ/bC/ItLmx7IGgUJl95cyC2vS/3tj9JljSnEMQDstal1PN
         A0zIZK64OqeaVff35Gn3FnkwVm8Bb2u8FWuQ6tul4egCZ3fqXsEGB2DoXkT+CIF+L/ol
         52Bikf1YH473p60gkjMl8BouqkztarBYn90KpLYKaHzqvPR/j2GU4JTFYhZP+uD+uRPl
         uDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990444; x=1775595244;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZspNX5rs+mbfHqezyzp4ll5OJtm1yyo5L/3asPtSr14=;
        b=RzTUEbnL9GB6sV6hemRXW5h7toOkkTrIVuGoP/VrFz0ka1IjATI4ahMXFzbAchsyY4
         ABGGoiVpuDpsXPqYAtUo1sYub5bSld8TUrU5RgVcn7UAva6NSbpzg8jr8wJcse8HIn/j
         xLJGOxZcQv87JfJx4eP/aJtpZDGhz6+rFsZwbH5QpCENWw0m3MnjOqe9KeF+imGZ1WOq
         FaaS43S/yCYvc0QlumgcqJg0p6g37pHSGOHqZWYwSUOmL3yKasN/18MjgPpONVq9Su1e
         2KS49z5xXwHmYodNOfH8Rfw8srNBLbtk5r2IulaPRV7QrGgqnI/+N7PI+6hKQ/U/kVXY
         FS2w==
X-Forwarded-Encrypted: i=1; AJvYcCV/n6rmNpXTRR5ZOwrYdJuvn62FNzgFGwlyaUTJPuP83yF3LO4/i9XdsdQB1ebmhYfSzbDMD5b18fYDsEg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwqZBow+7P9as+TZXd05q2AljB+WtjOqq05dLE5mddPhpnYdyz9
	YQL+DSlwu+/4p6j1vcWEcnoLzWxGBzt8GcqMtj0hDh+lTJ/OjHWikFs7
X-Gm-Gg: ATEYQzzbJjkX2xw7cvv/RfRY4azw39tFMIxJUzHXjwd3WhQXEJ3X2P8AxMVLHcziLGT
	9oeCpSkJWZVik8XpxuemG1Z1EcLpi3Ot9eIkw4EDCrwJ7MI0UePcFkv/Kej59aWw5HQ8JZD/ZHS
	Jsn2BmQKHtcEC3EBer1632bcEteXCzV6d9YyJJ9S2LJdcNOCZyrr11w6tfKRRW8O072KMuzU+zJ
	NxPQ/CuWQxOrrI9JqK2Xdl7KLaFMFgT5ATgZ2I4+r4HKQQyi0/3ylEDosScKjJwv50g3gWeoQV0
	H/8grkY/8ZcqCt7T4DybIqzn/DoTsCCkpfLB0Cb+2F9eBpxS5hx1XmswNiI5P0N7qFpAILjAWDv
	wpsFjMuGrPJ0vWx68pWWb5YCoP6j+S4KipPY5puJC6mOIww5a/Q793vyf/90M8Su6b/x94uf5BS
	LpmbplnOtiyjkp0AUwBRukR+e+s6EHjJkpdhCn6Q6cCfqHPvnAzmWGn2IsBnSdGFdmUE88tn5Kg
	nA=
X-Received: by 2002:a05:7300:fb8e:b0:2c7:11f2:d072 with SMTP id 5a478bee46e88-2c9323b8c8cmr558693eec.16.1774990443987;
        Tue, 31 Mar 2026 13:54:03 -0700 (PDT)
Received: from [192.168.1.8] (177-4-161-218.user3p.v-tal.net.br. [177.4.161.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c41c1513sm11457738eec.8.2026.03.31.13.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 13:54:03 -0700 (PDT)
Message-ID: <c1aac723-8a60-4b37-9c8b-74b2ea4daebb@gmail.com>
Date: Tue, 31 Mar 2026 17:53:59 -0300
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
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: oe-kbuild-all@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
 <202604010125.AvkWBYKI-lkp@intel.com>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <202604010125.AvkWBYKI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 14:10, kernel test robot wrote:
> Hi Cássio,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 46a6512f4a74dd7b18d9a455669c226843fc49ce]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/C-ssio-Gabriel/ALSA-aoa-i2sbus-clear-stale-prepared-state/20260331-113724
> base:   46a6512f4a74dd7b18d9a455669c226843fc49ce
> patch link:    https://lore.kernel.org/r/20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e%40gmail.com
> patch subject: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010125.AvkWBYKI-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604010125.AvkWBYKI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> sound/aoa/soundbus/i2sbus/pcm.c:760:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
>      760 |         .hw_params =    i2sbus_playback_hw_params,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:760:25: note: (near initialization for 'i2sbus_playback_ops.hw_params')
>    sound/aoa/soundbus/i2sbus/pcm.c:313:12: note: 'i2sbus_playback_hw_params' declared here
>      313 | static int i2sbus_playback_hw_params(struct snd_pcm_substream *substream)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:829:25: error: initialization of 'int (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *)' from incompatible pointer type 'int (*)(struct snd_pcm_substream *)' [-Wincompatible-pointer-types]
>      829 |         .hw_params =    i2sbus_record_hw_params,
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~
>    sound/aoa/soundbus/i2sbus/pcm.c:829:25: note: (near initialization for 'i2sbus_record_ops.hw_params')
>    sound/aoa/soundbus/i2sbus/pcm.c:323:12: note: 'i2sbus_record_hw_params' declared here
>      323 | static int i2sbus_record_hw_params(struct snd_pcm_substream *substream)
>          |            ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +760 sound/aoa/soundbus/i2sbus/pcm.c
> 
>    756	
>    757	static const struct snd_pcm_ops i2sbus_playback_ops = {
>    758		.open =		i2sbus_playback_open,
>    759		.close =	i2sbus_playback_close,
>  > 760		.hw_params =	i2sbus_playback_hw_params,
>    761		.hw_free =	i2sbus_playback_hw_free,
>    762		.prepare =	i2sbus_playback_prepare,
>    763		.trigger =	i2sbus_playback_trigger,
>    764		.pointer =	i2sbus_playback_pointer,
>    765	};
>    766	
> 
Oops my bad!

I had added i2sbus_playback_hw_params(), i2sbus_record_hw_params(),
and the helper they use without the struct snd_pcm_hw_params *params argument
expected by struct snd_pcm_ops.hw_params, which caused the compilation error.

After fixing the callback signatures to match the ALSA API, the file
builds cleanly.

I will send a v2 patch with the proposed fixes.

-- 
Thanks,
Cássio


