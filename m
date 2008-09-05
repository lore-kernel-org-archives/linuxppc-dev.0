Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 322A3DDF51
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 11:06:51 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	m8516TIF030415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Sep 2008 03:06:39 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m8516I3N030409
	for linuxppc-dev@ozlabs.org; Fri, 5 Sep 2008 03:06:18 +0200
Date: Fri, 5 Sep 2008 03:06:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: build failure with current linus tree
Message-ID: <20080905010618.GA30278@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current linus tree fail to build for me for a 64bit powerpc config with:

WARNING: modpost: Found 13 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
mm/built-in.o: In function `.strndup_user':
(.text+0x1401a): undefined reference to `.LCTOC0'
mm/built-in.o: In function `.walk_page_range':
(.text+0x269ae): undefined reference to `.LCTOC0'
fs/built-in.o: In function `.posix_acl_alloc':
(.text+0x5f62a): undefined reference to `.LCTOC0'
fs/built-in.o: In function `.posix_acl_from_xattr':
(.text+0x5feda): undefined reference to `.LCTOC0'
fs/built-in.o: In function `.ext3fs_dirhash':
(.text+0x8e17e): undefined reference to `.LCTOC0'
fs/built-in.o:(.text+0xe844e): more undefined references to `.LCTOC0'
follow
make[2]: *** [.tmp_vmlinux1] Error 1
make[1]: *** [sub-make] Error 2
make: *** [all] Error 2

The config is at http://verein.lst.de/~hch/.config, I'm using gcc 3.4.6.
