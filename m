Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A2C31A0339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 20:06:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH 5/7] mmc: sdhci: host: add new f_sdh30
Date: Fri, 20 Jun 2014 12:00:40 +0200
Message-ID: <5136245.WRbqGRMMHn@wuerfel>
In-Reply-To: <1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: andy.green@linaro.org, patches@linaro.org, anton@enomsg.org,
 linux-mmc@vger.kernel.org, chris@printf.net, Vincent.Yang@tw.fujitsu.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 20 June 2014 17:35:26 Vincent Yang wrote:
> +Required properties:
> +- compatible: "fujitsu,f_sdh30"
> +
> +Optional properties:
> +- gpios: Specify gpios for controlling signal level
> +- clocks: Specify clocks used by SDHCI controller
> +- clock-names: Specify the clock-names to be used

If you want to use "clock-names", you have to specify the exact names
of the clock input signals used by your device, and the order in which
they are listed.

For both the clocks and the gpios, you have to specify how many signals
there are, and ideally describe what they are used for. In case of a
gpio controlling the signal level, it may be better to model this
as a gpio-regulator device, depending on how exactly it is used.

When posting a DT binding document, please always add
devicetree@vger.kernel.org to Cc.

	Arnd
