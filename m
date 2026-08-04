Return-Path: <linuxppc-dev+bounces-25378-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2EAC55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 14:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDwTZ1BnTz2yH5;
	Wed, 05 Aug 2026 00:12:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785852722;
	cv=none; b=HT1/J1nBN2btd+hrkvMgjbVpXRmD/qQhzkBV5qPCJj+UVvcN0JRxxb6BlOkW1+e64Od6G7jOXNhRHmGHE9XEkp2fdNAhMV0CNLWQhj8HD/2stB1pfNLYevF1QDZZCkWQlipKLA981Z8m8FqylRx+fsFW1Lv4VdPOsiUnF9YD+3nhCc070IJsPefYa0v73/CR50tYci+WCx9K/rZa/I8luDQmPBDnVjFcqIwYfasjjD+tOj/Gx6KnR+krUIbbQNFfBkhi5Ia62toCqIjGQMv3Ye3E9LgIqb5qLn9gvqBoc6tG2sbKWnNxfYpoPTohSWapmIhz27q7oOdebGOKmjhiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785852722; c=relaxed/relaxed;
	bh=vh4jiNB+QM/k1EF3hB6ldYl4nAMV7WkREZGBEOhBpvE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=J/h2d2CGtQZPZptYgky/H3LZ9+LCSNYCrnuY9y6ucFZGLJ49RBmXhQlfIGnIoJ8l5WOs6cJXtJVxkKzqXSglGkRaTEnlzw6VCWRokyv0h4Ab4XrC18Mx+IM6Gn3PQdg+KJlq/T2a8VJy8MqK0Kz8zxkdlqznB2yL04zw9m70+j7tNf6gvu9IKxcV4LMbIplcFx3n/2K/jAp1PSbL40+qXcJQQrqhxCnOkYGW6uRYTUBH8S0pOSzLJQjXeeoHAcoWFtZaTKxnvkeZIUXDlvm5/SKcCrxjLiBwzn5dDGno21AlhTMA6nHW2yCQLWOZpnoAwEFG7X8mExMIxREMA+R89A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onU7bqmT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=onU7bqmT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDwTX0nzHz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 00:11:59 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-ca88130e09aso3395152a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852712; x=1786457512; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vh4jiNB+QM/k1EF3hB6ldYl4nAMV7WkREZGBEOhBpvE=;
        b=onU7bqmTcbS8QYJVHPrFi0/o2eh7Mvs3hLryxvFfXvpvzdzHoe/qHCftE+CTpBg57C
         QMhq4nqjltr8ubHtEo9ntz7tyx13nZAbEzFw2SB42snqicrd5rdXvsQDS18fFsoFChk4
         MltJVcGWg35EmjW2M5Hk8g/gYrq3ms63yCYyqOn+qw3+Ix7Br+67h9NAoXdQcSDu9eZL
         oOIOFGs2AVVUPHsd/mil0iAEVPtPt91AAyQAqOStRoJyESmocd1hU/ex142M4gzC6M2h
         mUUEUwni4wXymietzmU7sgnnVqAP2Mc78aCCPkOe1wBL+Gu5vU4JzpPa58Ih+ubkBrja
         Vuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852712; x=1786457512;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vh4jiNB+QM/k1EF3hB6ldYl4nAMV7WkREZGBEOhBpvE=;
        b=U8NbW5Gf2VsaMOPekK9eoq4/wAr1Wxcj9vs/znNyzJkj+HVY8wFy7gA+vqUuERybQB
         SLBvFu3pB29bcKbu/fGSn+u5pK1JJmVk3cb5WAtfzvmrkDG1OAuW4jG9yIWdTTGI2SHl
         qUaV5iMxIugI6fWGbdP7CZJa8ir46dgmuOjjf7gkMJiadlkmTOlTf1kBwu2gT78DkCKS
         +8mx5endmtDQpPsYFelHFBNmGivjEnRuFMEauu09t4HbfPFqHCEp3ohGqIuuOzNCv/jQ
         VrJhhNRNkl1cZ24tqHr1qaIANp+kCOEH/DhQyvhXU57MHmmxXivH6zXHAdf7+lyP7G12
         HFOQ==
X-Gm-Message-State: AOJu0YxNXOsjz/oiLgrFg8rAAx53Eh3l3CmMBwNb2admEbXTEAikKFeP
	Nb+SmJ+83ylfHm2vODIK/qysJGsh8UCebZi91d1Ttzu9BRNjIrCTkH02
X-Gm-Gg: AR+sD12lvKRWtbwgMwdvGcHciA0AuQZrrqNsLaXS8VaiJi7yFm9vyicqYnWk4EUhGK7
	x3gRG11pnlK2ZAHDTKHIpAk5Iq+yUywt0yUgyD4HJJCKqiCl4naBOyyDE+DRecLPN3//ww2IFSh
	43emIlNK7JoHBcJnLGkKN0uydqZET9ak6qc7yWOFkP9kbp/TFCAN+OXQSEJ2QeZOZrOBU6Xo9rx
	HIjffgqmyliDZbd4rzDyKQtrc4Y3whq/GMx2cheWJRcgmuC2/jMLczorheh3c4dSdWrfRE9PAzg
	1f60egcUpFgA6Z2Jeh5k/eUZax4q9ViaQsONqFQH+eFULdTINoKLh5nCPbRbFmnKXlqPHHnmJ2f
	FoyxHA9pzD4VEq0kIemV7ZEajysfuKzNiBvXrzhoDsoC6u888ba+8Ka/05BxPdtnSPPqiG7xesK
	Jxe5TdTC0GTiaBSvaEWV1Z1W8q3ZR9mQTpu4qxLTgnpkzLPPQzYdlfawm8Roc=
X-Received: by 2002:a05:6a20:431f:b0:3c3:a1ed:3c36 with SMTP id adf61e73a8af0-3c92a543d11mr13674670637.24.1785852711886;
        Tue, 04 Aug 2026 07:11:51 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673a9e4sm6178315eec.18.2026.08.04.07.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:11:50 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <db0911c1-0be3-4b8e-be0a-ea02a76cf122@linux.ibm.com>
Date: Tue, 04 Aug 2026 19:36:47 +0530
Message-ID: <33wum13c.ritesh.list@gmail.com>
References: <20260727221437.89644-1-gbatra@linux.ibm.com> <a4r9mf8r.ritesh.list@gmail.com> <db0911c1-0be3-4b8e-be0a-ea02a76cf122@linux.ibm.com>
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

Gaurav Batra <gbatra@linux.ibm.com> writes:

> Hello Ritesh,
>
<...>
> As you correctly pointed out in the enable_ddw() code, this could lead 
> to EEH if
> pmemory is assigned to the same power-of-2 chunk as (RAM + 16GB pages).
>
> It would be better to set device bus_dma_limit to pseries_ddw_max_ram 
> and *not*
>
> max_ram_pages, which in this case is the size of the DDW.
>
> I will fix this in my next version of the patch.

Sure, thanks for veryfing that claim.

> Please let me know if you have any other concerns. I will incorporate all those changes in the next version of the patch.
>

Nothing else. Otherwise, it looks good.

> Thanks a lot for spending time and checking this code in deep.

No issues. Thanks for fixing it!

-ritesh


