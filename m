Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB4606A320
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cG3EqPBG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWGDB1Tdrz2xpt;
	Sat, 21 Nov 2026 00:20:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795180826;
	cv=pass; b=jUBcP1cm3iWJpiXgGG0+RIpjXjq+iAZRLP2H/YQmHSMVEJjHdxqs7TjmQNzuJ28twpZZxY0Iuf+P0tkYt2SvNUlRXP4wbHHLd81oMsVWlyTbxezpP9Lywd1BowCQOzgl9CV4Y2ewB+M1YLS3wQ6ZInuEjCOYXMrr18WxM6L054PwfQHyNufNxV9Pf0jRdgjcOUV5y4jFm/WfE+wEz1iwWM0URlM61ZF1wd+9SQyshc/ZXZsV323Hdh+3m9fqKALc4cl3rX2+ZmS8dlVCGfxT4ociEfuqT1NTi7FLr9lFhPgSmALy6IoSZVVR21as4bGugsmFvpxxTyuIZpwYSTlqJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795180826; c=relaxed/relaxed;
	bh=UG/+FtkvLpFLlhRjXHK8IzxoHZEuN7shKZsx9WuzrBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDciHsRgc4vbzppcErpKoWEEEvrQqcpYvN9jvpPr2doNOn6SyVApSa8mHaRC85CsVRPrzG5GJFOYXeFA1Fle1BnOMHi3+OHC2Xygvh/t0Rp01zeE9Ol/NtnsnUOj6TbDrafamciGMqv0a14H6A8VeAt4Uu3UAnOKDE4W+muWEuS5HRTbWT6ouhquhB/cP80rmHYSEI+ha2H1vk+fTpaTufOkQWb0rbA4lQztGJSPHX/W0A38/sFMiV82PaWgLM15RTzZ+6xYWOSUHcXxiyHvys0CnPzZD3QASUvost/5rCbFKtu0o2yO3qQl3yk/dJLs9ZyTcL7ZfnZN22y6nOtkvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cG3EqPBG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cG3EqPBG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=lefteris.koutrakis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWGD84rMsz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 00:20:23 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8b2382bf051so535153b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 05:20:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795180821; cv=none;
        d=google.com; s=arc-20260327;
        b=fk4ZoLAe4tOMXvRguP9u52hU56oqSa577WAxUbHcyStSPse8q+pJlHlOYcWURrWAjL
         IdhKSZuvB+edHwYmRRKEHDF6uXPCnz/G6gippUO0bu1yFI2odKygsT5tG+KuEckGlQQw
         PnoIBoiON5A+7ryi+kLMopfxJyxxyV2F5ZR0Iu8Tf7zBBmbej6uDw+fxS1uLKd4Y4E16
         sLCjvfCTZ5PtS/Ncf9FG2FFy9SFQ8nH/IDtSU3QKN/G3LiIXILuji9h1/5TF2aInsgSC
         u7TF7JKYvUnJwTRoxkh8hynohEzzoMSGf230VdFkMqk9I1bBoPunOOdS9pQkrLsMiFCo
         j2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UG/+FtkvLpFLlhRjXHK8IzxoHZEuN7shKZsx9WuzrBQ=;
        fh=I5dgyCrFb/gdtHpnZ+Aj3mLYS5QsQQSJxoUIKYNktuY=;
        b=K7NZbu1DJebKTqanNXHhxE7hkzKmSmrI35d/VbvMoh69lhRj8Uuy2wYHa+Cp70LgE3
         F7eZ3iadbwY+BJ83Rl7t6+VPWFg8wfhIp8ymQW3dF6VMMHW0HWdFxtuuUNBOv+J7FEJ7
         HtyjTx4ioylxKuZzJyQCIIj7BDbuJiXbpwZuZDAnhBnMp7zNVZ/uz8Z7Rybp+RZLG9a9
         +cLIzeqNGXGHW+09+ZDFy65l880O0ShEj63sj7iTcA2s1uZaSqBk1py5AHq+g34QeTM1
         fCW4BDpGhfVWBLaJRG2oDhYsOFyRKX1hr/nzkqeXnEiEDcIrdxWSxN0kZpgChSYEm3YV
         NXTA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795180821; x=1795785621; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UG/+FtkvLpFLlhRjXHK8IzxoHZEuN7shKZsx9WuzrBQ=;
        b=cG3EqPBGFTjKLYPStiY/KuufCS8Se4L+hSQkje5ll1hQVc+1kdHYCk5sEG8hdwaGFd
         OJjROXS8EIL2dMXaTxmfyGJ1MoFn8TTbUO2dBf/+v/2Kmuxh+8u0xkU0B5nM+DSKLoyp
         K+YameNfARd3hlwWcBhNTA0+YsB1opCQJcEIIKIPWpy7H11yGQf5/gw3QauHeWwQzCXh
         buIb4uYJuOqdOOizgEoU3RdKvemUp+gKAbNiaHoCOGl7h4tJ4wEjLmQswzXTNpUZlyMy
         tjT2cm9lW737z8EuddNoJ3E3x2BU/JuKgfRlLFL8qQFeDlYc8BHPa050jpsWuxf7YIZT
         2Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795180821; x=1795785621;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UG/+FtkvLpFLlhRjXHK8IzxoHZEuN7shKZsx9WuzrBQ=;
        b=rhE9wkdn4IPxM4wxlXar0lyxtFh92u3NFJ58zQWfS5naJAH9x5YEyESIV5UKqyg/sE
         HHuoGshUP1KjyEUBWVagJkjo3pnNhNVHOslIlMwqTZjiMTxY49gniXWqFxuT7Y7ojWaZ
         dhvXLNBu6quuL5CyoGlc7eBxf11+Nbz3r92E+9omLqNRmfx62/f9yhaQyfxwwY2FkPYS
         1pTjyjhLgbXGvLvhorgmkyT00lXZFYsM6YJ1/yOJYrmb6mUp8xdN9y7X6fs7kw0wp/gz
         w40woUXW7+9rn2R9rs9tvn1bqW9Td12gz2q6PctC2MrwXbOkN4oDSQp072L7/OwCYpXz
         XAzg==
X-Gm-Message-State: APuU4Z/gwNCwcNLaMvx0ZyS4UoFJ2BTI8WRmdcb4gFVRMCyIYmCSYbP4
	0dUyLPUpCYdli9pVSFvMzITP06snRVKCO6dojc5vq2r4ZBQ6a2ictt9vTXpQ4j52JKBQOK1b1lj
	37jcfTYbKIcnUcoY55QkEN2JP0W/pBLuyd4j8O+jnCg==
X-Gm-Gg: AYBFou3lofnbUzewZOkrfOYbFt0x6tbFI5aDEjXyY4eDsT7HaQ2RENG+NkwGR5BjDlJ
	3QBrpqeGKWkpbxxPxDc2bp8rtxSXFw7oBg8e5hQ0hsJL7uG1cCRLVdUmQ/QDFUzAVDS0LOj9CH8
	VMgw1Wq2diZRz6YBYh9+XRdSDhB+XmJ/aHo3RaMy5/wYEBny7MOZVTeCYT99ALj5S66iAi7bS8m
	khgnRo1DJyUSYdI19LeP/TjSbuS1ODuPi2OHpTlzD9didtzTmf/xGZUJqWcYPjjcbYALe1jgUCy
	ErGB2DPRJvqfJHD5mALN3yZIoiU+zb9gyaeGxW6XE9LdtDvqyPKhlYUSyqZCElaE/EAcFs52MZP
	bY6b8NPPCpiwkp0ZihQPlfAuKPGNM4/CZlrYG/4k+DhTHfYi/gbWSPHMy/ZUAH/ufhubpM1eCU7
	Ra211MdP7GjySlqrGsy7joo1KmRwKPsUy8/+Jtk29E2qObTvn5L64=
X-Received: by 2002:a05:6a00:124c:b0:8b5:b676:4a90 with SMTP id
 d2e1a72fcca58-8c8794b98a3mr3126684b3a.2.1795180820901; Fri, 20 Nov 2026
 05:20:20 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030125024.612396-1-lefteris.koutrakis@gmail.com> <20261030125024.612396-2-lefteris.koutrakis@gmail.com>
In-Reply-To: <20261030125024.612396-2-lefteris.koutrakis@gmail.com>
From: Lefteris Koutrakis <lefteris.koutrakis@gmail.com>
Date: Fri, 20 Nov 2026 15:20:10 +0200
X-Gm-Features: AclHuK92flz41PL9Sb5dfrDaVsUaZV45mmq0Zil7HOyndVUpO8HRVID_wLHjZ2U
Message-ID: <CAEFrfdndWX8_xP6N9GzbU1L_ajrGFE+4P260zXOCKqBiN665OQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] powerpc: dts: fsl: Add support for WatchGuard
 Firebox T30
To: linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk@kernel.org, conor+dt@kernel.org, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, 
	sshegde@linux.ibm.com, maddy@linux.ibm.com, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Gentle ping on this patch. Patch 1/2 has been acked by Krzysztof.
Is there anything else needed for 2/2?

Thanks,
Lefteris

