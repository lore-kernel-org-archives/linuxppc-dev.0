Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 020702C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 00:46:49 +1100 (EST)
Date: Tue, 20 Nov 2012 14:46:21 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
Message-ID: <20121120144621.5d2c213a@endymion.delvare>
In-Reply-To: <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-65-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Wolfram Sang <w.sang@pengutronix.de>,
 "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-omap@vger.kernel.org,
 linux-i2c@vger.kernel.org, Ben
 Dooks  <ben-linux@fluff.org>, Barry Song <baohua.song@csr.com>,
 Olof Johansson <olof@lixom.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

As mentioned on the lm-sensors list for hwmon patches already, I think
it would be much clearer to not split __devexit, __devexit_p, __devinit
etc. removal into separate patches. One patch per subsystem would be
easier to review and apply. If patches grow too large then you'd rather
split in a different direction, for example drivers/i2c/muxes vs.
drivers/i2c/busses or even grouped by related bus drivers (see entries
"I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
MAINTAINERS for examples of meaningful groups.)

-- 
Jean Delvare
