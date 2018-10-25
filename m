Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B231C46475
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 23:09:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220EC20652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 23:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr9wNyRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220EC20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42h2rx0PKLzF3G4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 10:09:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jr9wNyRL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jr9wNyRL"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42h2pF0gFSzF3CS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 10:07:32 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id d10-v6so10969438wrs.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 16:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iW+BSDPGCayLAtBb4vo6T1zUTHVlM51FUOR5Odcbmag=;
 b=Jr9wNyRLZtNr/bZNKyyZkTdnNenk1CQsnEfAPwvV00eDnAGXZlCk/uzk1wH0VNdQdn
 Kzgn7+6EKdzeXgQMtM9lWbCclEGnl/iQdPMi25hgp9FpTRD1cMWKPIt0XbO+om/x4D0B
 PkwZLIND7sHLsH6t4HZhQqANnZlgMzq37mWcm6kVx9x/uXBTuaNUA4VL9Ecgf/L3b21t
 UyCIQkEAZSoD0V9NADuOtte1tz25AOYa+DIl+G8TobwzPHM2i5677Ej8S4cvxlyiEwOx
 E90Lf/n2g1HCW69MEGftWx4Jch+5C41+d3ORv6aOioDIA9sdQvZwv66LwefJ+HfUxkyx
 1otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iW+BSDPGCayLAtBb4vo6T1zUTHVlM51FUOR5Odcbmag=;
 b=RUGofa9iCKOugFQjcc4wkbXc6YM0HYvgklC4rLJUgEoV2SyU0T1qat+yO2RULmH+5E
 wPzHnRsYiHPPuM8++zEbugd0uPe4FcS8LvBaXdTDPOyzrHTt+sn3PF721Vvn/LQ50MIK
 AE1XgYWklY1CdyLZpksaMXiYJ16WP9j0AS5GYuLbQOaY8Z/LpSCl/IvY/f1JYOYBSCfX
 x8yYDvfHNt16JxvO4fTEfAc7KV6AbM5Zf0Zd4ntuQB9UvDv2ZprvmM7dokePRvSUJIpR
 x0bqi1ehrdHMvN/UJIp+a+ucPOFSf61BiQe+kEfWEpvtNfJKGCTPNnry8b2V+gcz9xAD
 mZPw==
X-Gm-Message-State: AGRZ1gLyJfKA4oCu5M9v8DilSQYmtenSL3bCrvhg8R02DakhpsmX8JyG
 NV4pIyhuJrVyEleN5JNK/b0=
X-Google-Smtp-Source: AJdET5dVmZC0WiH7KJ/YHkwPHPC+bNuKtYLKH9LUDifsGdW3kJ1hesp5oBqsFNxmSh9BDkijW8n34g==
X-Received: by 2002:adf:97d3:: with SMTP id
 t19-v6mr3770080wrb.283.1540508849381; 
 Thu, 25 Oct 2018 16:07:29 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id
 b5-v6sm8168756wrr.94.2018.10.25.16.07.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Oct 2018 16:07:28 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
To: Rob Herring <robh@kernel.org>, rppt@linux.ibm.com
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
 <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
 <20181025172935.GA27364@rapoport-lnx>
 <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <1bb3bd63-a88e-b668-ea36-f0f985c0e2b1@gmail.com>
Date: Thu, 25 Oct 2018 16:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-ia64@vger.kernel.org,
 SH-Linux <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, arcml <linux-snps-arc@lists.infradead.org>,
 "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Openrisc <openrisc@lists.librecores.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/25/18 2:13 PM, Rob Herring wrote:
> On Thu, Oct 25, 2018 at 12:30 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>
>> On Thu, Oct 25, 2018 at 08:15:15AM -0500, Rob Herring wrote:
>>> +Ard
>>>
>>> On Thu, Oct 25, 2018 at 4:38 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>>>
>>>> On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
>>>>> On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> While investigating why ARM64 required a ton of objects to be rebuilt
>>>>>> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
>>>>>> because we define __early_init_dt_declare_initrd() differently and we do
>>>>>> that in arch/arm64/include/asm/memory.h which gets included by a fair
>>>>>> amount of other header files, and translation units as well.
>>>>>
>>>>> I scratch my head sometimes as to why some config options rebuild so
>>>>> much stuff. One down, ? to go. :)
>>>>>
>>>>>> Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
>>>>>> systems that generate two kernels: one with the initramfs and one
>>>>>> without. buildroot is one of these build systems, OpenWrt is also
>>>>>> another one that does this.
>>>>>>
>>>>>> This patch series proposes adding an empty initrd.h to satisfy the need
>>>>>> for drivers/of/fdt.c to unconditionally include that file, and moves the
>>>>>> custom __early_init_dt_declare_initrd() definition away from
>>>>>> asm/memory.h
>>>>>>
>>>>>> This cuts the number of objects rebuilds from 1920 down to 26, so a
>>>>>> factor 73 approximately.
>>>>>>
>>>>>> Apologies for the long CC list, please let me know how you would go
>>>>>> about merging that and if another approach would be preferable, e.g:
>>>>>> introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
>>>>>> something like that.
>>>>>
>>>>> There may be a better way as of 4.20 because bootmem is now gone and
>>>>> only memblock is used. This should unify what each arch needs to do
>>>>> with initrd early. We need the physical address early for memblock
>>>>> reserving. Then later on we need the virtual address to access the
>>>>> initrd. Perhaps we should just change initrd_start and initrd_end to
>>>>> physical addresses (or add 2 new variables would be less invasive and
>>>>> allow for different translation than __va()). The sanity checks and
>>>>> memblock reserve could also perhaps be moved to a common location.
>>>>>
>>>>> Alternatively, given arm64 is the only oddball, I'd be fine with an
>>>>> "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
>>>>> __early_init_dt_declare_initrd as long as we have a path to removing
>>>>> it like the above option.
>>>>
>>>> I think arm64 does not have to redefine __early_init_dt_declare_initrd().
>>>> Something like this might be just all we need (completely untested,
>>>> probably it won't even compile):
>>>>
>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>> index 9d9582c..e9ca238 100644
>>>> --- a/arch/arm64/mm/init.c
>>>> +++ b/arch/arm64/mm/init.c
>>>> @@ -62,6 +62,9 @@ s64 memstart_addr __ro_after_init = -1;
>>>>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>>>>
>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>> +
>>>> +static phys_addr_t initrd_start_phys, initrd_end_phys;
>>>> +
>>>>  static int __init early_initrd(char *p)
>>>>  {
>>>>         unsigned long start, size;
>>>> @@ -71,8 +74,8 @@ static int __init early_initrd(char *p)
>>>>         if (*endp == ',') {
>>>>                 size = memparse(endp + 1, NULL);
>>>>
>>>> -               initrd_start = start;
>>>> -               initrd_end = start + size;
>>>> +               initrd_start_phys = start;
>>>> +               initrd_end_phys = end;
>>>>         }
>>>>         return 0;
>>>>  }
>>>> @@ -407,14 +410,27 @@ void __init arm64_memblock_init(void)
>>>>                 memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>>>>         }
>>>>
>>>> -       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
>>>> +       if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
>>>> +           (initrd_start || initrd_start_phys)) {
>>>> +               /*
>>>> +                * FIXME: ensure proper precendence between
>>>> +                * early_initrd and DT when both are present
>>>
>>> Command line takes precedence, so just reverse the order.
>>>
>>>> +                */
>>>> +               if (initrd_start) {
>>>> +                       initrd_start_phys = __phys_to_virt(initrd_start);
>>>> +                       initrd_end_phys = __phys_to_virt(initrd_end);
> 
> BTW, I think you meant virt_to_phys() here?
> 
>>>
>>> AIUI, the original issue was doing the P2V translation was happening
>>> too early and the VA could be wrong if the linear range is adjusted.
>>> So I don't think this would work.
>>
>> Probably things have changed since then, but in the current code there is
>>
>>                 initrd_start = __phys_to_virt(initrd_start);
>>
>> and in between only the code related to CONFIG_RANDOMIZE_BASE, so I believe
>> it's safe to use __phys_to_virt() here as well.
> 
> Here is fine yes, but I believe it was the the phys to virt in the DT
> code before adjusting the linear range that was the problem.

FWIW, I am extracting the ARM implementation that parses the initrd
early command line parameter and the "setup" code doing the page
boundary alignment and memblock checking into a helper into lib/ that
other architectures can re-use. So far, this removes the need for
unicore32, arc and arm to duplicate essentially the same logic.
-- 
Florian
