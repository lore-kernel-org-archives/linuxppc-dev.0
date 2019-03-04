Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9B6C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 15:06:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66FC20652
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="SxONxBvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66FC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Cjyp4kPBzDqFs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 02:06:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="SxONxBvq"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CjwY5ps2zDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 02:04:11 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44CjwL3K0Lz9v3wB;
 Mon,  4 Mar 2019 16:04:02 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=SxONxBvq; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id yXMrt4PNNLgl; Mon,  4 Mar 2019 16:04:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44CjwL203Lz9v3w6;
 Mon,  4 Mar 2019 16:04:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551711842; bh=92efqIII1m7NjH5jcLZNO5M4YNnSbDn3Ww6Ka1xur18=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=SxONxBvqKjaMHrgEEMOP5iF6fWsRnn4HA9HlSwv3VNdaUYemKog5EiQPsqDIsp4ad
 LLfg2OIYQX//0sEA/dWTD1A0J/ZI/4N0c+HcRFvk2ZCqPWdMkm9MY1v8UC6kNGq0ux
 /dIZ6hBA6c9519O682tyQeqrp+Hei4yhTrvv78sM=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 43FDA8B781;
 Mon,  4 Mar 2019 16:04:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id FrcXbpwrxjiZ; Mon,  4 Mar 2019 16:04:07 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 026EC8B768;
 Mon,  4 Mar 2019 16:04:06 +0100 (CET)
Subject: Re: [PATCH 2/3] powerpc: convert to generic builtin command line
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Daniel Walker <danielwa@cisco.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1551469472-53043-3-git-send-email-danielwa@cisco.com>
 <e6dc6500-0e33-da0c-c975-0d9125e38c0e@c-s.fr>
Message-ID: <e5d14f74-0715-bd8b-00a0-8cbe8bcdd030@c-s.fr>
Date: Mon, 4 Mar 2019 16:04:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <e6dc6500-0e33-da0c-c975-0d9125e38c0e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
 Maksym Kokhan <maksym.kokhan@globallogic.com>,
 Daniel Walker <dwalker@fifo99.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 04/03/2019 à 15:26, Christophe Leroy a écrit :
> 
> 
> Le 01/03/2019 à 20:44, Daniel Walker a écrit :
>> This updates the powerpc code to use the CONFIG_GENERIC_CMDLINE
>> option.
> 
> Please explain more in details how each powerpc option is replaced by 
> one of the generic options.
> 
>>
>> [maksym.kokhan@globallogic.com: add strlcat to prom_init_check.sh
>> whitelist]
>> Cc: Daniel Walker <dwalker@fifo99.com>
>> Cc: Daniel Walker <danielwa@cisco.com>
>> Cc: xe-linux-external@cisco.com
>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
>> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
>> ---
>>   arch/powerpc/Kconfig                   | 23 +----------------------
>>   arch/powerpc/kernel/prom.c             |  4 ++++
>>   arch/powerpc/kernel/prom_init.c        |  8 ++++----
>>   arch/powerpc/kernel/prom_init_check.sh |  2 +-
>>   4 files changed, 10 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 8be31261aec8..6321b2a0b87b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -172,6 +172,7 @@ config PPC
>>       select GENERIC_STRNCPY_FROM_USER
>>       select GENERIC_STRNLEN_USER
>>       select GENERIC_TIME_VSYSCALL
>> +    select GENERIC_CMDLINE
>>       select HAVE_ARCH_AUDITSYSCALL
>>       select HAVE_ARCH_JUMP_LABEL
>>       select HAVE_ARCH_KGDB
>> @@ -777,28 +778,6 @@ config PPC_DENORMALISATION
>>         Add support for handling denormalisation of single precision
>>         values.  Useful for bare metal only.  If unsure say Y here.
>> -config CMDLINE_BOOL
>> -    bool "Default bootloader kernel arguments"
>> -
>> -config CMDLINE
>> -    string "Initial kernel command string"
>> -    depends on CMDLINE_BOOL
>> -    default "console=ttyS0,9600 console=tty0 root=/dev/sda2"
>> -    help
>> -      On some platforms, there is currently no way for the boot 
>> loader to
>> -      pass arguments to the kernel. For these platforms, you can supply
>> -      some command-line options at build time by entering them here.  In
>> -      most cases you will need to specify the root device here.
>> -
>> -config CMDLINE_FORCE
>> -    bool "Always use the default kernel command string"
>> -    depends on CMDLINE_BOOL
>> -    help
>> -      Always use the default kernel command string, even if the boot
>> -      loader passes other arguments to the kernel.
>> -      This is useful if you cannot or don't want to change the
>> -      command-line options your boot loader passes to the kernel.
>> -
>>   config EXTRA_TARGETS
>>       string "Additional default image types"
>>       help
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index fe758cedb93f..d78b1d6fe1c8 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/libfdt.h>
>>   #include <linux/cpu.h>
>> +#include <linux/cmdline.h>
>>   #include <asm/prom.h>
>>   #include <asm/rtas.h>
>> @@ -716,6 +717,9 @@ void __init early_init_devtree(void *params)
>>        */
>>       of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
>> +    /* append and prepend any arguments built into the kernel. */
>> +    cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);
>> +
> 
> I don't think it is worth an implementation as complex as in the 
> previous patch just for the above line.
> Could easily define the temporary buffer in this file directely, then 
> just locally do:
> 
> strlcpy(temp_buff, CONFIG_CMDLINE_PREPEND, COMMAND_LINE_SIZE);
> strlcat(temp_buff, boot_command_line, COMMAND_LINE_SIZE);
> strlcat(temp_buff, CONFIG_CMDLINE_APPEND, COMMAND_LINE_SIZE);
> strlcpy(boot_command_line, temp_buff, COMMAND_LINE_SIZE);

And in fact, what should really be done is not the above but simply 
update early_init_dt_scan_chosen_ppc() in drivers/of/fdt.c as it is 
there that CONFIG_CMDLINE and CONFIG_CMDLINE_FORCE and 
CONFIG_CMDLINE_EXTEND are handled.

It looks to me that the current implementation is rather complete and 
eventually only missing the prepend. Why not just add prepend to the 
current implementation, and also move CONFIG_CMDLINE etc ... into 
arch/Kconfig instead of having it in each arch ?

Christophe

> 
> 
> 
>>       /* Scan memory nodes and rebuild MEMBLOCKs */
>>       of_scan_flat_dt(early_init_dt_scan_root, NULL);
>>       of_scan_flat_dt(early_init_dt_scan_memory_ppc, NULL);
>> diff --git a/arch/powerpc/kernel/prom_init.c 
>> b/arch/powerpc/kernel/prom_init.c
>> index f33ff4163a51..e8e9fca22470 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/initrd.h>
>>   #include <linux/bitops.h>
>> +#include <linux/cmdline.h>
>>   #include <asm/prom.h>
>>   #include <asm/rtas.h>
>>   #include <asm/page.h>
>> @@ -637,11 +638,10 @@ static void __init early_cmdline_parse(void)
>>       p = prom_cmd_line;
>>       if ((long)prom.chosen > 0)
>>           l = prom_getprop(prom.chosen, "bootargs", p, 
>> COMMAND_LINE_SIZE-1);
>> -#ifdef CONFIG_CMDLINE
>> +
>>       if (l <= 0 || p[0] == '\0') /* dbl check */
>> -        strlcpy(prom_cmd_line,
>> -            CONFIG_CMDLINE, sizeof(prom_cmd_line));
>> -#endif /* CONFIG_CMDLINE */
>> +        cmdline_add_builtin_section(prom_cmd_line, NULL, 
>> sizeof(prom_cmd_line), __prombss);
>> +
> 
> You don't need something as complex as what your generic code does for 
> that. It could be done with the following simple line:
> 
> strlcpy(prom_cmd_line, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND, 
> sizeof(prom_cmd_line));
> 
>>       prom_printf("command line: %s\n", prom_cmd_line);
>>   #ifdef CONFIG_PPC64
>> diff --git a/arch/powerpc/kernel/prom_init_check.sh 
>> b/arch/powerpc/kernel/prom_init_check.sh
>> index 667df97d2595..ab2acc8d8b5a 100644
>> --- a/arch/powerpc/kernel/prom_init_check.sh
>> +++ b/arch/powerpc/kernel/prom_init_check.sh
>> @@ -18,7 +18,7 @@
>>   WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
>>   _end enter_prom memcpy memset reloc_offset __secondary_hold
>> -__secondary_hold_acknowledge __secondary_hold_spinloop __start
>> +__secondary_hold_acknowledge __secondary_hold_spinloop __start strlcat
> 
> The above is a big issue. In the scope of KASAN implementation, we are 
> getting rid of generic string functions from prom_init because they are 
> KASAN instrumented and that's far too early for prom_init. See series 
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=94949 and 
> especially patch [v9,03/11] powerpc/prom_init: don't use string 
> functions from lib/
> 
>>   strcmp strcpy strlcpy strlen strncmp strstr kstrtobool 
>> logo_linux_clut224
>>   reloc_got2 kernstart_addr memstart_addr linux_banner _stext
>>   __prom_init_toc_start __prom_init_toc_end btext_setup_display TOC."
>>
> 
> Thanks
> Christophe
