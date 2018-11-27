Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D92C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 00:11:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F6B2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 00:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK5muL8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433khx2x19zDqZb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 11:11:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FK5muL8N";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=f.fainelli@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FK5muL8N"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433kdz39nQzDqcX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 11:08:39 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id 79so361983wmo.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 16:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tp0/MlgxpYV3RW3YBg/REc3475KFn5JRm7LiIM2eJfM=;
 b=FK5muL8N0ZoqBfRlFET5+uUFxG+Ah7wrXc2xTogOsAeXp9qJRFxiQWvLw/a4CROIpx
 6fnmszGELniWjzKj000+45g6gicYTKogAcZFiQwtEnRvHUkLR5ralB4+6noyzL2aPlLk
 tws/v+io6UIDAlEFAMcZb7vPq9lzKOiAkscPaTOEOr8c7/boyrtyo4ArRfJBGFL4uYpx
 bJv02/6XeVjWwVk0H4VlWTIsUuPOLRf27VjscLG+0xoyefRZGlEF88p9I23+H4hCP3ki
 +o/OMU1IeDrUvqizfNAU3aAFp6sjgWlyzjLeWHAICiIaRoWcr3Ax9NlDgYC/ZFnGsKID
 4FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tp0/MlgxpYV3RW3YBg/REc3475KFn5JRm7LiIM2eJfM=;
 b=LHCH8OIOGqBGfRe2cdepbb8zMMH+if4xCWAELOjaCK6aDavkQhUtqy+y9chVi6dNIi
 zzTTq1wp+ztlu42cmxM8SsOa3JU41iS0X8GwKjdeJFZ8JXLpjg+IhMUebGfpQtVDdkJA
 gu98uK7FEOoucIYawV5ob/6NEZDLzZzXrU/ooPQpN7ZK6WdxTynYx5Ob8eHLyLCrROB2
 74j9026WovK83H5H3hhFKMEEEk/BG5tUmN3wakJit8gU0sF2zgYC7Uu06yobh+XLqZPQ
 J5SiJa3E7KvO9J0oLwOHsBUIWL/1GbtWpL33TUmhQyKQTn8CoaooK2oyeS0obUzGrM1B
 mIeQ==
X-Gm-Message-State: AA+aEWYWBb7YlD6XhuxKBX5CuQEUndzWFzLpQHvFh24M85tcMxNxMys1
 +h7+p1DH1Hh7UQlG3A59Tbn/Pzc1
X-Google-Smtp-Source: AJdET5fJ+DdaGMcQlkqMvgPSdR4JakwvOJEdd8x0JKGdWr9bukXzdRLLd4XkHG9h1U2C3PKzIEfGxQ==
X-Received: by 2002:a1c:e354:: with SMTP id a81mr25154404wmh.120.1543277315889; 
 Mon, 26 Nov 2018 16:08:35 -0800 (PST)
Received: from [10.67.49.109] (igp-prod-emp-gw.vpn.broadcom.com.
 [192.19.223.250])
 by smtp.googlemail.com with ESMTPSA id j24sm1768471wrd.86.2018.11.26.16.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Nov 2018 16:08:35 -0800 (PST)
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
To: Guenter Roeck <linux@roeck-us.net>
References: <20181115011125.GA32556@roeck-us.net>
 <29E7A6C0-7829-4650-93C6-7220FECAA6EF@gmail.com>
 <20181115053836.GA7606@roeck-us.net>
 <27ed27d3-220e-963f-7d2c-64df10421580@gmail.com>
 <20181115172535.GA26922@roeck-us.net>
 <5937b814-ca5f-5786-93a1-3334df8c92dc@gmail.com>
 <20181116011656.GA21813@roeck-us.net>
 <ffff966c-d6ae-1487-5269-b86df0824d1c@gmail.com>
 <20181119205050.GA1933@roeck-us.net> <20181123182023.GA10080@roeck-us.net>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <5a13dfac-adcb-b0b2-0114-90f9d1eabe8b@gmail.com>
Date: Mon, 26 Nov 2018 16:08:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123182023.GA10080@roeck-us.net>
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
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, paulus@samba.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+PPC folks

On 11/23/18 10:20 AM, Guenter Roeck wrote:
> On Mon, Nov 19, 2018 at 12:50:50PM -0800, Guenter Roeck wrote:
>> On Mon, Nov 19, 2018 at 10:44:30AM -0800, Florian Fainelli wrote:
>>> On 11/15/18 5:16 PM, Guenter Roeck wrote:
>>>> On Thu, Nov 15, 2018 at 11:48:20AM -0800, Florian Fainelli wrote:
>>>>>
>>>>> OK, would you mind testing this below? It seems to me that 8250_of.c is
>>>>> incompatible with arch/powerpc/kernel/legacy_serial.c and that is what
>>>>> is causing the issue here.
>>>>>
>>>>> diff --git a/drivers/tty/serial/8250/Kconfig
>>>>> b/drivers/tty/serial/8250/Kconfig
>>>>> index d7737dca0e48..21cb14cbd34a 100644
>>>>> --- a/drivers/tty/serial/8250/Kconfig
>>>>> +++ b/drivers/tty/serial/8250/Kconfig
>>>>> @@ -483,7 +483,7 @@ config SERIAL_8250_PXA
>>>>>
>>>>>  config SERIAL_OF_PLATFORM
>>>>>         tristate "Devicetree based probing for 8250 ports"
>>>>> -       depends on SERIAL_8250 && OF
>>>>> +       depends on SERIAL_8250 && OF && !(PPC && PPC_UDBG_16550)
>>>>>         default SERIAL_8250
>>>>>         help
>>>>>           This option is used for all 8250 compatible serial ports that
>>>>
>>>> 44x/virtex5_defconfig has both PPC_UDBG_16550 and SERIAL_OF_PLATFORM enabled
>>>> and fails to boot (or display anything on the console) with this patch applied.
>>>
>>> Thanks for trying, can you either share or provide a link to the mpc85xx
>>> and ml507 qemu command lines that you use? I spent a good chunk of my
>>> time trying to get a kernel to boot but has failed so far.
>>>
>>
> 
> Any update ? I still see the boot failures in next-20181123.

Yes, took most of last week's off sorry for the delay. I have finally
been able to boot a kernel using your instructions, thanks. The problem
is the following call chain:

of_platform_serial_probe()
 -> serial8250_register_8250_port()
    -> up->port.uartclk == 0, return -EINVAL
	-> irq_dispose_mapping()

and then we basically unwind what we just did with
of_platform_serial_probe() including disabling the UART's IRQ, comment
out the irq_dispose_mapping() and you will have a functional console
again. 8250_of.c is clearly not a full replacement for legacy_serial.c
(that was a first attempt), so we need to keep that code around. Making
the depends even more conditional also does not sound too appealing,
because while we have identified mpc85xx as being problematic, who knows
about other platforms. So the best I have that does not involve a revert
is this below.

Ben, Michael, would that sound reasonable to you? It seems to me that
there is a million ways to shoot the legacy_serial 8250 registration in
the foot in any cases, and having CONFIG_SERIAL_OF_PLATFORM just made it
painfully obvious.

diff --git a/arch/powerpc/kernel/legacy_serial.c
b/arch/powerpc/kernel/legacy_serial.c
index 33b34a58fc62..31353a27d714 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -16,7 +16,7 @@
 #include <asm/pci-bridge.h>
 #include <asm/ppc-pci.h>

-#undef DEBUG
+#define DEBUG

 #ifdef DEBUG
 #define DBG(fmt...) do { printk(fmt); } while(0)
@@ -70,6 +70,29 @@ static void tsi_serial_out(struct uart_port *p, int
offset, int value)
                writeb(value, p->membase + offset);
 }

+#ifdef CONFIG_SERIAL_OF_PLATFORM
+static struct property uart_prop = {
+       .value = "disabled",
+       .name = "status",
+       .length = strlen("disabled"),
+};
+
+static void __init disable_uart_node(struct device_node *np)
+{
+       /* To avoid having 8250_of.c attempt to register the same device
+        * and failing to do, and calling irq_dispose_mapping(), just
+        * disable the device_node for now.
+        */
+       of_update_property(np, &uart_prop);
+       pr_info("%s: disabled UART node\n", __func__);
+}
+#else
+static inline int disable_uart_node(struct device_node *np)
+{
+       return 0;
+}
+#endif
+
 static int __init add_legacy_port(struct device_node *np, int want_index,
                                  int iotype, phys_addr_t base,
                                  phys_addr_t taddr, unsigned long irq,
@@ -80,6 +103,8 @@ static int __init add_legacy_port(struct device_node
*np, int want_index,
        u32 shift = 0;
        int index;

+       disable_uart_node(np);
+
        /* get clock freq. if present */
        clk = of_get_property(np, "clock-frequency", NULL);
        if (clk && *clk)



-- 
Florian
