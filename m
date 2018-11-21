Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C86C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:18:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418CC20878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 15:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO3EaS8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418CC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430R621SqfzF3fd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 02:18:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WO3EaS8/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WO3EaS8/"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430R3D6nTmzF3cT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 02:15:33 +1100 (AEDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68383223C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542813331;
 bh=kpH9lcQ8P8XV+NLvUJEbt/IT04dFbPXjvuI1ObcBYAw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WO3EaS8/FloZljB3D0tId+b0RRJblFbBK5xVFkqM19MV+DgDQNDLG89SRap/65xcc
 TgQ7LKAArJ6pNGkRVRv0G3ghz21YdJauk3AvQejWxBx0R3yc33iXSgVngBQ87BcYpu
 1fseEMn+Y4f6OTNK/w1PIkkW9vSCkI5c60dYU6fQ=
Received: by mail-wm1-f46.google.com with SMTP id r63-v6so5905701wma.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 07:15:31 -0800 (PST)
X-Gm-Message-State: AGRZ1gJk5LdSge1BkUTNyPGx0s3icF2H5F3VB7RJjNcQF/vzP2U99XsW
 6YKdfp4zAmpXFnjc6BozKfG9kfw7PJyBhN41R5bTuA==
X-Google-Smtp-Source: AJdET5fCl28jWGxXnQdRFKVSpliKHyZtnaunTTizhHy0FVmzumF0Lqgw2R8mpyFkm2xs/3yb8DPm2VruOfQ2rmi5vtI=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr5957608wmh.83.1542813327926; 
 Wed, 21 Nov 2018 07:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20181107042751.3b519062@akathisia>
 <CALCETrV1v-DPRfDRwiH=xn29bxWxiHdZtAH1nw=dsmDtnT0YGQ@mail.gmail.com>
 <20181120001128.GA11300@altlinux.org> <20181121004422.GA29053@altlinux.org>
In-Reply-To: <20181121004422.GA29053@altlinux.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 21 Nov 2018 07:15:15 -0800
X-Gmail-Original-Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
Message-ID: <CALCETrV8AJPkZF7TzhXSte_wJgNXH+-s7-tPM-8xjcAfYgzdhg@mail.gmail.com>
Subject: Re: [PATCH v2 16/15] syscall_get_arch: add "struct task_struct *"
 argument
To: "Dmitry V. Levin" <ldv@altlinux.org>
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
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 linux-hexagon@vger.kernel.org, X86 ML <x86@kernel.org>,
 Eugene Syromiatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>,
 arcml <linux-snps-arc@lists.infradead.org>,
 uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Andrew Lutomirski <luto@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Eric Paris <eparis@redhat.com>,
 linux-audit@redhat.com, linux-alpha@vger.kernel.org,
 nios2-dev@lists.rocketboards.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 4:44 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API
> with PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going to be
> called from ptrace_request() along with other syscall_get_* functions
> with a tracee as their argument.
>
> This change partially reverts commit 5e937a9ae913 ("syscall_get_arch:
> remove useless function arguments").
>

Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
