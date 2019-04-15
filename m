Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 01:23:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49FF20833
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 01:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlrXYO3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49FF20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j9kB1y6rzDqLR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 11:23:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j9hR2tTQzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 11:21:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QlrXYO3T"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44j9hQ5Kqfz8tPV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 11:21:58 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44j9hQ4yzQz9s55; Mon, 15 Apr 2019 11:21:58 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="QlrXYO3T"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44j9hQ0dS6z9s00
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Apr 2019 11:21:57 +1000 (AEST)
Received: by mail-it1-x141.google.com with SMTP id y204so24480591itf.3
 for <linuxppc-dev@ozlabs.org>; Sun, 14 Apr 2019 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dT5KCQPOQ40/DBXcBzQNv9IABesG5pJ7yaEp0Hg5BmA=;
 b=QlrXYO3Tap+auMOLivAQLvsscN8U51I96Eix6eRJTNUOwoMHfxG8EFsz1JESq5P9I0
 tU4HSLElnjc/9omlBsfpSKJIhXVhIcJ4Uln42xk7soolY4Xoa812N1Vycc/B/fZA/i0+
 12HovchI7vVukbgLc65Q28TrI42H9LErdYmt7miqblqFaDTAGJjCHw2hRBC4YOiNE/Gl
 K40UIA1i3O/Au0D2qMnuz3/v/miQNLQSweChx2aLLKIy3lkxIPCgI9xW3m9Qc3/a0+ot
 8MG73y1hadLwPQz3SBbT0y4xMhJUkiT/GXNjhyJT0n0C/KbzRaexUFGVEhF/3ady36J8
 Xrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dT5KCQPOQ40/DBXcBzQNv9IABesG5pJ7yaEp0Hg5BmA=;
 b=I3q6QEsVZXk7HJiZSyG9CRyM/cUCGvhRT90iE8t8v7obtXM3XjG3s/sQkSMoYYcfQn
 G1z3jSjejC1yqRQA5KzfNzkYsdPSRI12gFYz9mx4dtVsHb4usGSUrDcxbGUk56WHG0EN
 EBc7U9pI/cosSFKnqrXLnZkwRUMVP6KBywkiO9RKoPUbEqwXZVcQIrS0Fs7ceGDGxqV+
 SHID7zCAKWAYm+nK1icSSepB1BJKEhiN2BfeiFiHOvKHJIuuFVS/I48NpPQkORjQbCCJ
 0plkoATR7eDkeckLoJH5w18+DswklSoJs4/3NJWNj3LsgirtUJz5Z4xGyL0eqbxdr5bE
 frQA==
X-Gm-Message-State: APjAAAXXZw3Fxg36Pf45f8Hpip2kt4/+TaUeBi81D4mFgsnPgYKlY3F+
 2YS05lRQwBULRKFjw8SWvur3M+/+Pa8QD3oc6c4=
X-Google-Smtp-Source: APXvYqwxJ6M1CiQkt0LeHoATCtaXNelzJDFR5pKWoGSKabIU33B9p6N5oKYEl/0hR8KPm+INTes98ZnO7CloQWfLyqY=
X-Received: by 2002:a05:660c:fcc:: with SMTP id
 m12mr24191333itn.58.1555291314791; 
 Sun, 14 Apr 2019 18:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190415001923.21108-1-cmr@informatik.wtf>
In-Reply-To: <20190415001923.21108-1-cmr@informatik.wtf>
From: Oliver <oohall@gmail.com>
Date: Mon, 15 Apr 2019 11:21:43 +1000
Message-ID: <CAOSf1CH-1MTtUCHDNY4z3+1DLYgTmqFZxpG9eAMAq4pJKqqeCg@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/xmon: add read-only mode
To: "Christopher M. Riedl" <cmr@informatik.wtf>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev@ozlabs.org, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 15, 2019 at 10:17 AM Christopher M. Riedl
<cmr@informatik.wtf> wrote:
>
> Operations which write to memory and special purpose registers should be
> restricted on systems with integrity guarantees (such as Secure Boot)
> and, optionally, to avoid self-destructive behaviors.
>
> Add a config option, XMON_DEFAULT_RO_MODE, to set default xmon behavior.
> The kernel cmdline options xmon=ro and xmon=rw override this default.
>
> The following xmon operations are affected:
> memops:
>         disable memmove
>         disable memset
>         disable memzcan
> memex:
>         no-op'd mwrite
> super_regs:
>         no-op'd write_spr
> bpt_cmds:
>         disable
> proc_call:
>         disable
>
> Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> ---
>
> v2->v3:
>         Use XMON_DEFAULT_RO_MODE to set xmon read-only mode
>         Untangle read-only mode from STRICT_KERNEL_RWX and PAGE_KERNEL_ROX
>         Update printed msg string for write ops in read-only mode

Making PAGE_KERNEL_ROX the default in more cases is still a good idea.
Feel free to send a follow up patch if you want to keep pulling on
that thread.

>  arch/powerpc/Kconfig.debug |  8 ++++++++
>  arch/powerpc/xmon/xmon.c   | 42 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..8de4823dfb86 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -117,6 +117,14 @@ config XMON_DISASSEMBLY
>           to say Y here, unless you're building for a memory-constrained
>           system.
>
> +config XMON_DEFAULT_RO_MODE
> +       bool "Restrict xmon to read-only operations"
> +       depends on XMON
> +       default y
> +       help
> +          Operate xmon in read-only mode. The cmdline options 'xmon=rw' and
> +          'xmon=ro' override this default.
> +
>  config DEBUGGER
>         bool
>         depends on KGDB || XMON
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index a0f44f992360..ce98c8049eb6 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -80,6 +80,7 @@ static int set_indicator_token = RTAS_UNKNOWN_SERVICE;
>  #endif
>  static unsigned long in_xmon __read_mostly = 0;
>  static int xmon_on = IS_ENABLED(CONFIG_XMON_DEFAULT);
> +static bool xmon_is_ro = IS_ENABLED(CONFIG_XMON_DEFAULT_RO_MODE);
>
>  static unsigned long adrs;
>  static int size = 1;
> @@ -202,6 +203,8 @@ static void dump_tlb_book3e(void);
>  #define GETWORD(v)     (((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
>  #endif
>
> +static const char *xmon_ro_msg = "Operation disabled: xmon in read-only mode\n";
> +
>  static char *help_string = "\
>  Commands:\n\
>    b    show breakpoints\n\
> @@ -989,6 +992,10 @@ cmds(struct pt_regs *excp)
>                                 memlocate();
>                                 break;
>                         case 'z':
> +                               if (xmon_is_ro) {
> +                                       printf(xmon_ro_msg);
> +                                       break;
> +                               }
>                                 memzcan();
>                                 break;
>                         case 'i':
> @@ -1042,6 +1049,10 @@ cmds(struct pt_regs *excp)
>                         set_lpp_cmd();
>                         break;
>                 case 'b':
> +                       if (xmon_is_ro) {
> +                               printf(xmon_ro_msg);
> +                               break;
> +                       }
>                         bpt_cmds();
>                         break;
>                 case 'C':
> @@ -1055,6 +1066,10 @@ cmds(struct pt_regs *excp)
>                         bootcmds();
>                         break;
>                 case 'p':
> +                       if (xmon_is_ro) {
> +                               printf(xmon_ro_msg);
> +                               break;
> +                       }
>                         proccall();
>                         break;
>                 case 'P':
> @@ -1777,6 +1792,11 @@ read_spr(int n, unsigned long *vp)
>  static void
>  write_spr(int n, unsigned long val)
>  {
> +       if (xmon_is_ro) {
> +               printf(xmon_ro_msg);
> +               return;
> +       }
> +
>         if (setjmp(bus_error_jmp) == 0) {
>                 catch_spr_faults = 1;
>                 sync();
> @@ -2016,6 +2036,12 @@ mwrite(unsigned long adrs, void *buf, int size)
>         char *p, *q;
>
>         n = 0;
> +
> +       if (xmon_is_ro) {
> +               printf(xmon_ro_msg);
> +               return n;
> +       }
> +
>         if (setjmp(bus_error_jmp) == 0) {
>                 catch_memory_errors = 1;
>                 sync();
> @@ -2884,9 +2910,17 @@ memops(int cmd)
>         scanhex((void *)&mcount);
>         switch( cmd ){
>         case 'm':
> +               if (xmon_is_ro) {
> +                       printf(xmon_ro_msg);
> +                       break;
> +               }
>                 memmove((void *)mdest, (void *)msrc, mcount);
>                 break;
>         case 's':
> +               if (xmon_is_ro) {
> +                       printf(xmon_ro_msg);
> +                       break;
> +               }
>                 memset((void *)mdest, mval, mcount);
>                 break;
>         case 'd':
> @@ -3796,6 +3830,14 @@ static int __init early_parse_xmon(char *p)
>         } else if (strncmp(p, "on", 2) == 0) {
>                 xmon_init(1);
>                 xmon_on = 1;
> +       } else if (strncmp(p, "rw", 2) == 0) {
> +               xmon_init(1);
> +               xmon_on = 1;
> +               xmon_is_ro = false;
> +       } else if (strncmp(p, "ro", 2) == 0) {
> +               xmon_init(1);
> +               xmon_on = 1;
> +               xmon_is_ro = true;
>         } else if (strncmp(p, "off", 3) == 0)
>                 xmon_on = 0;
>         else
> --
> 2.21.0
>
