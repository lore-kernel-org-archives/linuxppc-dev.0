Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D31CDE224
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 06:58:06 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3GKw0uC026152
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 13:58:00 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3GKw0Hw004056
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 15:58:00 -0500 (CDT)
Message-ID: <48066857.4030109@freescale.com>
Date: Wed, 16 Apr 2008 15:57:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: lseek() on entries in /proc/device-tree returns EINVAL
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm writing a utility that parses the device tree in /proc/device-tree, and in
order to read a property into memory, I have to first find out how large it is.
 So I have the following code:

	off_t off;
	int f;

	f = open(filename, O_RDONLY);
	if (f == -1) {
		perror(__func__);
		return NULL;
	}

	off = lseek(f, 0, SEEK_END);
	if (off == -1) {
		perror(__func__);
		goto fail;
	}

The lseek() call returns -1, and errno is set to EINVAL.  According to the man
page, this means:

       EINVAL The  whence  argument  is  not a proper value, or the resulting
              file offset would be negative for a regular file, block special
              file, or directory.

Is there a limitation for the implementation of /proc/device-tree that prevents
lseek() from working?  If so, how do I determine the size of a property?

-- 
Timur Tabi
Linux kernel developer at Freescale
