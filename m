Return-Path: <fthain@telegraphics.com.au>
Received: from vps4.telegraphics.com.au (vm4.telegraphics.com.au
 [98.124.60.149]) by ozlabs.org (Postfix) with ESMTP id 6FC611007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 12:24:47 +1100 (EST)
Date: Tue, 13 Dec 2011 12:24:40 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
In-Reply-To: <1323720383.19891.21.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1112131224330.2562@nippy.intranet>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop>
 <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
 <1323647315.19891.10.camel@pasglop>
 <alpine.LNX.2.00.1112130020000.2550@nippy.intranet>
 <1323720383.19891.21.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 13 Dec 2011, Benjamin Herrenschmidt wrote:

> On Tue, 2011-12-13 at 00:34 +1100, Finn Thain wrote:
> > On Mon, 12 Dec 2011, Benjamin Herrenschmidt wrote:
> > 
> > > Any chance you can test this patch ? I would not be surprised if it 
> > > broke m68k since I had to do some of the changes in there "blind", 
> > > so let me know... with this, I can again suspend/resume properly on 
> > > a Pismo while using the internal modem among other things.
> > 
> > The patch works on a PowerBook 520 given a few changes (below). This 
> > PowerBook only has one serial port that I can test (the internal modem 
> > is not supported on 68k Macs).
> 
> Interesting. The modem is a soft-modem "geoport" or a hw serial modem ? 

It's the latter.

> In the later case it's probably just a matter of finding the right GPIO 
> bit in Apple ASIC to turn the power on :-)

Surely feasible, but not high on the list of missing hardware support.

> 
> >  Can you test a machine with two ports? The rest of my Mac hardware is 
> > in storage since I moved house last week.
> 
> I tried on 2 port powermacs, but I only have one adapter, so I've 
> basically been running with one serial port open and shooting irda frame 
> on the other (with nothing to check wether I got the frames on the other 
> hand), oh well ...
> 
> I'll apply your patch and commit via my tree.

I forgot to include this fix for your logging change.

Finn

Index: linux-git/drivers/tty/serial/pmac_zilog.c
===================================================================
--- linux-git.orig/drivers/tty/serial/pmac_zilog.c	2011-12-13 12:12:05.000000000 +1100
+++ linux-git/drivers/tty/serial/pmac_zilog.c	2011-12-13 12:13:29.000000000 +1100
@@ -99,6 +99,10 @@ MODULE_LICENSE("GPL");
 #define PMACZILOG_NAME		"ttyPZ"
 #endif
 
+#define pmz_debug(fmt, arg...)	pr_debug(PMACZILOG_NAME "%d: " fmt, uap->port.line, ## arg)
+#define pmz_error(fmt, arg...)	pr_err(PMACZILOG_NAME "%d: " fmt, uap->port.line, ## arg)
+#define pmz_info(fmt, arg...)	pr_info(PMACZILOG_NAME "%d: " fmt, uap->port.line, ## arg)
+
 
 /*
  * For the sake of early serial console, we can do a pre-probe
Index: linux-git/drivers/tty/serial/pmac_zilog.h
===================================================================
--- linux-git.orig/drivers/tty/serial/pmac_zilog.h	2011-12-13 12:12:05.000000000 +1100
+++ linux-git/drivers/tty/serial/pmac_zilog.h	2011-12-13 12:12:28.000000000 +1100
@@ -1,10 +1,6 @@
 #ifndef __PMAC_ZILOG_H__
 #define __PMAC_ZILOG_H__
 
-#define pmz_debug(fmt, arg...)	pr_debug("ttyPZ%d: " fmt, uap->port.line, ## arg)
-#define pmz_error(fmt, arg...)	pr_err("ttyPZ%d: " fmt, uap->port.line, ## arg)
-#define pmz_info(fmt, arg...)	pr_info("ttyPZ%d: " fmt, uap->port.line, ## arg)
-
 /*
  * At most 2 ESCCs with 2 ports each
  */
