Return-Path: <jonathan@jonmasters.org>
Received: from smtp.mailbox.co.uk (smtp.mailbox.net.uk [195.82.125.32])
	by ozlabs.org (Postfix) with ESMTP id 8D0BF2BDDA
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2004 12:49:37 +1000 (EST)
Message-ID: <4152310C.50405@jonmasters.org>
Date: Thu, 23 Sep 2004 03:12:28 +0100
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: T Michael Turney <tmike@theptrgroup.com>
References: <GEEKLLHMFHLAJOBEEELHKEJJCLAA.tmike@theptrgroup.com>
In-Reply-To: <GEEKLLHMFHLAJOBEEELHKEJJCLAA.tmike@theptrgroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.4 kernel ppc-405 query
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

T Michael Turney wrote:

| Folks,
| Most of my PPC experience is with Freescale pieces.

A little different sometimes.

| Q.1) 405 platform seems more vulnerable to OOPS from config changes than
| 8xx?

I think that's not a valid statement - choose the wrong options and
you'll end up with builds that haven't been well tested but for most
normal configs you're fine. Perhaps you can provide some more
information about your configuration.

| General observation is the 405 code base seems more "fragile" than
8xx/8xxx
| codebase.

It's changed quite randomly during the teen 2.4.xx kernels from not
working at all to working mostly - that is if you use the stock kernel
(which I do for everything I am doing) - but most folks seem to
encourage the use of vendor kernels for development.

| Q.2) Is IDE internal workings different during discovery than FS accesses?

You'll need to be a bit more specific in your question there - discovery
of IDE devices usually happens in the initialisation of the driver which
is managing them (although of course you'll get hotplug types who'll
jump up and down and say you might need to do this at any time) and in
that sense is not running as a result of any calls from the block layer
which the VFS (this is the filesystem layer's nomenclature) relies upon
to provide it with buffers of sector data. So there are different parts
of a driver but that's all fairly standard and documented.

Try checking out the Linux Device Drivers 2 book (freely available from
O'Reilly - http://www.xml.com/ldd/chapter/book/ (there's a 2.6 version
coming sometime soon apparently), Understanding the Linux Kernel, Linux
Kernel Development, and the http://www.kernelnewbies.org/ website.

| System can identify an IDE harddisk with 2 partitions but then generate
| OOPS later on when attempting to mount /root filesystem.

You need to send us a copy of the output which was generated and have
parsed this with ksymoops or in the very least send me personally your
output together with System.map and kernel image and I'll do this bit
for you and followup.

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBUjEMeTyyexZHHxERAvmWAJ9CyoMPbCI8dt7rNzyCsKt0gNn11gCfSNyp
IrTXHa/aqITU/Wv5eIS6lKQ=
=kkVd
-----END PGP SIGNATURE-----
