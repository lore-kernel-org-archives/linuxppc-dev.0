Return-Path: <linuxppc-dev+bounces-26013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D99C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 04:53:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQWKf4YRHz2xGr;
	Thu, 20 Aug 2026 14:53:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787201606;
	cv=none; b=drZmx223Rp76igt9S9EaKWt97Nd8s5uYQSHQy+C/NGI3UX3pVcRfGPFePD8Ho3DBwrBPGa+foDrm6k1bZBtJC4z/Hjq9vZYbVs9S9xyJIK0yRnE975JpIs7lDRCLFRMALzwtOM8WbnK3N4/0b//JKsVKEJfZuSXB2En9mu1ZzmSpRV51MqeCJ+0WkpiEanTCye2et77qytdhsxFMhzaeV3WzX1aHdl5BYHwOwVfR8Ok6sPegLGWO6s2OIznz8PuRsHRq9H+mkDbXUpBMdlCCfEeNC7fS5wSY22JfRRjSmLNmb3GhI/+8Cli18WHKGobsQo9j+ypd24lr4VUhjFeTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787201606; c=relaxed/relaxed;
	bh=l9wj2SfAEFlyWs5rfPYIvPGryxF2GcrwlTasIRVI5Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMtDhKnvp6Svly/wMDpYfd98W9xWN0hPY76Nhx+Hfajg1uhzxrcpENAjOK5jK4fWg40/hKHRfjdxMRSD3Zv/n5jdkGSSmB/kVt+jfSkixEQZfMTlzx1g1iZzVfcVkfmcLrO5vtk4n7W7ZWwtn9nEP2GDfaRYPauN1xQBlZydwCuU056AmK4ChILHOFxF6Ky9Y6idZnXbUZBzl7Fz5SH21lnjclsX5ouysvkeayc9Ta6oXZ1wjc+Sf3rGx2g+DD2+rp915AA0LxbKSIJNkdHSqdHvrvk4nXXvQoKlsZKNfknp3FEg4T0DZcCDKL5WjogtAGRLIAMYWssEth0Mz4/R4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=feOuuaid; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=feOuuaid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQWKd1NHqz2xGZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 14:53:24 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ccf2360620so13236995ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787201602; x=1787806402; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l9wj2SfAEFlyWs5rfPYIvPGryxF2GcrwlTasIRVI5Ds=;
        b=feOuuaidj2Wbnei57AiXZI0d7OeSHxwlYDvfON/Hx2QHh99ATGOFa3Zj7QjIL/uIJo
         xDMkMpG5x8KdI1terH7yg1002N4gigQvD4mBjREafth650LQQmrwQlA/mrbQoQhJeye6
         I2UQas6WiTX2g5AqhI0zHUqZoLKeCBmxjoiwYCLLEH/zLHsivuqplyAt+e2STdgbsv3e
         jb6eFHbTV1Tx+HvDZRGnldmXQeYpaWwiIijnjwdes3mlnVYcv9CLeqC5fWpEJem21tNy
         kscchRirx/t9jQlTu2h54cwulCVBEnt7oIPu7CykilmWG+xCq7oD7LZU+TtecKWaoMoW
         Ls+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787201602; x=1787806402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l9wj2SfAEFlyWs5rfPYIvPGryxF2GcrwlTasIRVI5Ds=;
        b=CibWn1RTta6FuJ36pRnDlgp3IpQopAur9po2IdqHcSOaqbT3JZXML634a39awgar0d
         X/6yWMbG7N1rSr2Jav4FlgE2ccK5e8DZySfwVSUon4UwUiLK5c3FobGKd0aWHYZBbrF8
         78haDkfbPam4qt1xhzpxNThOrPwNHuc+miy+XxBdqhc+YzXwqGl9AGB1fjvOnxcLe0Pi
         7JtkSMbZM2Qpp9QsF2p1lZiKPF1690pQrQw7WxR2ROQuZJZ5dmfp7FVumYrcg1Rm8Y0w
         926ZWztDVKTyLynAi/0pKBRetfmGDvztEqWiepqOWIFHoe1wnF3qWj6rLI0ARp9ax789
         B9dQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr6WBisjMzt+PyC3cimeqf5WSkG1RmtZuTXB/+ETvgp2Rn0kv0izZ3o9z68ikZnavtuwcoiF/T1CkTE5xU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lV/0NU54oCUwYv5NFQJeCtWsJhV44foR2yzOJ5pnSoT6fKJsO7
	Q1VIFZlT79zC7XV1EcoDZVxO9wohN/UYPQaMFJ17xqWB29jpGmaBjm99
X-Gm-Gg: AR+sD12BCrIPgI++h5JIGrLTofXljSEUs+vMeoBRpVcnzKnsrgu9HSDiR5sLgbvqHK2
	+hHvG/XSXsst8IbDNzUW2Yz9MlYwt/iTL/oL9/jG/gLRMkg9ReRgNSDA6pRbY128JK15Cuwv7cQ
	3+yFEy56iMAc2q7gplevv9IscilRy30GAdNyjGx3fdy9F+7Cn6gH7700Gi3QnRc3GuGb2/bYkSO
	v5WSS6Lz/egG+dZDf20KVSue2N6Gbgh8DfMTlfD6a7rlQp3+gk0xTBunXkGmzE6JoK4Vo4GoJod
	KwmpMfscC5V+isKf+INHer5O06IVeA+lI5qU4zAmJx/xoTmn2wUsKzksY49C1plrMGF8kvdN8gs
	zK+kXRaQPuSG+d/VRp4/QzBOOLh7wkLAIxog6Nai6+IGloKU8Z7BeVfrikIQSh8hfLFIvdiC/8X
	bxthsqhk2IabQeSDynC9vDI+q5qFjJ1ZZwstFqRQTJvAWvfr0XQ4OsGwbpwRa7HoRzk9hKhOO6A
	RS69/eazEC4NA/YzKWM9YLGfyNjWO9DaUAqXQ==
X-Received: by 2002:a17:90b:4fd0:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-39580a4d031mr18756576a91.3.1787201602401;
        Wed, 19 Aug 2026 21:53:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bec30f49sm11190678eec.0.2026.08.19.21.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 21:53:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 10:23:14 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Message-ID: <aoaHtGvA6rAcQxwL@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
 <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <an_xbqRgm4RaRw0r@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <999c327b-3ec9-4636-a29e-57795d333912@linux.ibm.com>
 <aoVrvjiSMmEDbwIF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <d9c19203-a9d8-4815-9f60-97e7411976e4@linux.ibm.com>
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
In-Reply-To: <d9c19203-a9d8-4815-9f60-97e7411976e4@linux.ibm.com>

On Wed, Aug 19, 2026 at 04:22:31PM +0530, Shrikanth Hegde wrote:
> 
> Can you collect vmcore with panic on warning enabled?
> 
> It maybe nested replay of soft interrupts which maybe causing problems here.
> We should see the regs state.
> 
> > Regards,
> > Mukesh
> 
Hey Venkat,

I have identified the root cause for this and discussed it with
Shrikanth also. We have agreed that the fix we have now is a proper fix
and why we got this issue now and not earlier. I'll send out a new
revision for this.

Regards,
Mukesh

