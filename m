Return-Path: <drzeus-mmc@drzeus.cx>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0AC8DDDD8
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 08:01:01 +1100 (EST)
Date: Sat, 8 Nov 2008 21:55:37 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] mmc: Add mmc_vddrange_to_ocrmask() helper function
Message-ID: <20081108215537.12cdf5f6@mjolnir.drzeus.cx>
In-Reply-To: <20081030195632.GB13640@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
	<20081030195632.GB13640@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Oct 2008 22:56:32 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> +/**
> + * mmc_vddrange_to_ocrmask - Convert a voltage range to the OCR mask
> + * @vdd_min:	minimum voltage value (mV)
> + * @vdd_max:	maximum voltage value (mV)
> + * @mask:	pointer to the mask
> + *

Why the pointer? Why not let the caller handle the aggregation? That
would be a lot safer.

> +	/* fill the mask, from max bit to min bit */
> +	while (vdd_max >= vdd_min)
> +		*mask |= 1 << vdd_max--;
> +	return 0;

Many cards get a bit uppity with a single bit set. If possible, try to
make this function set two bits when the voltage is right on the
boundary (e.g. 3.3V).

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
