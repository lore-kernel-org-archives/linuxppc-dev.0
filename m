Return-Path: <linuxppc-dev+bounces-12634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC06CAC5B8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Oct 2025 09:11:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccmHX1jNwz3cgQ;
	Thu,  2 Oct 2025 19:11:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759396264;
	cv=none; b=hY3YcgPVjUNeyWLCbnFjaNPilIWjza8CJE89NiaPqXd3xgDMqkrWv24mOH4Ke3wdIDFRLWbzZvYjPTWeJTCb2h/dp5oUSsgLd8ndzo/N3QYmVO2bvQoMOZGQA+LDsXiKl7F2Lh7SkrAjoN2wWfByBGxZFNRbuS5RPBtOGeHm+lFNJGcvpqerTusiYjwB1ypVs3UJ+dey+5amE0LAD6xqXATUT1+1rNTCzEj2BOTeF3d3yhBAGzd4uXL61xHfC6TD4bHqNG75Ltv1uD9HjIOJFmZhvAly9OyrSy5LfwDsEJscMWOLhq70cbnhgm3betr106YJPqhy4oOsqXop2s1AAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759396264; c=relaxed/relaxed;
	bh=ZRDmlXYbuy08sNt5xF8Zckv3BDEt/TW4zDdfvpxaR3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOeVo13aP6tvlIbIV5WY62TD3iu8f3cdQCPdXkn5c5UXjrIOg8BbqaCRpna2yCdd1fkGfvNimH5MnKUAl0uGGmYTfXtVajFdP4zRU/W+aWBXAbBXu5/HOE4clqGer+9n1JrKNKWsBC1dLJZ1EDA7CCC/47F6WJblrI2hdzRPhppQyNwETzkawMXYla5aO63QIUwJdgT19X3O1jN3benGu9rV7HtRrNVzyhiTVrvpz/CrzCsOWch0TydneyodUvExP0VHREc6ioPoXEv+UwIlbNKHQ4lJ1FxoPv6nTzMlVTA+KRTsPpOOs8cGz/ybDeOtq4iZeCx7hSfmlkpXr4/XWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass (client-ip=209.85.208.52; helo=mail-ed1-f52.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.52; helo=mail-ed1-f52.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ccmHW18S9z3cg1
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2025 19:11:03 +1000 (AEST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so1226303a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Oct 2025 02:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396260; x=1760001060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRDmlXYbuy08sNt5xF8Zckv3BDEt/TW4zDdfvpxaR3k=;
        b=ucbfWwWsFDlRqiPms3X9s+FeyGLe2TWXJ4iJGlubPn/O8d9ywXi4h6kGzGGk5i/Uhb
         YjkY9XsLJJOpZz1SreHbQCOvkzAKAuKB51FgMO3KzaJBh0IQgeo0ZNvePfF0AggYJ8a6
         foIvcaw70tTfZAyD3JH95VDFzwr4zCAZUnzh7mRZfzg3+jjrKZxRI8Gm4mwBkmJ0zyZ4
         9HmWqbplZ30dgi0SDnXa18yUuLpl/WKvj9QoOzVk4zoTnMnmPvJ7ZRxjEREMn212kLml
         zHuNl9601XvQ6gBRn4TU2Hc+nkUIEB1KcrLweSiSHSuVyCtHqG5fgjvXXpC3m82I8ILB
         5vUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+06Q6TcW+K9gqeiAyZPbNe/cTg8Lzk2fEo4sR+8X43tk2rE0asB9sp05RKLI3tFx1NmBUCX9eSpPa8kk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7NAlRgz+dUx/HfUsenrHijPhUY3Xm4bdrYQ0vaKebz7u0caFU
	vyASr/TbBQrwUzatqJ8XocN7uv+BTAmcu4keBwwWDhjnulgtGWZpSx/D
X-Gm-Gg: ASbGncu0XsLuj68kzfNPXUrOQ2Z2gy0UP5jSVhWR/WtIutybtj40hqzOl2Alo5gUQP5
	4TQz+10+VrAOCPL61stfCqCFupax1hVC5TXQWRBcAaFnZ0ijxQhm6XZ6J4g/4lyV73RQYyZA/xH
	v2Y3uOc7RDqEzdGKw92eiQtI1m26S73qAV6+v0sSeC+CVdN3sxeAJo9FmclB9NmNqIFH6Cws0bR
	J7rdZ1Kfij9IC94QDLZWyKcsXQ+ixAGmzU8NKhN+FKTnFEkfFH56WzENVmPIyunpuOeJvXMRxhN
	BNG0Cmc37dHzOcGRaO9L7A21Z8tqsDgTxUanrlJzFI1U1XWC00dwUd85BcFHEU9JQhjyM0heYdh
	b5Fjl1q/UxJuDODbhIDvsQczmusWDm7FxJEJeQQ==
X-Google-Smtp-Source: AGHT+IGI0lLEvsbF1QPCvI8L4Q/FaURN2Mex33lSpcN9SL3uUzSJV82rsbQoChB7SREpyehAucnnhQ==
X-Received: by 2002:a05:6402:d08:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63678c9f53cmr6776854a12.37.1759396259611;
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637880ffa4dsm1428844a12.29.2025.10.02.02.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:10:59 -0700 (PDT)
Date: Thu, 2 Oct 2025 02:10:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI/AER: Check for NULL aer_info before
 ratelimiting in pci_print_aer()
Message-ID: <z5thnuj2nwzuk7wp7kentekm7zx6v6fh5f6zknerdbld665guo@6uxxl7emi3be>
References: <20250929-aer_crash_2-v1-1-68ec4f81c356@debian.org>
 <20251001213657.GA241794@bhelgaas>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001213657.GA241794@bhelgaas>

On Wed, Oct 01, 2025 at 04:36:57PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2025 at 02:15:47AM -0700, Breno Leitao wrote:
> > Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
> > when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
> > calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
> > does not rate limit, given this is fatal.
> > 
> > This prevents a kernel crash triggered by dereferencing a NULL pointer
> > in aer_ratelimit(), ensuring safer handling of PCI devices that lack
> > AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
> > which already performs this NULL check.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: a57f2bfb4a5863 ("PCI/AER: Ratelimit correctable and non-fatal error logging")
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Thanks, Breno, I applied this to pci/aer for v6.18.  I added a little
> more detail to the commit log because the path where we hit this is a
> bit obscure.  Please take a look and see if it makes sense:

Thanks! That’s exactly what I would have written if I actually knew what
I was doing. :-)

