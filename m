Return-Path: <highguy@gmail.com>
Received: from mail-we0-x22a.google.com (mail-we0-x22a.google.com
 [IPv6:2a00:1450:400c:c03::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3A4A1A0020
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Aug 2014 06:28:26 +1000 (EST)
Received: by mail-we0-f170.google.com with SMTP id p10so1308863wes.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 13:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53FF5097.7090000@c-s.fr>
References: <53F31707.4040300@c-s.fr>
	<53FF5097.7090000@c-s.fr>
Date: Thu, 28 Aug 2014 22:28:19 +0200
Message-ID: <CAOY=C6HxdLOPb6y=VCB_0VrSt_Vyc95nuMN_3ZDFSqoV=mAfEw@mail.gmail.com>
Subject: Re: Linux 3.16: all my drivers on SPI bus report WARNING: at
 drivers/base/dd.c:286
From: Stijn Devriendt <highguy@gmail.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=UTF-8
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-spi@vger.kernel.org,
 Axel Lin <axel.lin@ingics.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 28, 2014 at 5:53 PM, leroy christophe
<christophe.leroy@c-s.fr> wrote:
>
> I've been able to identify the origin of the issue. It happens since the below commit.
> Do you know what should be done to fix that ?
>
> Christophe
>
>

Actually, more things are wrong with what the driver is doing.
If inside spi_add_device() the call to device_add() fails, then that
code bails out without any call to spi_cleanup() and the same
memory will leak (Is this intended?).

Basically, fsl_spi_setup allocates memory using devm_kzalloc, while
device_add expects that any memory allocated via this way is only
done in the device's probe function.

The simple fix would be to do a normal allocation (revert the patch) and
add a free to the cleanup() function. Unfortunately that doesn't fix the
memleak I mentioned above.

So, some outside-the-box thinking brings me to conclude that another way
to fix this problem is to allocate the devm_kzalloc not on the device's
resource
list but on the controller's resources (it's controller state after all...).

Regards,
Stijn
