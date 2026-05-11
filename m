Return-Path: <linuxppc-dev+bounces-20664-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339FECD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 01:48:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDN1J5r93z2xqn;
	Mon, 11 May 2026 11:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778464132;
	cv=none; b=XLrDWGtJqNVcc44jDYBVPW/bdc1E77dgwL9utspgLB01Eqe5+bgKzVv9RuARZ4QIlpyJg1q6nLRsVn/DKBpOZyUt79Ulv5eNW69OQ1YaubrX4RRCXehMdhl79CKJ3BjYGbRfHHHrqUX98QTciw+zoIpYmvEqWEKhUFC6mk8+IUITAjMQIuCe7RHW/BSOrzzw8BAqhMUJZ7yucfoQKCWA6L8XoLFyLHa24JOPNZjft+1QL/Oqz0AgT9d0vW0m+VfB2VROJwLFYMVTJvt+hkia8JaQyBtofCZriWA/TAe94D50AHhpSrrLl5X/Oh6yTKhGSblahz9EwBTUQSq3nXjb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778464132; c=relaxed/relaxed;
	bh=EcpoM038XooU1Y0bBIiyinlJ3K3Hm9yy8VMj5gv4Yrg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=J6qM0PvSYLULaVQt5rPkoDHchGI/p8Xw/zrZpGujCrEeI2fQhHJuhwqyP5OwVwIjT9X4lNI3YCO1VecpCsHDKKaaXG97fxqVsnETL+mcuBeiE/TEmQRMfnGD0Wt/dP0Hhf1qEmKB6sYC81wgtlrypq0EL/cHKZORBzW8KP6/FIiew+xfhdtfRYg75Ln10Jx6wsJBO3L7qp5Osi7bYQSLrkOawDwewJ/Dfm2vgoDPKIqbg/s7vwvys6VmEjJFBXsJ5ubTR6jsaXmzgR/zDWPXRgNiemTXihdMoYzhqMf+m/nY6iEXRGLfuh2yv6hq4SFu396K7n4+tKNb0TBduaGP+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmCUgdlg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmCUgdlg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDN1H71xfz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 11:48:50 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c801912c903so1568589a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2026 18:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778464128; x=1779068928; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EcpoM038XooU1Y0bBIiyinlJ3K3Hm9yy8VMj5gv4Yrg=;
        b=bmCUgdlgiUN2p3iMNmHBlRGdZpWRss4oYeJZwiuKQjMaCYijhXbtGyznJfm9CZGqhI
         +ZXC/f732FUrau6qveWixNC+nINH4AlBrhOm+pnzSxfD7cLrvCRxorUpgr0A5DwRhyPw
         tVUFd1mpwrT+uArYIVz6jtoI+2dOwJ63jKyAUpSb7BE2GKrv5mEU3stKp77JGpqZgEGW
         R/+iwxwg0zJqGCJR/iXNxCMka0t1L1INFfk2T6Foix7/vV9eyPyHCZmrGQY6XjuzdOjA
         jVp/oC64aTAdt1J4juXZb2O4xiabqShVmkMKJ1G9MFG9BpqCYTzuUvF/GgeLj4E69hUl
         gM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778464128; x=1779068928;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcpoM038XooU1Y0bBIiyinlJ3K3Hm9yy8VMj5gv4Yrg=;
        b=nOaccLbRiFaJ1ikNcnq0Z8ns0GB1gNUzEGzG1WIqqWp8FEsSyRJfsDsMv0cskodgYp
         ZQKWEAHDtsGFbmzmHP272e7kDi47PfDGIhO4AgzDD44AqDD0i15Ck3rm8EIA0OH0roCK
         RJyPpzH1uzb4v66uHYHXuYbybB9yy2vHSkHu0QoAe0203QKe7yMEdKQv7lVuSrhfQ4vt
         TIzQz7PHEX7RvSlUmsfEEa95qzH66MSG4y1npmQlhwnTA+ie3+PgHa9q3UwXJjtFj+p6
         kUIp//DkDwNH7loCGRtYNbFmyj6oAl0lrMYRtFZF9evLOgQKaHxVAjdF8vfA1GjrLnVr
         6WTA==
X-Forwarded-Encrypted: i=1; AFNElJ9NRXBMGWFwxqFBhXqefnSAQ/fwWkQn9YfqTkvuXkZa8JPLQ7xDaoSuTv1S0Y4FYqL4jjFlbA1gcEUjJ4U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwBjq5KeJoMsEOdkUWEE0dle1xrJ01+oecgdtjFM5X2Ob5QfKZ3
	dqezF5nEQffyXpn51Jci5ghmFnUUonR2DoyIu81jyZXLsJV+3DZqT9u0
X-Gm-Gg: Acq92OHZfhiOgbtKFApg4pMbE0HCPAmbjXuSHZbEmo26N/l2/lHzN3eIZnUXgChCMSK
	wY7wRYjDFC1vBw0UVOE+f6C9w9BrdUKFaENpNJTpqMdA48T+kLbX8IU9NJ69sp0NeCLkI8G2xLJ
	3UEKdq+rjfz9BekPR6O1hP5+D43CS9KiJOF1RFyytHRVYxwo5vmShRUi9MsiwH0j9UZExrPP/gm
	oLHJEg8qjLJlzRwoivZFJnBuu/l7mo77H47qbKmoHONEMJzYHps3+6t8Y4Fyzjgw8KXKwe5fbLX
	FNbciucPDVmb2wLEQyQy4/ROyBIqRxAAz9JEduAX6pO3A4QJChjJf14EZ8nnL1TXZCO2IEQH8MW
	tArGw1HhXgrmFYZYfNW4HH9eBc143LBxgWiuvxDA1ApZw8+kJ2eloShZMFTWGxvtE6u59jSuCDV
	7lyUvyKn4/MDca7l5TomiL1faYz1+4tHwx
X-Received: by 2002:a05:6a20:1585:b0:3a2:dc51:458 with SMTP id adf61e73a8af0-3aad4498cc2mr7256531637.41.1778464128371;
        Sun, 10 May 2026 18:48:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267727401sm7349158a12.30.2026.05.10.18.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 18:48:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hv-gpci: fix preempt count leak in sysfs show paths
In-Reply-To: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
Date: Mon, 11 May 2026 07:07:32 +0530
Message-ID: <5x4usp43.ritesh.list@gmail.com>
References: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
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

Aboorva Devarajan <aboorvad@linux.ibm.com> writes:

> Four sysfs show() callbacks in hv-gpci take get_cpu_var(hv_gpci_reqb)
> (which calls preempt_disable()) but only call the matching put_cpu_var()
> on the error path under the 'out:' label. Every successful read leaks
> one preempt_disable():
>
>   processor_bus_topology_show()
>   processor_config_show()
>   affinity_domain_via_virtual_processor_show()
>   affinity_domain_via_domain_show()
>
> (affinity_domain_via_partition_show() was already correct.)
>
> On a CONFIG_PREEMPT=y kernel, repeated reads raise preempt_count and
> eventually return to userspace with preemption still disabled. The
> next user-mode page fault then hits faulthandler_disabled() == 1,
> gets forced to SIGSEGV, and the resulting coredump trips
> 'BUG: scheduling while atomic' in call_usermodehelper_exec ->
> wait_for_completion_state -> schedule:
>
>   BUG: scheduling while atomic: <task>/<pid>/0x00000004
>   ...
>   __schedule_bug+0x6c/0x90
>   __schedule+0x58c/0x13a0
>   schedule+0x48/0x1a0
>   schedule_timeout+0x104/0x170
>   wait_for_completion_state+0x16c/0x330
>   call_usermodehelper_exec+0x254/0x2d0
>   vfs_coredump+0x1050/0x2590
>   get_signal+0xb9c/0xc80
>   do_notify_resume+0xf8/0x470
>
> Add an out_success label that calls put_cpu_var() before returning
> the byte count, mirroring affinity_domain_via_partition_show().

Yup. That seems like the right thing to do otherwise we leak preempt
count.
I guess, these would be the other kind of issues which might show up now,
since powerpc is moved to CONFIG_PREEMPTION=y with lazy preempt as the
default preemption mode. It will be nice to have some mechanism to catch
these error handling paths where preempt counts might be getting leaked.

Nice Catch! As for this patch, it looks to me.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

