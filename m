Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id A41E7DE810
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 01:47:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Thu, 17 Jul 2008 17:47:28 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807170032.36564.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34B71@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B34B71@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807171747.28624.arnd@arndb.de>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 July 2008, Rune Torgersen wrote:
> Arnd Bergmann wrote:
> > If you can't get it to work, readprofile(1) is a much simpler
> > tool, both in what it can do and what it requires you to do.
> 
> One thing that pops out is that handle_mm_fault uses twice as many
> ticks in arch/powerpc.

The other thing I found interesting is that cpu_idle is on the
top of the list in arch/powerpc but does not show up anywhere
in your top arch/ppc samples. This indicates that the system is
waiting for something, e.g. disk I/O for a significant amount
of time.

Seeing more hits in handle_mm_fault suggests that you have
a higher page fault rate. A trivial reason for this might
be that the amount of memory was misdetected in the new
code (maybe broken device tree). What is the content of
/proc/meminfo after a fresh boot?

If it's the same, try running a kernel build with 'time --verbose',
using GNU time instead of the bash builtin time to see how the
page fault rate changed.

	Arnd <><
