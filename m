Return-Path: <linuxppc-dev+bounces-16893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED23E68152
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 09:36:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFZK01zvfz2xjP;
	Tue, 17 Feb 2026 20:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771320980;
	cv=none; b=GhuZ1HAhjZjRYJKVXI4Dlh+5EMg03CZFuN7FS4H0wVprjIqgpAGMT7Xe6nLFSk8r5i6+IulqYW+hVFXgvXM0ZrgHF4xm7IweVcA7UGfxI6c70v5oXEUWAw6E7fW+OVZy3zn6PIJPGEf4noOnqJMcwTIwIO84e94X22f9UDXWON/WHZ8KXz6FiGzyaIixVyK1Gpg46+Z9unT99RMWWNONIcvgUuhMYeW8S/plCcFCM+2+5NzMYbL6Bzfmo78Np1KfBBw3TVbZoJAdyrEIVzu5q+fnEcKMkIQLscqsXSkQuiGet1pI5xdgkNAlKLXP341yspvNU52sDMHnt86bPFQWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771320980; c=relaxed/relaxed;
	bh=jppHwni8U4RDg8yXe+tFiHh3KGo6bZRPsMrl1Tp+UrE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jylOel+RwE4rseXJXOhSjbbtkwW5TJuAHcGZN2g8anbYBWC9mZtALP9lIFMeS04zEPcoo/GYc3hHzaHO2Tw0x0xPOshCtgXJmWt7he0UCKLeq6hRYHb6OcSOcA4jfWJjG68yFnZVq+WcbCZFFtku2vPCh/hQ7miSXxk9IytT8gJYLke3oj9J8tju1ved5lVyJnH4OT6jpzNUdNLeoG1opsRTZrRD7q2D5aW0oEFos+8xh0o0C8IMKCDFuvYQwUSaPbER5uIBslDxOL8WAgO1G4gjqEZgZAhb8yiq23y8uzp7yihOwsCVJkfUR3z/ruGOm1/YvtwUge+08nIemsM+kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ayKkUXIV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ayKkUXIV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFZJy3HMRz2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2026 20:36:17 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-823081bb15fso2254972b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2026 01:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320971; x=1771925771; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jppHwni8U4RDg8yXe+tFiHh3KGo6bZRPsMrl1Tp+UrE=;
        b=ayKkUXIVUvBVexRtwNwgce1RMAiebU144qRN3oUWK3kNs1lPOCXxXUzGRvQjQMctq5
         dnWg8Ki4Y84nWuAht9IS4t/zSpHM9Vg2yyrf1W8w9Xa9vfSvXqekpE5i17T+5k7IRYUy
         BrVFHVl3piums4monnVouEbFjddtAeqjBjGOXr9DrXN0JfwTw7NJRGGrHVgIAGOEwZ8p
         +ZZ2sdcA58jV6cuVAPyskI1thb4EuDU+67R54Ps57AiuGVCTXkMKeiWcr2cSPN9t42EM
         xH9F4s3kVN0U1UtY8HTYOA2NOoP1nsnnsHKvottveNgHKnY42MIPtfTVPKKJDM4HH4Rm
         gkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320971; x=1771925771;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jppHwni8U4RDg8yXe+tFiHh3KGo6bZRPsMrl1Tp+UrE=;
        b=oKNB9HepSw7uCyfLq/fQBHaTXlqIX6fkGnF1UDUXvPN9CdiPbaVpIodZ5Lp4tEPM8T
         WSTuYA9aI7HeVX2JeWhx9RDBtyuN9559FJMRi68OqJ5ben9jgDdR96Ke//fcBd+KKaGU
         gp5VOPLlPXbwdvneSJVifsU/pX+ILKDNC9cUOjzpmkhpoEpp8BjS2E8lEOZePE+uuoCJ
         945sAqWHqgKVBxyYz1/6fdtRPNNAkBOOW89LONF42J/xc3urYEXXUiV6LATdueu70rUS
         ZdrYn2SHoBucXJwHNRNEeTtXCO9q5qCmX8FboGzx7t6ql10TvORiIAe0l9LRMZaEkmbq
         l3rg==
X-Forwarded-Encrypted: i=1; AJvYcCXwfq1SNlPfxWauI5vtVBncsFDJqb/SS5S3/wbcBBtylqvSTDlVgeybAvQDFyZ3yHQ99R4DUwiUAxbsO78=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx5UJG9YKMjSquPLU0oV543cs4W+cg4K7hkXgn6OOW1XjAbWDWV
	Ge0JPB/LAX1QRO/uttxOiEfzRVcoLJwf79Gz/Gwu6h6mBvb8WB8f5BVu
X-Gm-Gg: AZuq6aJvFPUPJe5svEqQfgvw7cRP/g1W+3gPzrIMLfZqp/FfJhFPcVBft/0f7A2xMf8
	OoKH27S5iyhv46wq9JQEXeSVea28LsNxOOT00i4G45IXKuNB3SogZTBrYNzZjzfHILU+/mIPYgx
	Tcwkii4x+oqXHzUxKtzclQspsoTx+NXI1Pg/4vg1xesNekRPvZroGLXp3Imrt3G1p5q3VwrO+Y7
	QkaEkSZDr65YZvIpzp2Q4ZsQ1sCF7xjbTo5lZx3toqGe5c5JVzoHM7OHnK5bQQ+Uiveg3mhQ8Oy
	2tU3YC57dZSA5aKj5rFs+fSVfaEwTzp7YIiG/rELPLQEfKwFjf7Qq30APcK/JLkMhIxYjWZIwgM
	j54s71YdX2HW1l9gARKFyEqRLamT21X7dVsQL5LmXLT2qVPeMbszfxhYrOMuyF9fQChFPCu+SNf
	2qGo4mRJ3eMW9kTg==
X-Received: by 2002:a05:6a00:178c:b0:81f:4999:ae46 with SMTP id d2e1a72fcca58-824d961c463mr8786460b3a.48.1771320970655;
        Tue, 17 Feb 2026 01:36:10 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69b13sm12274707b3a.30.2026.02.17.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 01:36:09 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, rostedt@goodmis.org, mhiramat@kernel.org, Nicholas Piggin <npiggin@gmail.com>, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH 0/1] powerpc: Fix kuap warnings
In-Reply-To: <26372850-476d-457f-ba97-9119cf81d376@linux.ibm.com>
Date: Tue, 17 Feb 2026 15:01:48 +0530
Message-ID: <87ikbvd8cb.ritesh.list@gmail.com>
References: <20260109064917.777587-1-sshegde@linux.ibm.com> <a42acab4-274b-4e5e-804b-bb07a26058c7@kernel.org> <fe9b9c66-d1cd-4570-91fa-54329d8c6a37@linux.ibm.com> <336d274e-c831-4af9-ae65-42908b3c2c61@kernel.org> <26372850-476d-457f-ba97-9119cf81d376@linux.ibm.com>
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

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

>
> Sorry, I forgot to update.
>
> I spoke to ritesh a while ago and someone with better knowledge in
> this area will work on a proper fix for this.

Sorry about the delay in getting back to this. Sayali from our team 
has been looking into this. She is soon going to post the fix which is
basd upon Christophe suggestion. 

-ritesh

