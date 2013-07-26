Return-Path: <anton@scarybugs.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C47D2C00EF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 05:23:45 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id kx1so3320475pab.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:23:43 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Fri, 26 Jul 2013 12:18:59 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH 2/2 V2] mmc: esdhc: get voltage from dts file
Message-ID: <20130726191858.GB14216@lizard>
References: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1374712691-12807-1-git-send-email-Haijun.Zhang@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org,
 linux-mmc@vger.kernel.org, AFLEMING@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 08:38:11AM +0800, Haijun Zhang wrote:
> Add voltage-range support in esdhc of T4, So we can choose
> to read voltages from dts file as one optional.
> If we can get a valid voltage-range from device node, we use
> this voltage as the final voltage support. Else we still read
> from capacity or from other provider.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>

Development process nitpick...

The code originated from me, but I did not sign off this patch...

Per Documentation/SubmittingPatches:

  The Signed-off-by: tag indicates that the signer was involved in the
  development of the patch, or that he/she was in the patch's delivery path.

The order of the sign-off lines also has a meaning. Putting my sign off
below yours means that I was not only involved in the development of the
patch but also somehow approved the patch (but I did not :).

[..]
> +void sdhci_get_voltage(struct platform_device *pdev)

You still duplicate the code... Per my previous email, this should
probably go into mmc/core (with the function renamed to something more
generic, of course.)

Thanks,

Anton
