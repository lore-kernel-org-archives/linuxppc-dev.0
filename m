Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 169392C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 12:41:50 +1000 (EST)
Message-ID: <504FF66B.8020009@wwwdotorg.org>
Date: Tue, 11 Sep 2012 20:41:47 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [alsa-devel] [PATCH 4/5] arch/powerpc/boot/dts pcm030 add
 mpc5200-soc-audio node
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
In-Reply-To: <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/11/2012 08:14 PM, Eric Millbrandt wrote:
> Describe the audio codec on the pcm030 baseboard.

> +++ b/arch/powerpc/boot/dts/pcm030.dts

> +	sound {
> +		compatible = "fsl,mpc5200b-soc-audio","fsl,mpc5200-soc-audio";
> +		card-name = "pcm030";
> +		audio-platform = <&audio_platform>;
> +		number-of-dais = <2>;
> +
> +		analog@0 {

Purely from a DT perspective (i.e. I didn't look at the code that parses
this), you don't need to include the "@0" and "@1" in the node names,
because the two node names "analog" and "digital" are already unique.

However, in general I can see that you might want multiple analog DAIs.
There are a couple choices for differentiating the node names in that case:

1) If you want to use the "@0" unit address syntax in the node names to
differentiate them, each child node needs a reg property containing the
same value, and the parent node needs properties #address-cells=<1>,
#size-cells=<0>;

2) Or, since this is within an individual device binding rather than
something within a standardized bus, you can simply choose to make the
node names unique in some other way, such as "analog0", "analog1", i.e.
without the "@"; I believe the "@" syntax would be explicitly reserved
for representing a unit address as in (1).

Of course, I could be wrong about this assertion that the "@n" is
reserved for the unit address even with the privacy of an individual
binding; it'd be best to validate it by posting to the
devicetree-discuss mailing list.

> +			stream-name = "AC97 Analog";
> +			codec-name = "wm9712-codec.0";
> +			codec-dai-name = "wm9712-hifi";
> +			cpu-dai-name = "mpc5200-psc-ac97.0";
> +		};
> +
> +		digital@1 {
> +			stream-name = "AC97 IEC958";
> +			codec-name = "wm9712-codec.0";
> +			codec-dai-name = "wm9712-aux";
> +			cpu-dai-name = "mpc5200-psc-ac97.0";
> +		};
> +	};
>  };
