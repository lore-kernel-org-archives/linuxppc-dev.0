Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4B1CEB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 05:40:20 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6B54DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 05:40:19 +1000 (EST)
Message-ID: <4AA4101B.3070706@embedded-sol.com>
Date: Sun, 06 Sep 2009 22:40:11 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: uchiyama.toru@jp.fujitsu.com,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	linux-netdev@vger.kernel.org
Subject: gianfar compilation is broken in 2.6.31-rc9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Compilation of gianfar  driver fails in 2.6.31-rc9:

CC      drivers/net/gianfar.o
drivers/net/gianfar.c: In function 'gfar_remove':
drivers/net/gianfar.c:494: error: 'dev' undeclared (first use in this 
function)
drivers/net/gianfar.c:494: error: (Each undeclared identifier is 
reported only once
drivers/net/gianfar.c:494: error: for each function it appears in.)
make[2]: *** [drivers/net/gianfar.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

The problem was introduce by the following commit:

commit 38bddf04bcfe661fbdab94888c3b72c32f6873b3
Author: Toru UCHIYAMA <uchiyama.toru@jp.fujitsu.com>
Date:   Sun Aug 30 22:04:07 2009 -0700

    gianfar: gfar_remove needs to call unregister_netdev()

Felix.
