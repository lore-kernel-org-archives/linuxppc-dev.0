Return-Path: <linuxppc-dev+bounces-26501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7A7C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 18:30:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbSnp0gS5z2yQJ;
	Fri, 04 Sep 2026 04:30:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788460222;
	cv=none; b=TEw0KfFZ6r+Qf48SjWYdrWAiQV3gprkaYDIBoHozEvdVo0n50FhOYE0AisPe912JQFpFZKLoar6eDsXOwxrV1yEHB0IbkOIQs1PT3JCWMCF4syNitFAkWLO5ooHs+J1GXKEBT9NgITxC1dK4zF+3NTGg4W26XSbg09bcV4+YQyl5L0X+BAzQ9tdCWGhs6Xko/fPWosdBKMrHCo/qCa3GxnY9adk+/Of+C4RAzljBv6gHjCVQYN9OJz7ktZzO0grYZGCzgqkZkXbhDY7v3I06ZOa2GGT8glgkcpr+4v7K1KvpAe8RiZQTPfz08+VZwdRlMpqVgeQq3BSN+i/Palct7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788460222; c=relaxed/relaxed;
	bh=u3M67kMpk6nns2PXTYpesW/nfB8N6hz7P82FMQIUr+I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NrhGaMvN3rCH5sxWDKm1/zYQbg0rr05o0YSHFxAEjWmfCnYp5yhwv8kcTkQ9F1ySaUugmN0Er15BErgga7MWiGvTwts8eA1URPuxe6rkgvIKRP4zV/VVwjx7EAeLfo2XNwLw/sFF2NVDdzj/FXmg4ZZz02gRu13DXaDWuWyXW6NDMPWsDjaKl8AujJ/qDJ6QAyQycbxXmDZTTT3KOK0IReXJatpkqKM0361MS0mJq1XQhOtAQeEdCnNFK+t7XGz+7jFE49PaYfGC0GPcdCmYxoI+i2cw7ogN5EPK4DCeIMXNi4S03nBCmRimxoX6jAYziRWGd84xJ+VXyJfAvROXPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayKFc4YJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayKFc4YJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbSnm6Vj4z2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 04:30:19 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-39682983a0fso127956a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788460217; x=1789065017; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3M67kMpk6nns2PXTYpesW/nfB8N6hz7P82FMQIUr+I=;
        b=ayKFc4YJzFuRBWcF9M97TgjRBxJ1p91o48RkObkpydtairhT9S8cKBuCzaaj3sVNhw
         X2LDv7q7eERCTkHuK6ungUrmNzenfx5NHbbcML0kIyRnRtCyEERNI4R+fCJggnskTR/5
         /0dS3Y2yKYc+jTGqtCRlExe7Wz6jHdtRbDoB17nJNedplO2K9jlEYu5cAyHdnk4Iz81h
         RURQSq0RlZSIVkxlY92eQhbdouy57vY/nvseyVYTKL7xlHHLeFSUtNgqLgK3isrs1lxh
         KP9HYtB4+u20v8mFplb7sb5XiY7qqexHEsvZhmIOMYSZou3Ju+9tmUYDvQf1vfEy58Uj
         IODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460217; x=1789065017;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3M67kMpk6nns2PXTYpesW/nfB8N6hz7P82FMQIUr+I=;
        b=JSFD32giBWXE7G5R7PhbnTXFtuJQqVuicI8YEE5+d8FWBmpo5ecLx6DxTzAuzVdddM
         141OhQzR7krfEFYCYOms8B2/b8cVYOOq2nF+7d/DfTBWSzrBLcMKCZDtKbqFr1IvbfHP
         jMBa+GtRciErXkr9GuVdDaAr0Xfw7MlHmICbphHpSCnG712cTN1YCjtPhKYE78gE7GME
         DXdVf/foyUPo8U4yTKXPT2RwGMtda75DqWifcOT/AcybbGKQ8MubkbTBkM7C7xvzWfQA
         b03xC97JjbY5wgYl4qI023/itAwC/NNGiXP9ETjVWd7VXosZkxlO9mUai6HE1snTsz7G
         buXw==
X-Gm-Message-State: AFuF++mTaCwPkPU5QRX0jWu8DTa+GjwgSa36/yNs1n7uimxU/WlHigON
	QB4GFH4FSJAOVWgahHrFivrK6LML70MaFb/cvUicN9sFdSywnRpYjl2g
X-Gm-Gg: AYBFou1cz7DBHGiHSgIpyejKhOxB7xTjYZ+0fRe4D8bIftDitgcFTHyKDV5OeqMm6dI
	AbenUs8eY+u6CMWG0OIsy38zGGtNo5PRSXTAb9ft2zOIkUlbx6jpOAIw+xpOBr3XrvK76l9dJgD
	GEFsmd3x2Cqoov0SyJgL/3mgM29vLsqP0tCqEZJSMNXrq5B16mbpqp8UzzboCl+tWC8t4FPoH7u
	EPhwPiNep4Fuwivov3S4CY8Da3WRBR6ALvcEzpMBihOGaPe/sMypWLxfZwszjsi3NXRLaXckVas
	7qOGuegEUox6Wq6Oxvn2YQgiwGscGHD7Rn7bLD7gl77u9KyfUyXj+Hvq+XhnvpRO5H2Rv7OrBdI
	MemGA3rLMn0Q5S2pWqDeoRUp90oDql5+ZMAodpok/EKbx7EPSgDbwK4m6D8qmPvDRJPzpIbteXC
	IN27aVys13ysIt+QXWHpbhR4xwXD/yU7pTwnVH4RBVZdKcPeeVDW+C91+iqgzD/gSMsSi5Vwva5
	uHKh/5PfCFLhHnS7/wHMZRqnpWdUA8wIw+d2MsQl4xX
X-Received: by 2002:a17:90a:d44b:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-39b26252edamr576657a91.24.1788460216726;
        Thu, 03 Sep 2026 11:30:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm1161097c88.13.2026.09.03.11.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:30:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Shrikanth Hegde <sshegde@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
In-Reply-To: <CAEuJdmqPPYET2tjQmKCzamRr6aBhb4JNjBPN0R6G72w0KdLjKg@mail.gmail.com>
Date: Thu, 03 Sep 2026 23:55:50 +0530
Message-ID: <fqzqtcnl.ritesh.list@gmail.com>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com> <CAEuJdmqPPYET2tjQmKCzamRr6aBhb4JNjBPN0R6G72w0KdLjKg@mail.gmail.com>
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

Harsh Prateek Bora <harsh.prateek.bora@gmail.com> writes:

>
> Thanks for the fix, Ritesh!
> Are we leaving ret unused as well?
>

No, it's not unused. It is getting used to sample whether exit_flags has
_TIF_RESTOREALL set or not.

Though maybe it can be optimized away if needed in a separate patch
later. But for now we are good and this fix is needed as many of us have
reported ld64 crash on v7.2.

> Otherwise,
> Reviewed-by: Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
>
Thanks!

-ritesh

