Return-Path: <linuxppc-dev+bounces-23987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF19C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2026 04:04:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gxJBY2QHPz2yS4;
	Fri, 10 Jul 2026 14:04:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783656293;
	cv=none; b=RJkhm+ANDHFPgVMd0A2LOnpxUzX0S9Y1HN0ESRpK3Xfp6x2hwP/k93j+lcdT+EXoH3Fk7/QJB2ifFf4rAwBwrgCwvLTqLt6HT2QlF9xqYczllW1jFineyjPi52y/zsRSulemh6NnPeZYnldATSoItVNeQVmmEynC+qte1XQhCWknBrfESZvCdmx9rqEyVeSw/UZ/vrCO6052BbFYFy5CMh3hdbf/DOa+3Nxx/vnii0QpA60nAcXZBS53OqRFlYfSGiqo3NyU4hOFP9Nn/jJ45gY9SXdpY9bf6EvM+lsNX9iz+7AEIl/VjoC8ccLzvnc45J4gSB5p9nSZ44ltSJ3v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783656293; c=relaxed/relaxed;
	bh=dEEM1W8SV/I+n0+2vd3SsJ/nswGUFBRGZ96FxUqCVl0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Zf0BMBOl2XD/dJaAMhiI84bJOrWgyexxWH8EtRbZhkwVhgymyO0VrC32lTxiFvFUqedNAU+AlBZCNuHgauB6/1urDtAbE2PNoPxtpKJESkSGPt0SybbBAcLQswlhTrn8VkRuJ6sG92tdiyIbIf8cE5tnmboi7mWEcEUQeMl42p4BG2MsJCDDvX7TfXrKHFxl28gounLoJ+bDEl+ZZOSZFyU2d5dZT8TJGM+r7wJa2/52+jYe2xQWpCmA3HqpDpVVT0w7fTJRt2NsLsY6BSusQhXjuUxkY9idhu24XP0TnTPdPRPfr/M7EZDSqgzMk5qBrXLP96hJiVXDSJQKjjrqzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oe/AZBNu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oe/AZBNu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxJBX261nz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 14:04:51 +1000 (AEST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8454160043aso415569b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783656290; x=1784261090; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dEEM1W8SV/I+n0+2vd3SsJ/nswGUFBRGZ96FxUqCVl0=;
        b=Oe/AZBNus1U73NsawCxwOlLR43OJfKYKMeB6u139zHjSmZSlGpVZ9pzbVsR8vHJo/u
         uMYbCtRXyMYODWyGZ9Wpwm9i7kMIVBzBvle7k++cj4gVWNq4A9eBWZbPmdHXXj+vD8cI
         3bEuPFH+UK1zpQAIzlJRjIeps+Ur5ZDyikJG3S0gnNrDSLF5x2v+zKy4Uxhl/fr9/Vsr
         IdhmOsd8thhm9tHMcm+A3Fwxi5U7YuVAEmsQZ83lcVOt0ZOsyP7NRRhNH6Cpi9qM86mw
         iZQz3S9RzJJnMFWff6uJ+aEnfDZTAEefse5y4wPA0jlaqrg9xwEyxc3Yvd2q3cMMQsnD
         9WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656290; x=1784261090;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEEM1W8SV/I+n0+2vd3SsJ/nswGUFBRGZ96FxUqCVl0=;
        b=d3ta3epIQ7R/Jf+c+Vlrf8a5kAHfIyNj96YaStqyjb1/zdnUrM9qsosbRPp5yxNqGV
         DGTG4lNNbsopq6TPw3N9tlOFr+LwEWl+2cQ2l83pOurcYMGOjyR5dH1Ux/NO+VEA+dGA
         wvbpjOam4s1QF/dxG8waBlAZPCEwgx7vzyipSM8YSdD2mxUn9/jJOEF8b+2DSHA2dULz
         ex9Sa/gddBWwKN/O3jC7ZSIkGbMzQ3YOrYZNS5fKzFHTYwqAOEVIYIQ1QnCjC7ZFjyz/
         bINpdh81dXc8HO+Nb6ufsHsNBW9bRA8iXxayniBQS5aRPW3DP5eKilK4ovtt4+acUaoI
         WSig==
X-Forwarded-Encrypted: i=1; AHgh+RqBP6sKbJHEFREym3Dl/RjAZT0+Cb7j9Md9APQS3PVkq7a4hvQOgWu1XLxpu3gffFkqdAS2UO0JzIM1ads=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw1aGeUeQj7D/zMP4RLV3D6rR1WQEUYW39Q1piWIvDCjmLOqMRb
	ormtQVfASmnPNA4kpCWmSFCOeW3BjtInsBuVAv7BOOi/tXrDRT3OyNDX
X-Gm-Gg: AfdE7cmHhAVEkBErRpF42x4HBEAK6cvE/qvcDN/nM7UteAFvCB2kq8Xc/D+dgyT/A2C
	65UClsZ7QYrXXmh8nQOCx2zlGfM3ESk5gw5wqbwIhWd8di3yIQKUAm8RBdLzpxafWZJtxgTWNCT
	9RCqpulLJq94cWYx9sPiQF0fNkFY/hSHD2P3jScF+93vIyrQxG5jmyEgP4U7u9x6unH6TIhKaKi
	lDojHdTq4q2CjyEN273B6fNDdizIaYCUR0J5kEySbQFWMO4HfEZeiK9E302cFdBmUcYDHObmRnn
	BdNWsk/0HvxAZakLaNNX5k00YBTYFnuwLlU08oKqvU/xL3eqbAvmT5bHBQ5u09iTX0mQZTZ3pDv
	bR5+H3/9e3Fv77s5EjiNagTiBhINsJ82NGv2pQcEqw235RCzB+slkAo2SZgBq0A+5SITOQ2fpkq
	PlPiEp2aXxz6VLyXoFyLUZeQ==
X-Received: by 2002:a05:6a20:a10e:b0:3b4:84c5:45c8 with SMTP id adf61e73a8af0-3c0bc9c0074mr12212994637.24.1783656290025;
        Thu, 09 Jul 2026 21:04:50 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm37746692eec.27.2026.07.09.21.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:04:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>
Cc: skiboot@lists.ozlabs.org, arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org, Srikar Dronamraju <srikar@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] powerpc/numa: Simplify find_primary_domain_index
In-Reply-To: <20260605055242.1757485-6-srikar@linux.ibm.com>
Date: Fri, 10 Jul 2026 09:33:56 +0530
Message-ID: <y0fjv6c3.ritesh.list@gmail.com>
References: <20260605055242.1757485-5-srikar@linux.ibm.com> <20260605055242.1757485-6-srikar@linux.ibm.com>
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

Srikar Dronamraju <srikar@linux.ibm.com> writes:

> Initialize the return value once and use a single exit path in
> find_primary_domain_index().
>
> This is a small cleanup that keeps the existing behavior unchanged while
> making the control flow easier to follow.
>
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>


Cleanup LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


