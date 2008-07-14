Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id AC5E6DE3C7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 06:44:14 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Mon, 14 Jul 2008 22:44:07 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807142244.07450.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 July 2008, Rune Torgersen wrote:

> Context switching - times in microseconds - smaller is better
> ------------------------------------------------------------------------
> Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
>                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> --------- ------------- ------ ------ ------ ------ ------ ------- -------
> 9919_unit  Linux 2.6.25   20.6   86.2   28.5  103.8   38.7   111.8   57.4
> 9919_unit  Linux 2.6.18 5.3300   63.2   17.9   73.4   23.1    74.9   26.2

This is certainly significant, but a lot has happened between the two
versions. I few ideas:

* compare some of the key configuration options:
  # CONFIG_DEBUG_*
  # CONFIG_PREEMPT*
  # CONFIG_NO_HZ
  # CONFIG_HZ

* Try looking at where the time is spent, using oprofile or readprofile

* Try setting /proc/sys/kernel/compat/sched_yield to 1, to get the legacy
behaviour of the scheduler.

* Maybe there is a kernel version that supports your hardware in both
arch/ppc/ and arch/powerpc. In that case, you could see if the platform
change had an impact.

	Arnd <><
