Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id B67D5B7BA4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Oct 2009 09:54:53 +1100 (EST)
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Serial console under current qemu: bisected.
Date: Wed, 21 Oct 2009 17:54:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200910211754.49223.rob@landley.net>
Cc: alan@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Last week I reported a bug:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/076727.html

I managed to drill past the unrelated breakage and bisect it back to the 
relevant commit: It was introduced leading up to 2.6.29, by commit 
f751928e0ddf54ea4fe5546f35e99efc5b5d9938 written by Alan Cox.

It seems to make the kernel panic as soon as IRQs are enabled in the presence 
of CONFIG_SERIAL_PMACZILOG=y.  It's trivially reproducible under current qemu-
git.  Kernels before that boot to a shell prompt, kernels after that panic as 
soon as init launches.  (They work fine when you're not using a serial 
console.)

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
