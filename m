Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 103941A0103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 18:38:14 +1000 (AEST)
In-Reply-To: <1438273132-20926-23-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [22/27] macintosh: therm_windtunnel: Export OF module alias
 information
Message-Id: <20150820083813.D508D1402A6@ozlabs.org>
Date: Thu, 20 Aug 2015 18:38:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-30-07 at 16:18:47 UTC, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So technically there's no need for a driver to export
> the OF table since currently it's not used.
> 
> In fact, the I2C device ID table is mandatory for I2C drivers since
> a i2c_device_id is passed to the driver's probe function even if the
> I2C core used the OF table to match the driver.
> 
> And since the I2C core uses different tables, OF-only drivers needs to
> have duplicated data that has to be kept in sync and also the dev node
> compatible manufacturer prefix is stripped when reporting the MODALIAS.
> 
> To avoid the above, the I2C core behavior may be changed in the future
> to not require an I2C device table for OF-only drivers and report the
> OF module alias. So, it's better to also export the OF table to prevent
> breaking module autoloading if that happens.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a1a42b7920ba57f287d7

cheers
