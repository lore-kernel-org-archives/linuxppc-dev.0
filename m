Return-Path: <wsa+renesas@sang-engineering.com>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zPcjk3XkszF0ZW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 01:42:50 +1100 (AEDT)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: devicetree@vger.kernel.org
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
Date: Sun, 21 Jan 2018 15:31:16 +0100
Message-Id: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I got a bug report for a DT node refcounting problem in the I2C subsystem. This
patch was a huge help in validating the bug report and the proposed solution.
So, I thought I bring it to attention again. Thanks Tyrel, for the initial
work!

Note that I did not test the dynamic updates, only of_node_{get|put} so far. I
read that Tyrel checked dynamic updates extensively with this patch. And since
DT overlays are also used within our Renesas dev team, this will help there, as
well.

Tested on a Renesas Salvator-XS board (R-Car H3).

Changes since RFC v1:
	* rebased to v4.15-rc8
	* fixed commit abbrev and one of the sysfs paths in commit desc
	* removed trailing space and fixed pointer declaration in code

I consider all the remaining checkpatch issues irrelevant for this patch.

So what about applying it?

Kind regards,

   Wolfram


Tyrel Datwyler (1):
  of: introduce event tracepoints for dynamic device_node lifecyle

 drivers/of/dynamic.c      | 32 ++++++----------
 include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 20 deletions(-)
 create mode 100644 include/trace/events/of.h

-- 
2.11.0
