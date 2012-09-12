Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F0A52C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:17:28 +1000 (EST)
Date: Wed, 12 Sep 2012 11:17:20 +0800
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 4/5] arch/powerpc/boot/dts pcm030 add mpc5200-soc-audio
 node
Message-ID: <20120912031719.GH9162@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 11, 2012 at 10:14:48PM -0400, Eric Millbrandt wrote:

> +		analog@0 {
> +			stream-name = "AC97 Analog";
> +			codec-name = "wm9712-codec.0";

This name is fairly clearly an internal implementation detail of how
Linux does audio drivers, we shouldn't be using it in device tree
bindings.  We should instead be doing something like referencing a
device tree node for the CODEC.  Look at how drivers like the nVidia
Tegra ones handle this, though for AC'97 we should really be able to
figure out a standard hookup like this automatically at runtime, it's
all enumerable.
