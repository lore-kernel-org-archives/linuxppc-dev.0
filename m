Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 07A4B679E2
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 06:53:39 +1000 (EST)
Date: Sat, 1 Apr 2006 12:53:36 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: linux-kernel@vger.kernel.org
Subject: "tvec_bases too large for per-cpu data" commit broke
	early_serial_setup()
Message-ID: <20060401205336.GA5748@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Jan Beulich <jbeulich@novell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

Commit 
a4a6198b80cf82eb8160603c98da218d1bd5e104 
"[PATCH] tvec_bases too large for per-cpu data"

broke early_serial_setup() and maybe other code which uses 
init_timer() before init_timers_cpu() is called.

This commit introduced run-time initialization dependence which never 
existed before, namely, tvec_bases was always valid before this 
change, but now it's a pointer which should be initialized prior to 
use of any timer function.

If init_timer() is called before such initialization (in my case this 
happens when PPC440GX board support code calls early_serial_setup to 
register UARTs, serial8250_isa_init_ports() calls init_timer()), 
"base" field in the timer_list struct is set to NULL.

When later mod_timer() is called for such timer it hangs in 
lock_timer_base().

Rolling back this commit fixes the problem, although, this is 
obviously not a proper fix.

I don't a fix I like, so I'll leave it to people more familiar with 
this matter :)

-- 
Eugene
