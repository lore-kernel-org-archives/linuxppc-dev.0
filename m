Return-Path: <dcogley@uslinc.com>
Received: from que31.charter.net (que31.charter.net [209.225.8.23])
	by ozlabs.org (Postfix) with ESMTP id 38543DDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jun 2008 07:59:34 +1000 (EST)
Received: from aarprv04.charter.net ([10.20.200.74]) by mta31.charter.net
	(InterMail vM.7.08.03.00 201-2186-126-20070710) with ESMTP
	id <20080618213510.ODID2641.mta31.charter.net@aarprv04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Wed, 18 Jun 2008 17:35:10 -0400
Received: from [192.168.1.34] (really [71.93.35.174])
	by aarprv04.charter.net with ESMTP
	id <20080618213510.EQQF4495.aarprv04.charter.net@[192.168.1.34]>
	for <linuxppc-embedded@ozlabs.org>; Wed, 18 Jun 2008 17:35:10 -0400
Subject: Updating glibc on SELF image
From: Dave Cogley <dcogley@uslinc.com>
To: PPC Embedded List <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain
Date: Wed, 18 Jun 2008 14:35:12 -0700
Message-Id: <1213824912.4450.20.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am having some trouble with building my SELF image on a Sequoia board.
I am trying to update some shared library components on the "stock" DENX
provided JFFS file system image.

While running over an NFS root I was able to successfully mount my MTD
device and manually copy libraries my application requires to the SELF
image. This appears to work for most the libraries that are non existent
on the default image (libreadline, libXml etc.). 

The problem is that when developing on the NFS partition (flash_nfs) the
glic version in use is 2.6 and the SELF image only has 2.3.5. I manually
copy over the libc-2.6.so library from the NFS image to the SELF image
and create a new symbolic link "libc.so.6". Now while booting up with
2.6 I get segfaults on start-up daemons and my application segfaults
when starting as well. Changing the link back to the 2.3.5 library
everything works fine (except my application which requires 2.4).

The glibc library I am attempting to use is compiled for the ppc
architecture and works fine on the NFS partition. Am I missing something
else that needs to be updated for the glibc library? Is there anyway I
can update this library on the SELF image without installing make and
gcc?

Thank You,
Dave Cogley
