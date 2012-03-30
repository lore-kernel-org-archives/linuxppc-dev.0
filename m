Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 11DA8B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2012 07:05:15 +1100 (EST)
Date: Fri, 30 Mar 2012 22:03:58 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 00/15] mark const init data with __initconst instead of
 __initdata
Message-ID: <20120330200358.GV15647@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120329211131.GA31250@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Christoph Lameter <cl@linux-foundation.org>,
 linux-mips@linux-mips.org, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Matthew Garrett <mjg59@srcf.ucam.org>,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 Randy Dunlap <rdunlap@xenotime.net>, linux-mtd@lists.infradead.org,
 Sekhar Nori <nsekhar@ti.com>, Daniel Walker <dwalker@fifo99.com>,
 lm-sensors@lm-sensors.org, Klaus Kudielka <klaus.kudielka@ieee.org>,
 Guenter Roeck <guenter.roeck@ericsson.com>, Kevin Hilman <khilman@ti.com>,
 linux-ia64@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>,
 Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Lennert Buytenhek <kernel@wantstofly.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, David Brown <davidb@codeaurora.org>,
 Anatolij Gustschin <agust@denx.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, Joerg Reuter <jreuter@yaina.de>,
 linux-media@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>, linux-arm-msm@vger.kernel.org,
 Andreas Koensgen <ajk@comnets.uni-bremen.de>,
 Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, Tejun Heo <tj@kernel.org>,
 linux-samsung-soc@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua.song@csr.com>, linux-hams@vger.kernel.org,
 linux-omap@vger.kernel.org, Andrew Victor <linux@maxim.org.za>,
 linux-arm-kernel@lists.infradead.org, David Howells <dhowells@redhat.com>,
 davinci-linux-open-source@linux.davincidsp.com,
 Jean-Paul Roubelat <jpr@f6fbb.org>, Eric Miao <eric.y.miao@gmail.com>,
 Linus Walleij <linus.walleij@stericsson.com>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Nicolas Pitre <nico@fluxnic.net>,
 Ralf Baechle <ralf@linux-mips.org>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Bryan Huntsman <bryanh@codeaurora.org>, Sascha Hauer <kernel@pengutronix.de>,
 netdev@vger.kernel.org, Jean Delvare <khali@linux-fr.org>,
 Paul Mackerras <paulus@samba.org>, Shawn Guo <shawn.guo@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Thu, Mar 29, 2012 at 11:11:31PM +0200, Uwe Kleine-König wrote:
> this series fixes a common error to use __initdata to mark const
> variables. Most of the time this works well enough to go unnoticed
> (though I wonder why the linker doesn't warn about that).
> Just try adding something like
> 
> 	int something __initdata;
> 
> to one of the patched files and compile to see the error.
> 
> While touching these annotations I also corrected the position where it
> was wrong to go between the variable name and the =.
> 
> Note this series is not compile tested.
I now dropped the wrong annotations. So two patches became obsolete
(mtd and percpu). Note that I also dropped fixing the position of
__initdata if changing it to __initconst was wrong. (I think if
__initdata is placed before the variable name it doesn't have any
effect.)

I didn't promote the Acks I got because all acked changes changed in v2.

For the details changed in each patch see the changelogs in the
respective patch mails that I follow up to this mail.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
