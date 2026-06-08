Return-Path: <linuxppc-dev+bounces-22207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1082CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:28:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYvXk2H43z3bt2;
	Tue, 09 Jun 2026 00:28:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780928902;
	cv=none; b=hHdYA52OqXT2xOktBh7B+6kXb7kFxkppEQFnbAdnWJQQXm7GHcqThkHd9amMpPdgndovNHaBmsjFMNN5AYCYPYqUPJF+k26Lgip1x0rISf9DtYpVqxeJsJ+4uwTrFwiP5A/1ZwyTt2efPuKk8Ej7sZkaBXXfNKNhrJANvN7vRP+tMPAyL6Ycc3EXZmTfFR4SkzKUfEKmgdmsQcs3an2KJT2hOrZjCc/weA+//ObVS+fSHJo/NxG3wthWTcQFFqGnDLYCKrpH/WDCJn7TQLmD/fIPoUYoFX2/vCZvzPC1U0tT29HH0Z6dFoJLt282U5/idDANlO6lG7aK1Gz7tvJWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780928902; c=relaxed/relaxed;
	bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZWW1siX7xNTAh9G8uYHhdcqBsY6hAUmeoiFGTQOARIXRPLBinSkrJn+Qdti5TXO/tAsiO1gusy9dQN8Cy8C+rsYKWHFPrDI+iNbJ3O/zKwtD7I4WLqAN/xU1mj/BmKLi8ldLpx0dZyZJU5TxHUmVChZ+fDelv3RxfAFlOSwXj0BdQe04OMpRKzhxX2M81wRu0pq7WyqS3aSdGpg9kQmin95mg29Kp6TLpHJfvt2LPq8W9Gr7WmXRHmtgrRWI7+1zYfGgzLVtBOnuqInC3W/7PdnrjPEhKWIej0rPAzw0z7sQfi7zdV7DlbDLdPydEvIernANN8O+cIqrXg7n0ZUtYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r+IoZAcu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r+IoZAcu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com; envelope-from=iacobcatalin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYvXj2wzMz3bsS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 00:28:21 +1000 (AEST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso2064308f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 07:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780928898; x=1781533698; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=r+IoZAcunkwkiME9hoXzNzJ+n+SVgh7Ocg64s3e8wOLeXhoWcieFdboxJ94zQzObOu
         RvzvDUwuvSs9ti18c57gW+qA1wWyziB5Ol6ldMBFuvSNCB+xHu6ccuW37ZgmOAVrhrSw
         WZqwft7Z0qpDf44ToIvy/EeJkSGvch9j4VUCNK/US7bPfxga0Ebk6LN7kvCcqHUvXgyc
         ixEqEqYFS/6xnUMT9JGMqoq0l0FAU0pvrRzIojVfSsfwrTRFM0CR03Ax2NPGK1OCmIqt
         fdE6Zzb2pZPH3rP1mCZ7VjfOVUKF50vmrOguIbxalsl915g/2aLTDSG/+7+O6vMGRaOm
         OJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928898; x=1781533698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fx/LUhwU/PuBYtkBp+ygwfhlhplOE7zsRH3troT6KA8=;
        b=rooIpXoFMhYnXz0UYCnCBUa4ipfu7XWkkZMElqgpfFMZwGexEMF7E5uKjq4eEjVgcF
         /YzhJ8EjwWn7Q2WrhH/Jwe1JCBDN9GjVUxBakuJYak+ZaCW2seMiuFOzgy7lNbfFWUhR
         +Cz/pIwkCH8UlQ6KJjs4xnCewdJS2suOnT3fZjUVAqEO7WsfnzxCTYER5j/RKw9UXLNm
         pYfZxLWeDMREgJF/23ZezDvx+eSMFkbqqZWpCoVaBRn1xNs2mcRzjZcwMnhRdY+APO/u
         aWGTVg7L0uUWX+8elR7Oyi2N8Im6ek2j4V6rZzmWKxWudq08190UuRDlooJIHDN9tqje
         iTcg==
X-Forwarded-Encrypted: i=1; AFNElJ+aUWwwu8QtDGXkFSih0ytZxq04i1C937BbMA2Zd6OWsH1/T6g9tOS5vQRkbAbyJdCylLtyfquDw04nZbA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUfs+0LI0WTHjRmAuBbqGmrgvr4pfHGqaGpEIWgIA3Ayx5JYO1
	lOv+81zYuok9feTdvWbrEYM7Hoba8y0CrPQnyvCwFXuQsyntoojzmvQK
X-Gm-Gg: Acq92OHqZCxCX4Z/KlhpDatEOHn3SXo21fkBUlMHJjEaDXwTtJj5klJQ0iLF7siuXbf
	5Gw/nW1hfuWUtbMevp1tL58Qnx8DKaYDYUY3xHj10LRW4avxhjd06AZt+3txTR/LMhLsz5HMBoN
	UQbWbetzw0IfzCQgcxK4xmNe4vfJQzHJzT5U40rTm/JmC9zEuwXnIFedsdbZt80L8iJMjX0c0Wu
	WEDGY0f5ldmIZlvsM37MAjkuKtkdMvsEVMOPoNRoJ/8KMERWqPDxjlBR7jm38JmkzZ2U/GmbAQF
	dFz7JfMiQd0xBuiY9AlsHcMWioi1iELP8aFy40M9N2oEZbQpg2d0gzr7kUnGICXy3m4dHjLBIV+
	tDYTrIhbzpTmKxf/BCRgLCCXb40MOcn4Nd/FVrERwYSSCdUKaG72zPuZq7U6zh9AOS5wMdooaQ4
	5k6PLaRzqewBxzjxY7xCx8NhlGdBW15lfe
X-Received: by 2002:a5d:4688:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-4603061e47amr18261428f8f.27.1780928898275;
        Mon, 08 Jun 2026 07:28:18 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm53479588f8f.33.2026.06.08.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:28:17 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Mon, 08 Jun 2026 17:29:19 +0300
Subject: [PATCH v4 4/5] sh: Remove remaining defconfig reference to the
 pktcdvd driver
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-remove-pktcdvd-references-v4-4-72f88b04cc87@gmail.com>
References: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
In-Reply-To: <20260608-remove-pktcdvd-references-v4-0-72f88b04cc87@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=qLq31BYjVwoita8p3VYbMVHsnGBFQquUbQzcOZAQW8k=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhiy1iwcM25Xkd7+XZ3G9wyYlevnK8Zv9mgt/OF0QYeZ7+
 P0Jb8vnjlIWBjEuBlkxRZYX5663bdhzJuBekl0LzBxWJpAhDFycAjCRzYGMDJ+t787f9PvFqugg
 5uYn71v4UnluLU1gP+LcFD053+vXsV8Mf+WeCd1hD5963TmiXkXBOS3zxWLWM2JmYbsczBx3M8p
 t4wIA
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind a
CONFIG_CONFIG_CDROM_PKTCDVD reference in defconfigs. Remove it.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sh/configs/sh2007_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 5d9080499485..f287a41cd38c 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -45,7 +45,6 @@ CONFIG_NETWORK_SECMARK=y
 CONFIG_NET_PKTGEN=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_CDROM_PKTCDVD=y
 CONFIG_RAID_ATTRS=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y

-- 
2.54.0


