Return-Path: <linuxppc-dev+bounces-25727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5F9C5AD7B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 06:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK1Pm5sH7z301Y;
	Tue, 11 Aug 2026 16:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786428476;
	cv=none; b=YUeWF6cEjo98d7PpIM56dTeww98X6A/MA19YvWlIC9JoADLj6bPbfNrWwBDDaRgyGOtWKj41crqgqnvGli0+SEQvfWARokM15SGeOob9jkvI0PbgPt/RkxF/3efiXFnPj63aq7aYIfHOwvJBIwrK0/iih4/PUcA81octaI5pfICjliHDhByPyWCcuYPhDgHgWe56EM0QeszRD64H3U76v6cPQ7dDAlQMaGSUFPErgl+xa6vVT/+lWXyVYk6zEVKCHfsN+Qx8FliqyeZGjz4VrXpgs1xNy46Iw/W88v9bMbitvqmSeY/WE6MyZ6O/B9DjxmknRY11xyX8nZ6HTaEobg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786428476; c=relaxed/relaxed;
	bh=QtQ4biCxOsHicthc8BowONWL5REoDHpt0IYnLbdJh+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMz9Y3+IXr25lt7tWtX9XEo1K5fzyM1G9cjFNshJv/5wrAT4PWKv+VR6yKD42CqhaclczU082aGelmtmE84CTO53g7RiikYrgkEyxnGZABjxFjexbm+sS9N6VfSF1V/wJu5CVsuu2EcB1CTPCVRxRAIBK/AZqRjL5P7lUPhnVHI349sk0NNTgPitWKatarPkCADpX8gwDUkafbx+Iga4pPi/eq/fdE5/EaU5xJQdMmWJhJmDJViIvwdGoUgDK2Ls29M7TQluPF+wHZP5b55AZ7HN9g3Gs9AX4+FaIuzKrTchmkzTDDeKxw96qHYMGLhqwZx/LI0Sm6nGFQI0LBYutA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c44+tE1p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c44+tE1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK1Pl5XL9z2yvG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 16:07:54 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso1712150a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786428472; x=1787033272; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtQ4biCxOsHicthc8BowONWL5REoDHpt0IYnLbdJh+4=;
        b=c44+tE1pWryIU8aGGPgIUsvN+r6QJt0Kw6ckvbtV6cShCfvoN6OUU2v+rE2nXYDH01
         xsj0DFXo/Sz+PNJI00nHwtMvUfTp81kZUPT4N3fz8a0UrFmx6qjLdv2y2K5Dn/3Dzjt4
         jCi75sJqwd53hDKOWbnLHbSSF5UPwYi7Q1OPkdvNOk3KaIaL487yES7QLgFuwgJ499LR
         wPzDLxdBolAPkRbFqSwss3rcCO1uGWwD45OrVCw2s6tcttrORp0OBNljADda/8smvb5+
         uK0kLR7IHe+/vleyviGIlg1mcHFD6tvRnTyD2KDJpfsIiZG1/FEBx0s5hXSoV8+Wr0YU
         26MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786428472; x=1787033272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtQ4biCxOsHicthc8BowONWL5REoDHpt0IYnLbdJh+4=;
        b=pmKsWnNAL5qHCOfRQdcMPefbKIeQmFhDjjEO35HgJWi+C6vZwnTrFD/TQ8SN7Vt1+W
         Y+d4WG+yNCY2pmGIa6cVGLUlHQu9bqZp28TQ3GdiWWCV+HhLsmVCrb5dTtJklSEBJ46X
         KQ8CR1X5apVnIcgev0iiACF4e1KN2L+J8/DF/110eBzDFoN6J/qHIT0Z8BZBglEyR2U7
         9K/7XLOY2nqMKoGJ/2sqcVszSdmnhmknm9ZIbVhlQE7blhwWYe0qoOXIdJsi0DZGgMnu
         PbN0nT7IGC3HAz4ZPnii78OvNfrc0pJZygEabsufIG/OjUHp8N699oKXRCqnsAxhtZZX
         LNQg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8PgNcxdgK+S53tgv1FsrN4K8wuB7pqX+LMXHNR1ns/kiQyIMm9dFItz6khyYYwIUp0Xss/ezBFPgWotE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhYclv+kpnaWCbjz0pI8rZRBiT3tlP59aEfxpoCIPWm0rIv3Il
	qx4sA6cjaCMJgHbb7LRUFUYOXssmGL0ctFAOdnVsuIKBwAFXL2KFCpN4b5v//g==
X-Gm-Gg: AR+sD12bwggqfWS6BGAr+aNmEjew3s9dxai/SbEALTdvIwFpl7BZETkhR3Kq1YBEI13
	wyYZM7GLlU8h6SDaFmr4Pa/H16ampp3ZsgpRHwEvSBvSOAw7sYbyPi2WJVGa4toScddPX0Oy0eQ
	N08Ir9PsWBoCGtGOJkcOgyVUSal7hPg0X9aJJev6z1o3xPjlcjtp+ZQG6cdalG5pddX0SJnmpu3
	jWpgKUOgzKyPKopRUrlS8gdf4+euh4bT1zC/yqMPExvh4wnI+C0HX+8Pf5FPr+pZklQ9onOTtZh
	IYYgtaem4qhOYE6twpNJ0OktMtbBbVo0wf6j4A3RtjDU91cCMkAKbblrM3hiPQBtav32TrhLEhK
	8reQre5hqkT3PjcFhBMEbv0IQxdHwlEHwv4bt/Npl2pVzWWCpxyBultujTx18FGCX+yG/Qw4874
	C7i/i0Luaw9ALGUw5DSWFErTw5yW+JR+4YIcqT97AxifwDgtPVqHMUnMvfxccCZjh2kbJ7RmCi4
	Tpzn5BbydR9E9zWev7O6lwl00wq2qG3
X-Received: by 2002:a05:6a00:8d96:b0:848:46a0:3d74 with SMTP id d2e1a72fcca58-84fa86ab16cmr899076b3a.9.1786428472590;
        Mon, 10 Aug 2026 23:07:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa91db595sm126742b3a.27.2026.08.10.23.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:07:52 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:37:45 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [REGRESSION] Power9 pseries boot hang in v7.2-rc6, narrowed to
 PowerPC GENERIC_ENTRY conversion window
Message-ID: <anq72IebDSu-wWbb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com>
 <e27eeaf4-c2c9-4ef7-9e1c-0a5fb45755d0@linux.ibm.com>
 <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>
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
In-Reply-To: <6d1b5f38-f4e4-46ca-88b4-7c18dd6c6280@linux.ibm.com>

On Mon, Aug 10, 2026 at 05:19:27PM +0530, Venkat Rao Bagalkote wrote:
> Hi Shrikanth,
> 
> 
> On 04/08/26 8:23 pm, Shrikanth Hegde wrote:
> > Hi Venkat.
> > 
> > On 8/4/26 2:04 PM, Venkat Rao Bagalkote wrote:
> > > Hi,
> > > 
> > > I'm seeing a boot regression on a Power9 pseries LPAR. The system
> > > hangs very early during boot after:
> > > 
> > > Quiescing Open Firmware ...
> > > Booting Linux via __start() ...
> > > 
> > 
> > That is strange. not sure where to look at without any logs.
> > Is it a specific config that fails or this specific LPAR that fails?
> > 
Is this a specific lpar or all power9 pseries are exhibiting same
behaviour?

Regards,
Mukesh
[...]


