Return-Path: <linuxppc-dev+bounces-25726-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D885C5B569
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 06:02:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK1HY5GXkz2yvG;
	Tue, 11 Aug 2026 16:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786428153;
	cv=none; b=mgrEgv9tafuWH+jopCm+TFqVBQVAuTE0PgBrk7Ihmb8jWUPvRZlpSjVtUatEW+yRac/ryHoIPmGZHB2wSYBan5et1Y5m/iPHrbNjHiP7Rifsr5KtqnklbJ55EyWK+NhMpWFWF4SnnBZXtVDIhJQB10TOwx6PwQT97wbb4gJNaZr2hOJpxNdA0sAe98YXk6UsMmDqGLTOoWUUwKCIRTNYt9njoRkHhls5RGY0/m8I+3r8DnwJgbX/fiGdo4QrPcJ5h05HBSuvsjjs0FU6RNJEZz1jmy+cJxYTzxFMW+RswN+yWksxe6F3UfYkzDvCOoPTI+LiODrABvXZH3LBmu/VYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786428153; c=relaxed/relaxed;
	bh=QP2FITneW1MbuiIpQp9V/CZwD5bV9NSMMXRy0JGj/pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWaRRk6n/SkczoZh0TrNSMA09eBjZsP3Djqki3LSgHG+Ewta8lrutAXq8N2e+YJnLLvcx+5wuyIyVB8aLQAAGFLu4LuWELpt5LtdzpeJrS8AnYqu7+v+e4OJDMMMxQTP6dhFdLUQFsJhq5ZgenV26v3KTBPfouW55aIfUvSemYLX1WUqQdYTitot3Mp+kyHC4k5xCJ8eYkdNwfqx2WCeqCN8sraZH6HorQX+fWy8m18X424EJT0mzXkxExcfqT/U02VHUDpVAoqD4oZDSwH1cTzPL26zkQ0sInN5aL9H1g2r2B11FwBMg35ijXs+UQLJBxqxY7mBoeko5fvVmSWD4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qw+uT5Ki; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qw+uT5Ki;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK1HX2d7Hz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 16:02:31 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cc891373e0so32466815ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428148; x=1787032948; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QP2FITneW1MbuiIpQp9V/CZwD5bV9NSMMXRy0JGj/pI=;
        b=Qw+uT5KivgoFOAcY/7bAK/+Gv7cQ86zeZDUHX7m8nvhg3bBo0pr643lBjsCJrb294r
         nEjhw5zAxJl9ylTFn1M223lBagUnXsc4yyfz7akgIOzxXobFoa2pTclKvGt4zv0xKnan
         rc7I6UQcCXCGcYTRbUy9cfeRoR5tX4bYALLdsq99Tt5nUzCvrJ9CF+M6ZgUdzcPZLP+4
         JItD5g2/JakU7Z8gyFKmPdwZJFbeiqnF+z+cpGTdWR2P1bROFvsXEQlhe7C3LiHq6/nW
         1IwIhujozuKtW/V/ZYbyq6gDDXk46/oW3ngjcSHSOS/V1LHBzAymn2HAkjpIBAoa6swW
         eyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428148; x=1787032948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QP2FITneW1MbuiIpQp9V/CZwD5bV9NSMMXRy0JGj/pI=;
        b=CV7stfsXXE6RD/MLcD0t7DNwPZzyMfgamt/bq7Fx3mVv8mLAsV7edWtLtdhpkTZd1G
         IBrlQQJLV5wzNPLjjzlF9ShRzdLq0QWvQPvpDBT+ANrrzvFDAGkBBI5NWjKmkviYue3F
         ep5OOmCjU7zEUeQRCopgMbRJK3vP+cy5//w+iLC5bte2dkr2tdxPMQXqOUDszi3FmiVZ
         1q0IKL4w6x/Aye5inqrstc1QzzSV2k+QnFmtmouVM+CqM+nzk2H9iFGSR/z/ivIwu2EE
         Ekrp9bR21K+xVieWRR5v/1eDLPhwg0aNFRQ6gx+qDwqzmVlorKDL3ZPoHi0uVHleAqdA
         /E7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoHpFvJCTT80hJCWu55pdbMS5k2GSP7K0TA9/OcW6GS4AkMZS3Q+wNAPVI8PMZPYQ9y1O+ZTIWnkZXkf24=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz20t6J22QztMfjXFP+RFkgJFSdASei8NYCqMeAEpOUARDsN05S
	40CIFSTF+sATcM3Zr/4zyew+h2jUwAtmTJXfdfJVZ+Tc9dIYxhVefhnE
X-Gm-Gg: AR+sD12EuqnnHplR+ViQqtrqLsPayrX+uhcDsIxHuw0Dhcfc2MgOA8KfeCSdoT7neMw
	thRsn34S0kOGxZTJ5JJDiCvQG6fb0O/HhA1mQu7DBm6x2RlQS1zUlhadlbBuCiz5RsD2FuIhuwD
	Y3YiMEA5XFEgmOHic4vBx5QukvqdjWVjFUjj/ZB0tuHYjt61q08DnY935AhhkXNrr8DleU0uIu0
	vvzc6ixt326+usqjbSR8XGlooPq6X/BGCxvensmqIw3D6ghOxan/EC8d04xXI02oqMtacleIWrB
	2iK1qcmMJWc16yqJ8Rk2yLZRDx091LBEx3Cm4ZEESYXFJ7bBGXqHUlWk4zKFHFWSLk1Ft33Yfwd
	GsGSH6yHRzXGigHssCeOf2kjH/r3WKBl3RXYTeTkjqeBkMmcLdy+3JUssRLpvDVqt8qJKQAkrA2
	1UMifkSR6rLPFOtjsuM23j55w2g/uOgFg5wEYIWU0mhCuSxf0TXTV3dKcoiKlNbd0ii5KaxQpq8
	6KBooYM0tkLSpZPyoNPblapK+i4+6b/Ra4RmDnER1PG
X-Received: by 2002:a17:902:ccd2:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2d317976466mr12832425ad.21.1786428148480;
        Mon, 10 Aug 2026 23:02:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d315f458casm1998455ad.33.2026.08.10.23.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:02:28 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:32:21 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Peter Zijlstra <peterz@infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] powerpc/pseries: WARN in __replay_soft_interrupts() during
 SMP bringup on Power11 (7.2.0-rc5)
Message-ID: <anq6gMOWzTLVGWen@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <6f9bfb0f-b14c-468e-bb9f-c157d120d0dc@linux.ibm.com>
 <e9a6d82c-8ce1-45a5-a5cf-e4476f97cecf@linux.ibm.com>
 <4505448b-59af-433c-93c8-05b13da1a6a0@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505448b-59af-433c-93c8-05b13da1a6a0@linux.ibm.com>

On Mon, Aug 10, 2026 at 09:04:34PM +0530, Venkat Rao Bagalkote wrote:
> Hi Shrikanth,
> 
> 
> On 04/08/26 12:06 pm, Shrikanth Hegde wrote:
> > hi venkat,
> > 
> > On 8/4/26 11:39 AM, Venkat Rao Bagalkote wrote:
> > > Greetings!!
> > > 
> > > 
> > > I'm seeing a reproducible warning during early boot on a Power11
> > > pSeries LPAR with Linux 7.2.0-rc5.
> > > 
> > > The kernel starts booting normally and reaches SMP initialization,
> > > but then begins emitting continuous warnings from
> > > __replay_soft_interrupts().The warnings continue indefinitely and
> > > the system never completes boot.
> > > 
[...]

Hey,

Seems like this is because of some code movement. I need to look deeper
into it. I'll take a look.

Thanks for reporting.

Regards,
Mukesh

