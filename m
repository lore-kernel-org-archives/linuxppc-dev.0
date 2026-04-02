Return-Path: <linuxppc-dev+bounces-19180-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7751112246
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 00:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmMcR63m3z2yZc;
	Thu, 02 Apr 2026 11:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775088455;
	cv=none; b=OAu17kV4LoT18B6Pxne+kdz4/4+2pWhEFZ2GZ8xVRo/vNiM8kEU2pxMDt+erVWAGPxdNVMB96sQ8wExS282hTmHQqJswYqWYTEuZtn1ekms9wYN9ZsYV9n0eHBijksStMiDpL1cE+ChJmtjhIxZLc4/JvO20r9I3qqpBtiPEOYWujDQXq+6pESfbOVRQavcHDmdvlPP5pFFhIuYCI6ezmjXYEUVmGgS2WHirFCFUM+SSS2yJud+GoqDiXrMtijkk2ytFhr+GLwjFnjUNM832kENoheskvbh2RUqPsNbh7kdV5Eid2rT7BfvLQwgqau/COfbPlrjpfG4Qs247mvgblw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775088455; c=relaxed/relaxed;
	bh=fKk78rHEr7kWMP1GZ2MDXU9L7tWNnfvIL9i1o/lV1jw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NqYVxZ8IcTgRkwkQsoQgUwrwwo8yFrydMXfwMohSfbtfvZ0QWzLlgkna7DPU/A6edU3yiSqzr3jxiWFDvwtcCIMgdT4twbj9R+qbuDRf3RtRA6gk/m5BPhs8/TjurzdYyhvs5/J64uOix/xzFZHh0X+Sq28gCApZoIXyF602l92gM1vGys2XrfAYEnTrrgB2D0yQZZNZyJsD2zVTYtCXhj52VUVee/BWCgHZ8oBj/mm1sUGE8Dw6PdLiDlZlUGp4Xp19NyIjzK6aJD7RniFbF3lobta79oSgJN2RxXtS+34phVrD1amNX3QlgCL+/k3PiJ75nN5ZJXGrDxy+Mxom3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B+qLeTVy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B+qLeTVy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmMcQ4MM2z2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 11:07:33 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so132283a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 17:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775088451; x=1775693251; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKk78rHEr7kWMP1GZ2MDXU9L7tWNnfvIL9i1o/lV1jw=;
        b=B+qLeTVyXZ9jPYBwXP9r6V66PzrhkUV8PHYOemXTfPSoogotqhbr6opjDF9Q+Uu/N2
         H4De40A1riUov4X8gG/47W2zDposqamIA5E5sKwtZmXg8HAslxg8NmgFH4Hx00qsgH0b
         ShdeLSBmrKWLugFI8S1ic7jEDhgPQxUBb7IrLO5zfAwq7rgZDRFPirZdsB05ZTYCXMS3
         EIdEdBkNP/OY639noJ1GVdqSIwFCzFFCRPT0xmgA4iuqkqELL2LBFzrM6onBjRLfB3kO
         kvnurTHaXEDCa3ib4Lg3OhlEdwSaieYXVvUmZv70UsNSathdjdqRrvadA658Nvd5E0sO
         aQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775088451; x=1775693251;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKk78rHEr7kWMP1GZ2MDXU9L7tWNnfvIL9i1o/lV1jw=;
        b=LA8Zbm/55flv0+gIptFrg8Q8uWLsmPOWxNWHYzIeuNsFvtjRoGLypt34G8v5utXyjR
         GL+chBw+10ZGPpvqTPndtIJB4DaYK53XNzb2VL1zxZOHSLGHHwFe08vSmkS3QhoAtNBa
         F9jcC94o/l/hTUW8TbqzsYIFfO7ftd46Ytj8q/S/+iVOYS2sj19t6QqHUswwjujJ0wdo
         cEgHlfSBsfccaL0YXoW5d8EKRxocKTTPUJRtCu1qwfMz/889+MZ2o0j41EdONUam/EeI
         w3vvPSFznlHJVD6fbDdGg2CGFFPitI3xAZ/0ChK+zllrDZDUYGb3t5lQ87uqgidq3Q1U
         vExg==
X-Forwarded-Encrypted: i=1; AJvYcCXENFjPs6+4QsVxuBQUR8eJHP5Me4bfL5CxLI8TG+mvJ6+Ylw9GEa0DUOxms4YAaOMbpNfBn8YOcD7+m6g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkE05fBPXoUpxB6qfQI+L1ObJfh1pAjnHcMckbhv9YQFhDmzst
	n5ecJ9imTwocoCAp4P0NI7yPX3xdLbVsJ0OuGgBX3VcCQZt0XG+kyVOj
X-Gm-Gg: ATEYQzy2vZM4z1qDK/UIgbojuHlJ4Tcvfv6ea7wObhlHasCNMkTK0MledyK3jnpYHyv
	aKxi8GWzphApxTkmmbYJ4hTz+Y7TyeDrYKYdG5Z77XMb2+SN4hy8pE4bHlCyNMXnakkCc5Fhbji
	MUkR0jwTCuoz7uQEizhIC1CLJ6pkCZb52R+ogNo+5LsP0i4k/NBbiq6NTtZkhzNRRxck0XwkBdQ
	CaCCZxDAp84YhksyonJHQEsYr9sfm5MzI/ZIeH500zXh8POFh8dmaYgqeTbpANbDJgwU1Ihzv+N
	cc+3RLDL+S1Xpb5689STKNnSYNmEat7zULiNLCYD0LVGtTJPykd4d39iSbkZhVMfFG6Nk/F8RSK
	8VtTZVNLofjQd+UnOdxL2rtLgU3MSt7vNykloNNy1IOX9ukpKjqWuSZsOdcHJLwvrkRJKg+9ic2
	hkeAlQHloXFXwZ9J6pgx1Seg==
X-Received: by 2002:a17:90b:1b4b:b0:35b:e51b:1935 with SMTP id 98e67ed59e1d1-35dc6f7ad00mr5033603a91.17.1775088451375;
        Wed, 01 Apr 2026 17:07:31 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623754sm5767772a91.6.2026.04.01.17.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:07:30 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/kexec: Disable KASAN for VMX helpers used in MMU-off path
In-Reply-To: <wlyvmo0a.ritesh.list@gmail.com>
Date: Thu, 02 Apr 2026 05:34:40 +0530
Message-ID: <mrzmmdlz.ritesh.list@gmail.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com> <20260321053121.614022-2-sourabhjain@linux.ibm.com> <wlyvmo0a.ritesh.list@gmail.com>
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

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The kexec sequence invokes enter_vmx_ops() and exit_vmx_ops() with the
>> MMU disabled. In this context, code must not rely on normal virtual
>> address translations or trigger page faults.
>> With KASAN enabled, these functions get instrumented and may access

You said "may access", so just curious that, do you see an issue always
with KASAN + Kexec or is it only with a specific configuration?

-ritesh

