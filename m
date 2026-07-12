Return-Path: <linuxppc-dev+bounces-24077-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724B8C43458
	for <linuxppc-dev@archiver.kernel.org>; Sun, 12 Jul 2026 22:21:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz0RB4500z2xl6;
	Mon, 13 Jul 2026 08:21:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783894902;
	cv=none; b=hqdrzaywfeVSoyXi7Oqzs3aHcP9DbtmyB+qGZ8swQIaT7ZB5GsOXriaFfJmT4QcnyeI5x1BZOKlTnnoegJFGG1nDkRTCCfmCLlcwB4HW6iIBYjKRDl5xYDLLI+soPztEu3A5yDR6nEjCzMx31UA25vUuHHiaYjYK4EUm3MEO+aH6eDCf/ULcyKETstK0kHJAFkPB1JxP4Xad8Y40rHrzYNmmNJVt2aJtPgw04NZRT2WRal3vasBuItZtzOj3ZuUAxhjpl7lw1cJG64XsdXXSu+ktU5I/idSPFuKmHPXFPB/ofqONaxktUj+jsUXoBWJo3+82wSe4ddFoSi/NtGOePw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783894902; c=relaxed/relaxed;
	bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P320Xck3YxPVKIGxosbBttzKYPykS+amxRIZqhomCZm8HJRnz+Zc0zhrJEbwvsdhtZ48xMYuq92D4neSE7Rt601t5FKGUSeTBEoN60VE3CMuEdNMUd26iNeYzc5HYw1LKxMRYw8HRb5JMH3ho7Q/yncsUm9udqf/20IJxzqZ7LlZGqXKQ0mmXjZQWF5wDzeM1+NWNEZehcAtZxr50b85rpIkfv2aLIAUf3dOHgpdVm15P4oK6QEXrA9VABchhCBNSMgzqw8vkYcJkpq1U5haYZxP5/qG/fDBiHwzTL/QSL6qdP2ZVMKCFVS29p1We370zF6TGNFnOxepaiOISksYVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ImhMrrnm; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ImhMrrnm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz0R61bQxz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 08:21:35 +1000 (AEST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-493f2e39e81so8768565e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894887; x=1784499687; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=ImhMrrnmLkcjygYgXf509Xkb6FhQ68WuuOA80ZTwXqRxNckvG2ZVlzObsW39CWVarN
         9Ic8ThtrJuCtD8ZwI6O7vEA0koLDN3yhQrW2U6o8CPGB2E6eiy+ZLJGw0/+psv5STQ5C
         JpCTMqSUaQ0t+G5Mr8aZZsGt/zjQl7nxWX7SAById68jsPYJJvUIXnk61Wav1USe3g4l
         rnt9MDHwoPfHya2gq7qzg2Zn2fve8iCfNYMnGwoQktdYdXfoY6zyASAoSj6KIy5T0X3J
         TZX2LPvUU9e7gxe35LyhHtQObUuyYMqzgG2M5TrLwxY8qZHZzVALEZWWRXQ6WOsN7jlF
         l5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894887; x=1784499687;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXFkHL5kLy0YmcSeIBWJ/pJv7FWST/0rD1sn/vpnnlo=;
        b=FxvabZLYpkQobkH1dX68dHNaziC0XBjvKYXl76Xz4hpxpQp3oqd1rmiFX7nvLQiThk
         ZgZJFyN0SkbtPxGwT3OYIgA8tajgroHoVPa9OU9PZmX7o5pYZx+tyRx+ye/ganizZ+MP
         +XajccPV3VLlSkRTWqYaZfLpiiNI8wmLf+OYNHeiFbn2ZRTqnOEbPV8ynbmBnsDDYzv9
         TCQ15xiXP4KdYTyc6NTbpQTTiRQQ1u+mmDYaTZP7LZzciHimk4HB2UrJQJbP5AVOzTbR
         JhJv7dHN0SieMZIGpqOtMlnmX9VPsgiBqK7ASDp0YExiIkDooSRw3eCJhyU1v29p4wqI
         NbtA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7AkZ8ZCQdAwhcMl33oYYCEkbjM0PMSM1AiB5K+JlGLtFvm8gUIgBvjf4CyFKjSun6+qGQX65spJekUDs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyTJl2FDNH3BBDHwv76MYMp8ES/wIXD3+n2IEf5W38lAEfQejlc
	Wv1I8kd4DIp+8D9CgIVklJ3/8H3COg4r9V9HKqEbOG9/K6c3bnS5+7Ia+Fha+nhslxs=
X-Gm-Gg: AfdE7clft/GbgZTdlP41Stxdh60vuAp14tvbg0WN4lQqiJ8O21dqEEADEtFSDi4l2Ae
	hYLKd3+jf8v6Uh+k1tFuNUck9/ph4w7BnTE/0xV6IUnN7BQHq6xl+ylEzMt7EJ4ltjJyplsw/mO
	JFi7VjlcLD2Wy+TBaV7+eE3xMfFrjeEpZ7e8mgJQLRfvY86NlDDEZsxYeeENYRVYlWKlUwWsHsk
	waA1Wsao+V2zKlVi5g9qdjP1qcu4dPcCYlO0AJmc+jyPhqw5S+Hf7L0BmowA5GKvQHgmtHQY+E7
	hNDz2F3sWGUvsc5z9SAO2Yh7PfzT7wocIxLbDVmN5zR5G9mcWZ60+lzsm04UyIl6OVq6pxx4pzJ
	I1Iv3Zep6zmNnVQt/OORM6RGL8oLLeTC5jkWhhqdADpQSxIPS8Xu/IgJKYZnOwhSCjvfFx6gLme
	Uvq9Ph9lVx+LjZQmgwIw==
X-Received: by 2002:a05:600c:3543:b0:493:f6c1:2f09 with SMTP id 5b1f17b1804b1-493f87dc753mr64927015e9.6.1783894886966;
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493eb742a49sm296924145e9.12.2026.07.12.15.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:21:26 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:21:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, 
	Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
Message-ID: <alQTUuwze5ZjGabk@monoceros>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o63zw6szpf3k5nqs"
Content-Disposition: inline
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-10-8b3a85216cef@arm.com>


--o63zw6szpf3k5nqs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v7 10/10] RAS: add firmware-first CPER provider
MIME-Version: 1.0

Hello Ahmed,

On Wed, Jul 08, 2026 at 02:59:09PM +0100, Ahmed Tiba wrote:
> +#include <linux/mod_devicetable.h>

Please don't add new users for this header file. Only use those
<linux/device-id/*.h> that you actually need (if any).

Thanks
Uwe

--o63zw6szpf3k5nqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUE2IACgkQj4D7WH0S
/k5Aagf+IcCM3MbiQFXq44EFdGthF9zwEU47GU8P9/gSXah2GXOz59WKWZqRlJgo
j4mZ9uRbJqwLqZ7OtPIZj1IyEY9Bmeix2uL7sJuVUBcZ2qRaX3OxW/xi8zEaH0fi
1DgPWPB5MHOhvc5d5JJAeoqaV3TCXNxNEF8uvyiaGJWFIr7oGvWZVJCPTmjbqVt8
vzyFYzCac+qNGAzM6F6FhjNsegEgpsSAP2XIIruYv2+iPpHWzMbx+LpknKOq8Rws
N/Cmj3SBH5ULfApKqkL4QqeHk6RnfAclAjr/EdYS7nE6L5Bdot9DOOil56IDxCps
pX4u0VGI9OqUoeIeIDXaS9GJsG261A==
=Eag/
-----END PGP SIGNATURE-----

--o63zw6szpf3k5nqs--

