Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 169E5DDF04
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2007 02:09:20 +1000 (EST)
Received: from t5e70.t.pppool.de ([89.55.94.112] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50) id 1HyrRz-0002zV-LF
	for linuxppc-dev@ozlabs.org; Thu, 14 Jun 2007 17:41:31 +0200
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@ozlabs.org
Subject: Powerbook hard shutdown after boot if it's hot
Date: Thu, 14 Jun 2007 17:39:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706141739.12754.mb@bu3sch.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have a strange problem that my Powerbook shuts down hard
right after boot, if the machine is hot.
For example, if I compile a kernel and then want to reboot
into it, it will shutdown the machine right after userspace
is booted. Cooling down the machine will fix the issue.
I first thought this might be a problem with the adt746x
chip driver (thermostat). But this turns out to not be
the case. I disabled the module (put return 0; early into
the module_init function), but the problem still exists.
I'm not sure how to debug this, as I don't see what's
going on. I tried to boot with init=/bin/bash. It will
boot into the shell but shutdown hard after 1 or 2 seconds.
It seems like there is some timer hitting in right after
userspace is up and running (some workqueue?). Strange is
that it _only_ shuts down the machine when it's hot
and it _only_ does this right after boot. If it survived
the first few seconds after boot, it's rock-stable and
it won't show any problems when getting hot (will drive
the fans correctly, etc etc...)

Any idea how to debug this?

-- 
Greetings Michael.
