Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99761C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 16:22:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F9020737
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N69s+eop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F9020737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48tSyl1P1wzDrQG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2020 03:22:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.a=rsa-sha256
 header.s=google header.b=N69s+eop; dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48tSvh2kxmzDrQG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2020 03:20:00 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id u4so4496888qkj.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2020 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=hxf9moS4Fx5cYinkxtKnKXZUbKH1kCLQlOUICyLrcAQ=;
 b=N69s+eopVKPjt9Ak3LJWLduGUIkLlf6HHcv65RpJVSxl05EWhWEmdw9z4801LmN+u9
 k2MqUvT/h7DlzYLWWppX2sDw61SpC9vAV7Po+V6Xq+bFILdWRoCDsGAmL4n5WMJHDr1y
 rh6CCqO368IvkScTluhEX7tztJbuoQGCqzdUp5ObEHNV4pK2ENnkP+uNPbB4uuXmg1hA
 Ka1RYp9i1NfLgd5JgqI6T4ABs6AL0yNsEipKPdyOGtqlaS49U9nOoM5JFqumiTxEjs82
 QVGf+jmTvBrbwx7AT6eyfaqHE/40pUbVjxK6tvuqSkNV6lVNlFPOrFs9hg+9BMCCP7wh
 wZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=hxf9moS4Fx5cYinkxtKnKXZUbKH1kCLQlOUICyLrcAQ=;
 b=NbBKwMMfG2K+b1snWTMjb1ZtyibDOgYec4OIXxbayjJh33WCUpXOnDIN9DuEtm+jaN
 jV1iYk8hAnACIbArYgrHOdIBcZWeL5Cn3M5tfgRNlo5fg7SdKhVAbjq9lQlhH16aQSWw
 42VUYyenLvTcM3tFy4uTUYaqR259yT7XN8ESc5PFISDzD8Mdcp3Z31so0xt5cYanVYRm
 GILNZ6fwv1YV7OotArDX0EbxJ332Vq73AVUeI5ysnC64FM9VTncRq3Klfm16k3eI8mti
 tpKFjuPPyDxvp8foAcwp/GgQfex0/VTJSueFNSCWD3FskWb/EuEriAk5L60hir05V2lI
 fw8g==
X-Gm-Message-State: AGi0PuYkouYQDV256ss8vqTk0ghnaiqD9cFq8peW6fBKWpyQJ/9QhhoQ
 +WCA0Vj1aASzFaOWxNRMPplczQ==
X-Google-Smtp-Source: APiQypK7Tvv6yfkAlbuv3Zm98Fh5mhbo2QkHe/iKDQdeZp1Qh9wYR7AKizHCaNBlBQr8zGtGsc6oQQ==
X-Received: by 2002:a37:4648:: with SMTP id t69mr4077821qka.299.1585844396325; 
 Thu, 02 Apr 2020 09:19:56 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id o13sm4083358qtk.12.2020.04.02.09.19.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 09:19:55 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date: Thu, 2 Apr 2020 12:19:54 -0400
Message-Id: <4134872A-3D1D-4860-9C1B-2FD9C00272BB@lca.pw>
References: <20200402155406.GP19865@paulmck-ThinkPad-P72>
In-Reply-To: <20200402155406.GP19865@paulmck-ThinkPad-P72>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
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
Cc: juri.lelli@redhat.com, "James.Bottomley@hansenpartnership.com"
 <James.Bottomley@hansenpartnership.com>, vincent.guittot@linaro.org,
 linux-parisc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 deller@gmx.de, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, bsegall@google.com,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, mgorman@suse.de,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, dietmar.eggemann@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On Apr 2, 2020, at 11:54 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> I do run this combination quite frequently, but only as part of
> rcutorture, which might not be a representative workload.  For one thing,
> it has a minimal userspace consisting only of a trivial init program.
> I don't recall having ever seen this.  (I have seen one recent complaint
> about an IPI being sent to an offline CPU, but I cannot prove that this
> was not due to RCU bugs that I was chasing at the time.)

Yes, a trivial init is tough while running systemd should be able to catch i=
t as it will use cgroup.=
