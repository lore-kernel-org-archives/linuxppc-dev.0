Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69F2C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:23:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E64D2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 12:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E64D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K1ws4J3hzDqsJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 22:23:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K1s23JbdzDrfh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 22:20:05 +1000 (AEST)
Received: by mail-qk1-f194.google.com with SMTP id c189so1133423qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 05:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OMsZyJ2WRqKm2D1XmKZEmDZpMnQ3g/rtY3J2qyxvyRo=;
 b=PqbsopknOjR4THPiiFmTNmELPkDLnDcVPhOKEGgZZugmiMj8VC1yOZ28YcM02RUZR1
 B3w2q119X+DFqL2VYxwwvRgvrmeIg3WGasAq55QyNbfBYwhcJwpB75g4Y8xclwU06Kzy
 Mv7yuVNyRc6LxNAJcdLlCAPKxYzdo3qoNRKPxyQzbDtAyL+KMFDyuRHRvQuGNerZYK12
 afXb39lsNgr6HCxZTfSd5VSzDjjQkbfJauQwPc+R2w6i/onaMClSHiZtBpW3ZYmrn66x
 kWIf9VWO78EKG7KXD4ELHwPL1q3pA6G8u4oXkJqEsCg1een0MDTIpLEVF3ERVMupSl35
 X8pw==
X-Gm-Message-State: APjAAAXyTHz2W/iRiAU+eTiM06nNRs4z+W1XfI70VHPsIXSRn+lUF4j2
 Vx2hHbYF+R3dbjPfY8KHTXTLAspuJgJ4UHqRKog=
X-Google-Smtp-Source: APXvYqxJ0sYDtBuO/PNqnzjVxlCa0l/KOpbtVwjqljAy2rojnkCCGYuyQWcy+W8bCid+RXA15JHm6+X90RvmUFEaluQ=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr9065773qkb.394.1567081202566; 
 Thu, 29 Aug 2019 05:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567072270.git.msuchanek@suse.de>
 <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
In-Reply-To: <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Aug 2019 14:19:46 +0200
Message-ID: <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
To: Michal Suchanek <msuchanek@suse.de>
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
Cc: David Hildenbrand <david@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Breno Leitao <leitao@debian.org>, Michael Neuling <mikey@neuling.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Allison Randal <allison@lohutok.net>, Firoz Khan <firoz.khan@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Nicolai Stange <nstange@suse.de>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christian Brauner <christian@brauner.io>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Fixes: aff850393200 ("powerpc: add system call table generation support")

This patch needs a proper explanation. The Fixes tag doesn't seem right
here, since ppc64 has had llseek since the start in 2002 commit 3939e37587e7
("Add ppc64 support. This includes both pSeries (RS/6000) and iSeries
(AS/400).").

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 010b9f445586..53e427606f6c 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -188,7 +188,7 @@
>  137    common  afs_syscall                     sys_ni_syscall
>  138    common  setfsuid                        sys_setfsuid
>  139    common  setfsgid                        sys_setfsgid
> -140    common  _llseek                         sys_llseek
> +140    32      _llseek                         sys_llseek
>  141    common  getdents                        sys_getdents                    compat_sys_getdents
>  142    common  _newselect                      sys_select                      compat_sys_select
>  143    common  flock                           sys_flock

In particular, I don't see why you single out llseek here, but leave other
syscalls that are not needed on 64-bit machines such as pread64().

        ARnd
