Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 8C520DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 17:37:59 +1000 (EST)
Date: Wed, 20 Jun 2007 09:37:51 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH/RFC] Modify sched_clock() to make CONFIG_PRINTK_TIME more
	sane.
In-Reply-To: <20070620020211.GO9768@bakeyournoodle.com>
Message-ID: <Pine.LNX.4.62.0706200936300.27011@pademelon.sonytel.be>
References: <20070619063557.GK9768@bakeyournoodle.com>
	<20070619145356.GA20382@lixom.net>
	<20070620020211.GO9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1526020133-1182325060=:27011"
Cc: Olof Johansson <olof@lixom.net>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1526020133-1182325060=:27011
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.62.0706200937451.27011@pademelon.sonytel.be>

On Wed, 20 Jun 2007, Tony Breeds wrote:
> On Tue, Jun 19, 2007 at 09:53:56AM -0500, Olof Johansson wrote:
> > It only seems to be used in this file, so it can be static, right?
> 
> True, I was following suit with tb_to_ns_scale, tb_to_ns_shift which
> could also be static.
> 
> Here's an updated patch that makes them all static and updates the
> commit message as well.
> 
> From: Tony Breeds <tony@bakeyournoodle.com>
> 
> Modify sched_clock() to make CONFIG_PRINTK_TIME more sane.
> 
> When booting a current kernel with CONFIG_PRINTK_TIME enabled you'll
> see messages like:
> 
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [3712914.436297] Console: colour dummy device 80x25
> 
> This cause by the initialisation of tb_to_ns_scale in time_init(), suddenly the
> multiplication in sched_clock() now does something :).  This patch modifies
> sched_clock() to report the offset since the machine booted so the same
> printk's now look like:
> 
> [    0.000000] time_init: decrementer frequency = 188.044000 MHz
> [    0.000000] time_init: processor frequency   = 1504.352000 MHz
> [    0.000135] Console: colour dummy device 80x25
> 
> Effectively including the uptime in printk()s.

Just wondering, does the INITIAL_JIFFIES mechanism to catch wrap bugs still
work after this patch?

include/linux/jiffies.h:
| /*
|  * Have the 32 bit jiffies value wrap 5 minutes after boot
|  * so jiffies wrap bugs show up earlier.
|  */
| #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1526020133-1182325060=:27011--
