Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB00C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:11:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E15D20684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbIWLiI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E15D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5JJ692PzF39y
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:11:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tbIWLiI1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="tbIWLiI1"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5FW1qcxzF39J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:09:18 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id g2-v6so1040368pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6W1YNU4j3vrKALU35G2VMZ7ZB5cTZtrjn/Eb0TYSvOo=;
 b=tbIWLiI10SP0lQLZ5qeqKIuaQCw06Hi0D1BUwSS+UnSEDfc3NWq6ScX/Ks2zApFYBR
 ZKJ+CBDZHrtSxMvA/yoF+4knyMQ+fZj93FiYY2azxIqzHt70c0b81Su/7Sw5GU6qrG+H
 qfFuNRt5aJPOjNuZh5i5kmH4rbT1WA26lqTOMWmGaEICDPCgFe0BAbagMTLx8HyxfyB4
 LdN1evoERBEvT86yqEU2639FGz3+OSsEkNfYyNu+iKkVm6Y48w/IkphdNyWcosWf1Wt5
 vSiWtvP1gtgxrwdKRPQma+gb+3loypRX02LrzGeJ5SDg23is+zsqEboP8OvO7kQ90naX
 QeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6W1YNU4j3vrKALU35G2VMZ7ZB5cTZtrjn/Eb0TYSvOo=;
 b=EraT+7vyNMMCZXn7qrcFISyzzOJDHp+sieHOywTaN7XDkyx2rB4HMI42WeSNH8stCv
 KqzUWt8v5UdMyUMJIayzAPCyNGCc1cIkjf+NK8GFpMDziAaFLF7Tejg++DJ7mp+bfZMO
 bC6akLCvjuaGAlO9r96Hinbjf6XjcYoA0T7GjoDx1woMulsEDsBzOG5icWqb5mQldJJR
 cFGnLB/ATskONpE30QKbYo1K8MLIx4gi502U9kFW9/C4dSh8VRo/+Ibdjw9f5IYAPLdt
 4JPtmoXUWD6qndOODuKwd+m1SR0TPQOn6z4BE/COvpwsP0UjmB2s7zaZ1X6f/blMituD
 oO4g==
X-Gm-Message-State: ABuFfojCXGS/1KuZi3FOXgY7TGI7F37tYIWrrpzMX1gnGoCRl+EUqMgF
 XbodR231kRw9GtC1PCLqTno=
X-Google-Smtp-Source: ACcGV61X3O2RUZdqxlCZ0k5cQiWkXcO1LhYNBb0IyswV9LI0v7UJBkVrJMSmMvNlA6ncgEYMDWrkhQ==
X-Received: by 2002:a62:6547:: with SMTP id
 z68-v6mr19654039pfb.20.1538546956850; 
 Tue, 02 Oct 2018 23:09:16 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id y1-v6sm688097pfy.89.2018.10.02.23.09.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 23:09:16 -0700 (PDT)
Date: Wed, 3 Oct 2018 16:09:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 5/7] powerpc: 'current_set' is now a table of
 task_struct pointers
Message-ID: <20181003160911.18fb0c60@roar.ozlabs.ibm.com>
In-Reply-To: <0336ff43-55ac-067b-23a9-4cb4b2fd38f3@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <acc40cfa715e398d578371857dbf65882ad72c0f.1538396659.git.christophe.leroy@c-s.fr>
 <20181003154101.0b46956d@roar.ozlabs.ibm.com>
 <0336ff43-55ac-067b-23a9-4cb4b2fd38f3@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Oct 2018 08:00:43 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:41, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:27 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> The table of pointers 'current_set' has been used for retrieving
> >> the stack and current. They used to be thread_info pointers as
> >> they were pointing to the stack and current was taken from the
> >> 'task' field of the thread_info.
> >>
> >> Now, the pointers of 'current_set' table are now both pointers
> >> to task_struct and pointers to thread_info.
> >>
> >> As they are used to get current, and the stack pointer is
> >> retrieved from current's stack field, this patch changes
> >> their type to task_struct, and renames secondary_ti to
> >> secondary_current. =20
> >=20
> > I'm not sure if current_set is actually needed is it? Because
> > 64-bit already initializes paca->ksave / PACAKSAVE. That might
> > be a cleanup to do after your series. =20
>=20
> head_64.S contains:
>=20
> __secondary_start:
> 	/* Set thread priority to MEDIUM */
> 	HMT_MEDIUM
>=20
> 	/* Initialize the kernel stack */
> 	LOAD_REG_ADDR(r3, current_set)
> 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
> 	ldx	r14,r3,r28
> 	addi	r14,r14,THREAD_SIZE-STACK_FRAME_OVERHEAD
> 	std	r14,PACAKSAVE(r13)

Right, I don't *think* that's needed because boot CPU should already
have set PACAKSAVE before starting secondaries here. ld r14,PACAKSAVE
should have the same result I think.

But never mind that for your series, just something I saw that could
be cleaned up.

Thanks,
Nick
