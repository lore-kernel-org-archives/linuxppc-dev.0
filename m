Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0A6CBB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 06:55:16 +1000 (EST)
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 95B17DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 06:55:14 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MbKqc-0007Ej-E5
	for linuxppc-dev@ozlabs.org; Wed, 12 Aug 2009 20:55:02 +0000
Received: from 24.114.226.27 ([24.114.226.27])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 20:55:02 +0000
Received: from michaelbarkowski by 24.114.226.27 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 20:55:02 +0000
To: linuxppc-dev@ozlabs.org
From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
Date: Wed, 12 Aug 2009 16:45:55 -0400
Message-ID: <4A832A03.6020507@ruggedcom.com>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20090731004100.GB8371@oksana.dev.rtsoft.ru>
Sender: news <news@ger.gmane.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anton,

Is m25p_probe now valid with dev.platform_data == NULL, for of platforms?

Then shouldn't you have the following change as well, near the end of
the function?

-  	} else if (data->nr_parts)
+  	} else if (data && data->nr_parts)
		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
				data->nr_parts, data->name);

Or am I misunderstanding something?

-- 
Michael Barkowski
RuggedCom
