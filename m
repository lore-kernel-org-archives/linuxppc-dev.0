Return-Path: <linuxppc-dev+bounces-24112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E19CC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:41:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzLBH4W8hz2yMm;
	Mon, 13 Jul 2026 21:41:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783942903;
	cv=none; b=jYw6+H7/0fkcBU+gR0Vl9AeHkkQj7YtNTAW6uqPddUD+6D1Osc9GEoR0zPe5XGNJro3GGX+eC38683pK+stQr1csRPxZc66CrPYaYEfAmCTBW6HCcr28TcwM6qO6/IZI1nKa2YNBpoaU5YHA/QUp2cYXQzOIpADPKNuLEV9fRTD7e+8C/VV8TJVKBNWFF/x9nkXfNqlWkfWpuMmOg8jKwL/oLXT8EY1/s+tO235eqsd9d6OqpSJNTUZZhFR+vyCcBnG/umBLq5TZmmY6tr7UJ/kvAWD6YT7BtBI2qsh4sKgW51qIxrpxFbjD/T7INqPbjkPcGSrRAzw1v23w31GXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783942903; c=relaxed/relaxed;
	bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=c9ehWHi0Efe0/NJD9oSdPccoYucFtw9I/3CRxp94kR4AvMHavCYbl00PqRyoXwsyfj832xbOYLp+nK1fXx/kbCU/5wywm1u0dqilDLbzO+utFPj9o+R8P8L34mGr9Mk26FymtFe6HIJElxNnkizqzVY6aBUBdiMznSQicIBqWsZmXiFzpzpwhS/LIgVG5xrrxm2s09oumqAQL0A8dzhOCA1tSQctKmg/NmYSfOkEMsXddiaY8tCdytcUWts7UGYzIE8aWlGZbGn1upGsqS2jHNZzNY0UQxqdYHnbsKYJrCEiP1owmus2fpWwo/DqPv/WV1zfNWNYoU/XwGzhgtmb3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qxo+ia+W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qxo+ia+W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzLBG1zxTz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 21:41:41 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so1975471a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783942899; x=1784547699; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
        b=Qxo+ia+WJYPK4x2Dr+qRbp94q2F9khwMj0GjwWkqlv05xoKyX8LioTKw0AvkdnNDd0
         o5F4tfiiG6m5P4wjqd+MB2DaL4AmAOvJeJdKlB8vRJVFq/nCcYT3xl0maHODgO+FrEzs
         UpdykbYxqJZOTQNsAmbS5dGt4gl+IrmwSjFOs3NHY7rqkiMwg2ML6BAwZ6cZ5uWeiumG
         gw/bY66R2v0WJe1zoHBD66uSI00IjGIbs1FjGkoLGqiwvxOTdvjgw0CX8haK2R+dGLxG
         6g5LcwybNW4dOUjopYb/XoMqxAx93XSS6ZwL8tiHILBeD9LPiJ59VXCsvzq63P+J+NXc
         u6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783942899; x=1784547699;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aptw9BP0Lcs+YvRZ76v7E7JJ6QVmrbM+EF/a62t9ku8=;
        b=sb2T5QW4gWpqXNPdV3fVyGE8nmv6qArZ4v2H+3ZkqWvRpJdsVmqdBTdB6ynKXWRONT
         5A6dlYYX165LO3XLCZY3yUeT1K6Pfrph0BG+awDz9NCWUOHbnYbCzrvukFUXjr9VtZPB
         u7mbn5/DMBiS666ZAO3ryo9+8Hk0msFiH6t92rOCqUZD63LjcAdlPArGUedj9hSLUoAP
         w1eq+dKwGn70sG9S7erAzX6pO5mObbuexADwyrTECbNNMcUJx9UShI+aKNDfUcvRV8I3
         xxPGhiHuCDvFsEfpTAYFTcC4LUrYQuL2Uc1fp0hJgKlHx261hchQB8KVhELBViMR3nN6
         ZLRw==
X-Forwarded-Encrypted: i=1; AHgh+RqazXTVkQEsQ2GQgvQO8RvtPED/QLrOGOx6hJDGGOFeHqFTrYrFQoGn+iv3xOhwTSvGAOOPu28Ayfq2L0o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVpmlDTyYjkZX2MbRj4VwABmVWdKeIw69auEFiYQT4ASf2pHON
	eFhH08v+iGRImp2rFPzLpvT+8NTzDuTO1CxuN/QqOqf+RwF4wa3Ebqsc
X-Gm-Gg: AfdE7cnNWAog9nx1jM5OLX0IpbiB8QWIZW0e4CKFTIBT7lzkZJq7NtC72uv/uQ09HpI
	cef1JqQllSYTWuePmG0n6rOoFZETuze8OzbCL0zVYyOa4sM0pb2EMbJ4KPufwkt2hr1uRVHcdQK
	0ZJwiiqHhmUuFEMm1jppBW+p/gphoLLKN5PuHoA0N1AliuYsc/VZvXB9cwoeOcn7v2cCx++0mxd
	EXfB4hcKM+qaNbtxW14z1vbqd8X7EO7cjYQl2eXgN2IPIoNIS4CtTEy5lYqETAWFQBAlgo2/C+d
	sawCXqANeHwCsfG91fOvfE9yP8qAnXocM+BMzbNowj5ahamdgQoc6YhlakSC815ktwe/aSQuvcM
	lLascCks/UqLl7P2kNfDpK91lLz0rOHXT0UuSRJIJ3zHfwKyTh0UuFTecNbLGmYuBrvZOwe1K5b
	E2S3/DKC/Lrtg=
X-Received: by 2002:a05:6a21:486:b0:3c0:9c19:658b with SMTP id adf61e73a8af0-3c110ced356mr9709546637.69.1783942899190;
        Mon, 13 Jul 2026 04:41:39 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm58974708eec.20.2026.07.13.04.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:41:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
In-Reply-To: <a5f57d59-a246-4279-946f-2e41d1b438a7@linux.ibm.com>
Date: Mon, 13 Jul 2026 17:09:18 +0530
Message-ID: <jyqzunix.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <mrvvv515.ritesh.list@gmail.com> <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com> <ldbfv1dl.ritesh.list@gmail.com> <a5f57d59-a246-4279-946f-2e41d1b438a7@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

>
> Okay, for stable tree inclusion, CCing is enough.

yup, by ccing here means, adding a "Cc: stable@vger.kernel.org" tag to
the commit should do.

-ritesh

