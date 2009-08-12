Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 91F59B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 06:58:05 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 17B6ADDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 06:58:03 +1000 (EST)
Date: Thu, 13 Aug 2009 00:58:00 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: [PATCH 2/6] mtd: m25p80: Convert to device table matching
Message-ID: <20090812205800.GA27074@oksana.dev.rtsoft.ru>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru>
	<20090731004100.GB8371@oksana.dev.rtsoft.ru>
	<4A832A03.6020507@ruggedcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A832A03.6020507@ruggedcom.com>
Cc: Ben Dooks <ben@fluff.org>, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 04:45:55PM -0400, Michael Barkowski wrote:
> Hello Anton,
> 
> Is m25p_probe now valid with dev.platform_data == NULL, for of platforms?
> 
> Then shouldn't you have the following change as well, near the end of
> the function?
> 
> -  	} else if (data->nr_parts)
> +  	} else if (data && data->nr_parts)
> 		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
> 				data->nr_parts, data->name);
> 
> Or am I misunderstanding something?

Yeah, you missed this patch:
http://patchwork.kernel.org/patch/38179/


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
