Return-Path: <Christian.Engelmayer@frequentis.com>
Date: Fri, 13 Jul 2012 10:04:40 +0200
From: Christian Engelmayer <christian.engelmayer@frequentis.com>
To: <grant.likely@secretlab.ca>, <linus.walleij@stericsson.com>,
 <devicetree-discuss@lists.ozlabs.org>
Subject: [RFC] Configure GPIO settings via the device tree
Message-ID: <20120713100440.7a80e05f@frequentis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, christian.engelmayer@frequentis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I am looking for a way to configure GPIO initial settings and exports to the
userspace via Sysfs in a generic way via a device tree.

The purpose would be to have the same features as when initializing and
exporting pins via platform code, eg.

	static struct gpio leds_gpios[] = {
		{ 32, GPIOF_OUT_INIT_HIGH, "Power LED" }, /* default to ON */
		{ 33, GPIOF_OUT_INIT_LOW,  "Green LED" }, /* default to OFF */
		{ 34, GPIOF_OUT_INIT_LOW,  "Red LED"   }, /* default to OFF */
		{ 35, GPIOF_OUT_INIT_LOW,  "Blue LED"  }, /* default to OFF */
		{ ... },
	};

,however, with no need for the kernel to know anything more about those pins
and their later handling by simple userpsace drivers than the setup information
provided in the device tree.

This should also attack the problem of unstable GPIO numbers in the case of
daughtercards on different base boards and would help provide a defined API
to the userspace based on pin labels with the board specifics hidden in one
place in the device tree.

Is there already a way for realizing such a scenario ?

Regards,
Christian
