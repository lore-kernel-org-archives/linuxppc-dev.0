Return-Path: <wilbur512@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 24598B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 01:21:36 +1000 (EST)
Received: by gyd10 with SMTP id 10so6713696gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 08:21:34 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Jun 2010 23:21:34 +0800
Message-ID: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
Subject: kernel init exception
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are   porting linux 2.6.21.7 to a powerpc e500mc board , p4080.

But something is wrong when loading init file:

log:

free init memory...

init has generated signal  4  but has no handler for it


I found it print in _exception --->

                                   if (is_init(current)) {
                                         if (handler == SIG_DFL) {
    			  printk(KERN_CRIT "init has generated signal %d "
			        "but has no handler for it\n", signr);
			do_exit(signr);
		          }
                                   }


why there generated a signal 4  in  init  process?

Thanks
