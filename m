Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12908C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 14:07:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EB920815
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="C6KVoUvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EB920815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ChgF1xF7zDqGk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 01:07:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="C6KVoUvN"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ChdT0rp4zDq6c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 01:06:04 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44ChdJ4fXSz9v6wx;
 Mon,  4 Mar 2019 15:05:56 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=C6KVoUvN; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id OIukQzGi5Mhn; Mon,  4 Mar 2019 15:05:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44ChdJ3Whfz9v6wc;
 Mon,  4 Mar 2019 15:05:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551708356; bh=Lou+LJudD27zNqGZxAvu/t8Cohg/CUFnGxJFrL8eCdM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=C6KVoUvN6Biazcs+pZ4lDVvlOfouSmVlkQdfVrZ81Z+WpOfF/32afBfqn9k5pB53s
 ZH7yNiwtRUvxJG6caaqSdpsRL2zaHaZPgLu3cDxsm5sN+EID1YZBX3mWhWMz7hKXgN
 B3yLu1vs62fEC1kC75AQWKf5i6CRr8BKfwB1PpHQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 34AE38B82A;
 Mon,  4 Mar 2019 15:05:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iYHro5p-Jckz; Mon,  4 Mar 2019 15:05:58 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B02718B84F;
 Mon,  4 Mar 2019 15:05:52 +0100 (CET)
Subject: Re: [PATCH 1/3] add generic builtin command line
To: Daniel Walker <danielwa@cisco.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1551469472-53043-2-git-send-email-danielwa@cisco.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <701a46a6-57e6-f8c7-1fee-18c50e72c38c@c-s.fr>
Date: Mon, 4 Mar 2019 15:05:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551469472-53043-2-git-send-email-danielwa@cisco.com>
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
Cc: Maksym Kokhan <maksym.kokhan@globallogic.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, xe-linux-external@cisco.com,
 Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 01/03/2019 à 20:44, Daniel Walker a écrit :
> This code allows architectures to use a generic builtin command line.
> The state of the builtin command line options across architecture is
> diverse. On x86 and mips they have pretty much the same code and the
> code prepends the builtin command line onto the boot loader provided
> one. On powerpc there is only a builtin override and nothing else.
> 
> The code in this commit unifies the mips and x86 code into a generic
> header file under the CONFIG_GENERIC_CMDLINE option. When this
> option is enabled the architecture can call the cmdline_add_builtin()
> to add the builtin command line.
> 
> [maksym.kokhan@globallogic.com: fix cmdline_add_builtin() macro]
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Daniel Walker <danielwa@cisco.com>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> ---
>   include/linux/cmdline.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
>   init/Kconfig            | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+)
>   create mode 100644 include/linux/cmdline.h
> 
> diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> new file mode 100644
> index 000000000000..126fa52f55d2
> --- /dev/null
> +++ b/include/linux/cmdline.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CMDLINE_H
> +#define _LINUX_CMDLINE_H
> +
> +/*
> + *
> + * Copyright (C) 2015. Cisco Systems, Inc.
> + *
> + * Generic Append/Prepend cmdline support.
> + */
> +
> +#if defined(CONFIG_GENERIC_CMDLINE) && defined(CONFIG_CMDLINE_BOOL)
> +
> +#ifndef CONFIG_CMDLINE_OVERRIDE
> +/*
> + * This function will append or prepend a builtin command line to the command
> + * line provided by the bootloader. Kconfig options can be used to alter
> + * the behavior of this builtin command line.
> + * @dest: The destination of the final appended/prepended string
> + * @src: The starting string or NULL if there isn't one.
> + * @tmp: temporary space used for prepending
> + * @length: the maximum length of the strings above.
> + */
> +static inline void
> +_cmdline_add_builtin(char *dest, char *src, char *tmp, unsigned long length)
> +{
> +	if (src != dest && src != NULL) {
> +		strlcpy(dest, " ", length);

Why prepend a space here ?

> +		strlcat(dest, src, length);
> +	}
> +
> +	strlcat(dest, " ", length);

Why a space here ? When there is nothing to append, there is no need of 
a space here. The space could simply be concatenated below in from of 
CONFIG_CMDLINE_APPEND

> +
> +	if (sizeof(CONFIG_CMDLINE_APPEND) > 1)
> +		strlcat(dest, CONFIG_CMDLINE_APPEND, length);
> +
> +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {
> +		strlcpy(tmp, CONFIG_CMDLINE_PREPEND, length);
> +		strlcat(tmp, " ", length);

Why not concatenate the space to above, ie:
strlcpy(tmp, CONFIG_CMDLINE_PREPEND " ", length);

> +		strlcat(tmp, dest, length);
> +		strlcpy(dest, tmp, length);
> +	}
> +}
> +
> +#define cmdline_add_builtin_section(dest, src, length, section) 	    \
> +{									    \
> +	if (sizeof(CONFIG_CMDLINE_PREPEND) > 1) {			    \
> +		static char cmdline_tmp_space[length] section;	            \
> +		_cmdline_add_builtin(dest, src, cmdline_tmp_space, length); \
> +	} else {							    \
> +		_cmdline_add_builtin(dest, src, NULL, length);		    \
> +	}								    \
> +}
> +#else
> +#define cmdline_add_builtin_section(dest, src, length, section) 	   \
> +{									   \
> +	strlcpy(dest, CONFIG_CMDLINE_PREPEND " " CONFIG_CMDLINE_APPEND,    \
> +		length);						   \
> +}
> +#endif /* !CONFIG_CMDLINE_OVERRIDE */
> +
> +#else
> +#define cmdline_add_builtin_section(dest, src, length, section) {          \
> +	if (src != NULL)						   \
> +		strlcpy(dest, src, length);				   \
> +}
> +#endif /* CONFIG_GENERIC_CMDLINE */
> +
> +#define cmdline_add_builtin(dest, src, length) \
> +	cmdline_add_builtin_section(dest, src, length, __initdata)

All those ifdefs are uggly, I don't think it is worth making something 
so complex just for the fun of getting something generic. See my 
comments to following patch.

> +
> +#endif /* _LINUX_CMDLINE_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index a4112e95724a..b59e856511e1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1775,6 +1775,75 @@ config PROFILING
>   config TRACEPOINTS
>   	bool
>   
> +config GENERIC_CMDLINE
> +	bool
> +
> +if GENERIC_CMDLINE
> +
> +config CMDLINE_BOOL
> +	bool "Built-in kernel command line"
> +	help
> +	  Allow for specifying boot arguments to the kernel at
> +	  build time.  On some systems (e.g. embedded ones), it is
> +	  necessary or convenient to provide some or all of the
> +	  kernel boot arguments with the kernel itself (that is,
> +	  to not rely on the boot loader to provide them.)
> +
> +	  To compile command line arguments into the kernel,
> +	  set this option to 'Y', then fill in the
> +	  the boot arguments in CONFIG_CMDLINE.
> +
> +	  Systems with fully functional boot loaders (i.e. non-embedded)
> +	  should leave this option set to 'N'.
> +
> +config CMDLINE_APPEND
> +	string "Built-in kernel command string append"
> +	depends on CMDLINE_BOOL

Would be better to remove this 'depends' and put the condition on the 
previous line. That way we would always have CONFIG_CMDLINE_APPEND and 
we could do something more simple in the code.

> +	default ""
> +	help
> +	  Enter arguments here that should be compiled into the kernel
> +	  image and used at boot time.  If the boot loader provides a
> +	  command line at boot time, this string is appended to it to
> +	  form the full kernel command line, when the system boots.
> +
> +	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
> +	  change this behavior.
> +
> +	  In most cases, the command line (whether built-in or provided
> +	  by the boot loader) should specify the device for the root
> +	  file system.
> +
> +config CMDLINE_PREPEND
> +	string "Built-in kernel command string prepend"
> +	depends on CMDLINE_BOOL

Would be better to remove this 'depends' and put the condition on the 
previous line. That way we would always have CONFIG_CMDLINE_APPEND and 
we could do something more simple in the code.

> +	default ""
> +	help
> +	  Enter arguments here that should be compiled into the kernel
> +	  image and used at boot time.  If the boot loader provides a
> +	  command line at boot time, this string is prepended to it to
> +	  form the full kernel command line, when the system boots.
> +
> +	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
> +	  change this behavior.
> +
> +	  In most cases, the command line (whether built-in or provided
> +	  by the boot loader) should specify the device for the root
> +	  file system.
> +
> +config CMDLINE_OVERRIDE
> +	bool "Built-in command line overrides boot loader arguments"
> +	depends on CMDLINE_BOOL
> +	help
> +	  Set this option to 'Y' to have the kernel ignore the boot loader
> +	  command line, and use ONLY the built-in command line. In this case
> +	  append and prepend strings are concatenated to form the full
> +	  command line.
> +
> +	  This is used to work around broken boot loaders.  This should
> +	  be set to 'N' under normal conditions.
> +
> +endif
> +
>   endmenu		# General setup
>   
>   source "arch/Kconfig"
> 

Christophe
