Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9EE5DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 22:08:50 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HnvpZ-00005V-Nb
	for linuxppc-embedded@ozlabs.org; Tue, 15 May 2007 05:08:41 -0700
Message-ID: <10621564.post@talk.nabble.com>
Date: Tue, 15 May 2007 05:08:41 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: zImage.elf loads but does not start
In-Reply-To: <10429898.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10079346.post@talk.nabble.com> <10142161.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net>
	<10165159.post@talk.nabble.com> <10323147.post@talk.nabble.com>
	<463B5422.6030105@ru.mvista.com> <10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
	<4640F08E.5040608@nec.com.au>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C06A207@MERCURY.inside.istor.com>
	<10409434.post@talk.nabble.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC2F391B@exchangemb3.bnl.gov>
	<10429898.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>It seems to be that the console works fine and the root file system is
mounted properly via NFS.
>I do not however understand why eldk4.1 init does not work.

I have done some more investigations. My observation is as following:

The eldk4.1/ppc_4xx root file system has the init which is not statically
built. When I removed the lib directory on the
NFS server:/opt/eldk4.1/ppc_4xx/lib the kernel has booted up to the point:

[    9.302101] VFS: Mounted root (nfs filesystem).
[    9.357642] Freeing unused kernel memory: 96k init
[    9.481509] Kernel panic - not syncing: No init found.  Try passing init=
option to kernel.


When the lib directory was present the last printed message was:
[    9.357642] Freeing unused kernel memory: 96k init

I have observed the same behaviour with busybox accessed via NFS.
I have compiled busybox with crosstool-0.43 (gcc-4.0.2 glibc-2.3.2) because
eldk4.1 crosscompilers failed to compile busybox. When using busybox mounted
via NFS I copied the lib directory from crosstool.
Unfortunately also this time the system hanged at init.

My own version of init which uses printf just to print the string to the
screen runs however fine.

Would somebody have some suggestion what might cause the problem to properly
launch the init command.

Best Regards

Mirek
-- 
View this message in context: http://www.nabble.com/zImage.elf-loads-but-not-starts-tf3607582.html#a10621564
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
