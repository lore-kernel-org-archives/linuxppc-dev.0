Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16708606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wlaku6fl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL9y5BWtz2xHP;
	Fri, 06 Nov 2026 11:47:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793926054;
	cv=pass; b=SRqeAkIT7OnAhoCqJLViJ3gJYx2fwQwNy1MgTIaOP1SbKVTed5Cyhb0idf11NwtJdjCT2mDjSbVzOuNX3wygtRsRboO0Ddn688XDN5WXMx/oi2hBRslhmkTbEI2Zh2uJLIlSNv5945hBWTDhnb360+VINrTZTJ5JW+8PLwgKmL+dNdUXfS4SoQ8RwHltFJ37SICgvRL2mG6GbvJO0hBovJY7hF0ZSr9Vd8cQlW2OnznPRPKrFkYZ+t0cVnZ3N1DLGZeeVkpFZzOiQuBztkgEdo2pPje30QrpRtHIs7N1RUgxeIgVOaTpdSlCp4TF12auu9pOLypzeqeIyfuZoUgdpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793926054; c=relaxed/relaxed;
	bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3tMGeewTqIBCxdRvEJTASeqM7mBNbYoyHKh+1zmvCie9qMD3Y/S1AZk4YSlQovIz8sih62wUrya0w3RT9BnSQBSvNRPhTmj9Ikxq+2GCHftSqPWsgfuTDUn/IBlo78toqSBY/FtZq3ngBSIGvL/V+qRq+exDTBhJ7GGqBL0G/LwWo/IBBqJ0vaQ8BDW+JkXHx4zSeSXx4ceKUo87nSe1G8nDGuZLCs/92q5xu7jh46RF5DZBKm/3Zcmam35GrQcoSmkgs3IwCqhe/7XngLzawdOnBCK5cAdkDKxiBKsy4sjzN8YGp9u/eQ6de8p8OKcpv1wIuvgm69XJzo6x9BSZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wlaku6fl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dmatlack@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wlaku6fl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dmatlack@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL9x4wYCz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:47:33 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c445c95d553so13927566b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926045; cv=none;
        d=google.com; s=arc-20260327;
        b=cucU+jV9o2MvJnSlcB/uJzKK+ttjlXiY8tr4Oemff2yRoaNXHtkNurfUpjaYESFYpF
         vNSEuD8RF3Q281MzhSeQ27vpVLd0pFJr2qN3WkmkmKJchyG7BDgjFqN/AHqq8OMcL7LH
         jGFCsFW9D5in7W2q3pKhb2w5dUYZBE9Z+nqBHbSrA1CzrGdletR/k2OQNUBPmIux3IdF
         A7/gXEiCoNwrB6jckeCvH/sdyIVwnvUqAKabr77O/jtZym1vfQndotFlNVOStBIiG11o
         06BCc4K9dX8NL2qCJJXLrebWdSeycq3qPwNVD6TxJw/CJ0IpWMH6oxBmOeNJnFH+uC0s
         WzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        fh=FRG1T0+E1vqTFOvJw3X+VjLQRetmP0vZUE7ZOusgRhE=;
        b=buS27ATXwzoL0QUCXFmT9q9EHGEMQaLitI1tCPQdwu1+b2O3HGHN4gReamCDIqvkuT
         f+FhsHGHx+0E7s361DOz/GpE0jI6eQu4kbHK1zzTuwZPooGqT0RZeCvS8NXT1e3S1KXe
         L+PBzUDK5Qa/2nCQS3H74Zu1Q5zPk8+ajSI+ZiewabtMLNlANiv0QwmWMEiP8B17+EBr
         H2xUxkqZxAfNNH7YCLYShaJYijrsGn+TazX7iE9Or+ngP2ynQWJHvrAkcpTVFtZXjqPr
         viyCchfQUZ6ZwAStnjmrWHvgcmMndhHjPajOlnmK+UkC2G/CpAXX/zq0SmFHH3StgfhB
         crRg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926045; x=1794530845; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=Wlaku6flSVdlBciBUdBm4po7vozK8bJ7QdTzBGyONKTcwtYrBAmpwaIvNDYc6khCuh
         U+14Fxn8tnWE25u7qfyp+wMDSS6XRIblf/9dyNRRyRNAp0eOFS3YeHUsGgA9HK6DhKN5
         MCrOZAL4ZO53dZbMf05sRxW/kZyxOs8TZXj9wlHeYzRe8at1MTG2OeXZEEtzGBaNanmc
         0Zz+NhvY31oc9IErazisGUWcSnlSLOw15qTpA3KhV6ZwRxmCNSCVtIhAM1RIbZiISmu+
         R2cvuWS3hFI6MJPuzYtzFcPPXpIm5F1u5ZcJVGE7mgZLCozAbff6nEd7HQ4EIIqjFLnJ
         nClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926045; x=1794530845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/Pn/3oT6XlOFb2SsTcDdo2UH2iFiBAGJC3TZJWHkxg=;
        b=UYJsWfLitdnPfbokJuz+Ul+Q7kZZ0tQz8E3iXnnScCN2AMs7pkuOM8X+hRfim0LT85
         Je6ZmcHazFFNH4X8SEW16809nKFcnQtgvtlIE4FaC9l0OZXUdADuMCRWV0rFL8C6JLU1
         HpoANK6euBeBWmGuhtID5SYSYeITtOzguUQWhe9pS9LzFBl13RXf7z8uD6uG4yvhLJLY
         TAlybBZZbgJ7aG3uV2VuyJwirwOAdr9LiXJmcjkXbMVpWGZbtrIrzuQilundsXSBfomz
         Au/aK85epp/CI33YnjRRe6Vmlky5Ur9EuK2NPDVmOJvXg+jjd2byGm9FRR5Wgy0ftpMR
         wMuw==
X-Forwarded-Encrypted: i=1; AKwUvBxw0yf1ETyxdQnxhNHZTMP/kER4r2TitRNA9BUiBaWw9ew1ZzQQLB50FOYO8CbjXN1c7uQzFnALG4/0gb8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+W4fKa2Lm+8KQin6+6Of84ErI8RrdgnOwjQB0/9iEJ7l58gGi9
	Qu35vN3ZSgsvBGlv2XoBznFNGYXxkpqjycwWMCqhihd5R5Md5C35YG9pjye5PMtrrWHV/X0fizr
	m3JmwHMTSad9YU3fW+bo2jh+oIzqWiDNrFSFKMlJq
X-Gm-Gg: AYBFou2teMV58ZlfzXYJDT/vl+XywA1QDhOLyeHj88foJYqlIfbs+rsZtbBGvd6YZXQ
	Szzt7ioz0CGLEGrgvTymeY1Uc01Z+g5aAQLJ8AOox7onPXO7VdPIM7OQR8XlmlZNjZz5VQOemQM
	BCah4NA7ITl636J5NiYVvfu36H8J9B6befT8htKVtpJRF4Gagy/CZWnsM54Y8lDVxYiBlJ0e579
	zAB/6/OVYv6IHMU/+Fmk9qg10Mg7RUZdnUa1srlOCOFkXN5vmjEvDWaFXHEpHy95Lhne+5XYhym
	44BPdaQUkmb0v1Vkl9mWoyPns87NR4gugzze1cnhXuVUgnE/0S5B6BRc2UEsjLdCuKGryaSCDIB
	xFkK8zKP+Fhi2Vl20UIJXO6Rl/vS8QZNOoTy6/A==
X-Received: by 2002:a17:907:8687:b0:c48:a838:c16d with SMTP id
 a640c23a62f3a-c4d34c333bdmr88685166b.30.1793926044754; Thu, 05 Nov 2026
 16:47:24 -0800 (PST)
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
References: <20261106004218.604799-1-dmatlack@google.com>
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 5 Nov 2026 16:46:58 -0800
X-Gm-Features: AclHuK-6t-LHK5FESHi0261vrVlL_qd-J_ZV2n6hQwmFkPQFVA0JTaSgUA12BTs
Message-ID: <CALzav=dOnBUdYKN8ucD8tMF_5RuQZOzYG2aW=K9Grd5itgvnMw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] PCI: Index saved capability state by
 configuration space offset
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:42=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:

> Merge Plan
> ----------
>
> This series applies on top of v10 of the PCI core support for Live
> Update series [2], which is targeting Linux 7.5. This series is
> targeting Linux 7.5 as well.
>
> Both series will be merged through liveupdate.git, matching the
> agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Apologies, an update I made here got lost. The PCI core support for
Live Update is targeting 7.5, via liveupdate.git. _This_ series should
probably target 7.6. I doubt we can get reviews in time for 7.5. And
as for which tree, I am not sure. This series is mostly PCI core
changes, so I lean towards merging through the PCI tree. Only the last
commit touches drivers/pci/liveupdate.c.

