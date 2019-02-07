Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84831C282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:46:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B4C2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRCsU6qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B4C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w5PM4qXJzDqCT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:46:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w5MT59gWzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:44:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRCsU6qY"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43w5MT3GlKz8tPg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:44:53 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43w5MT2lPqz9sN9; Thu,  7 Feb 2019 15:44:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRCsU6qY"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43w5MS6y7gz9sN8
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2019 15:44:52 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id w73so4209782pfk.10
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2019 20:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=CNHXRNRN5LQx2JfAGet7a82jJDzw+Ck5ze5u1Nrcbog=;
 b=VRCsU6qYsy3Lxugg+zjXFImEk7hj0Jr+nkuV6mmDTyqL5fMtIidxI6jc+pLeDS7USP
 9Jn5OBbfC3MZDo/aGgr5CXicBLfBptxg160TW30dQJ4rIdYb3/x/ZX3Q8ngvIhkDNinA
 U1FNt66FASY47e8E7BBsttcCItnMqVEYVl2BloL05Mpp+zC7YC0W/v+UL5hZ05nFZuPn
 LTXhKV+5X2XJvzOLNJpBjAhawD5S5dEWBkyyT2HCBmTVXUZAjkzq0fR47ebD5nBOhgIG
 vYPcHkZvGw2kGYHAK0YMWYYsKCu/f9+Q/lBPJtl2UuuCiqSxgday24nPYGfKN7CqIv33
 Vmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=CNHXRNRN5LQx2JfAGet7a82jJDzw+Ck5ze5u1Nrcbog=;
 b=IXZxKp77SRb31ztrr0UlzDIZ2ywhfZ5GDjHTz1WUv+VsL/f5V7hYlrjCwRg3g0xtqM
 zn9Jn6tV4PIcBcPsKHXe5OJfVGt4RCuKT4jjBjlBKYtEizSmPlFVTSH4U6HCgwYIfif5
 4cdf8NdRgP+ps7VnzzxzE2CCzd4pIlxIhtb9bX2d/8Kb1J25toyZAfsqJqFoEHJCrGQY
 AYydxVU6hJYkeMJOSyVaBaoGPRiLnXQQFLq/ghtI/XqWrqzXzGIhXDILHIBtr/3J5Ci7
 hPj+6nxB5WLV7XGOpqLC1nJDP5gaO8geNo0pjXw4YDtSkRHqTKN3l7jbE8YKNnza8DzG
 3QaA==
X-Gm-Message-State: AHQUAuZtZ8EkiKo/xm0fhnb19CugCTt8ms6fNt1nu0v7EDScDsCdqqHc
 AErMqJgywOLO5Vy37c/fZW7FmYDq
X-Google-Smtp-Source: AHgI3Ibdg6R2A8bHl/qYbPCjcm104DaAHAa7ffPVlpRCGphYBcNzUSn+FHoAGQPWvF/6Ta3/SQprpg==
X-Received: by 2002:a63:82c6:: with SMTP id
 w189mr13189636pgd.344.1549514691274; 
 Wed, 06 Feb 2019 20:44:51 -0800 (PST)
Received: from localhost (193-116-103-101.tpgi.com.au. [193.116.103.101])
 by smtp.gmail.com with ESMTPSA id i8sm17548870pfj.18.2019.02.06.20.44.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 20:44:50 -0800 (PST)
Date: Thu, 07 Feb 2019 14:44:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v16 16/21] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
To: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
 <20190205113219.17903-17-mpe@ellerman.id.au>
In-Reply-To: <20190205113219.17903-17-mpe@ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1549513946.1fz26ku2ne.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman's on February 5, 2019 9:32 pm:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
>=20
> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
>=20
> Moving thread_info into task_struct has the following advantages:
>   - It protects thread_info from corruption in the case of stack
>     overflows.
>   - Its address is harder to determine if stack addresses are leaked,
>     making a number of attacks more difficult.
>=20
> This has the following consequences:
>   - thread_info is now located at the beginning of task_struct.
>   - The 'cpu' field is now in task_struct, and only exists when
>     CONFIG_SMP is active.
>   - thread_info doesn't have anymore the 'task' field.
>=20
> This patch:
>   - Removes all recopy of thread_info struct when the stack changes.
>   - Changes the CURRENT_THREAD_INFO() macro to point to current.
>   - Selects CONFIG_THREAD_INFO_IN_TASK.
>   - Modifies raw_smp_processor_id() to get ->cpu from current without
>     including linux/sched.h to avoid circular inclusion and without
>     including asm/asm-offsets.h to avoid symbol names duplication
>     between ASM constants and C constants.
>   - Modifies klp_init_thread_info() to take a task_struct pointer
>     argument.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Add task_stack.h to livepatch.h to fix build fails]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Nothing stands out here since my last review that I can see.=20
raw_smp_processor_id change is for 32-bit only, of course.

Thanks,
Nick

=
