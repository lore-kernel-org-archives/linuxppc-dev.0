Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B3D67679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Mar 2006 02:20:31 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FJXnR-0000UA-Jj
	for linuxppc-embedded@ozlabs.org; Wed, 15 Mar 2006 16:20:21 +0100
Received: from mail.toimi.com ([208.45.127.50])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 15 Mar 2006 16:20:21 +0100
Received: from dave by mail.toimi.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 15 Mar 2006 16:20:21 +0100
To: linuxppc-embedded@ozlabs.org
From: David Updegraff <dave@cray.com>
Subject: OF tree flattening.
Date: Wed, 15 Mar 2006 09:10:42 -0600
Message-ID: <dv9apk$5r8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

When OF device tree is flattened, the resultant struct has pointers into
the 'initial_boot_params' area.

I think that area needs 'reserving', since the text of various
properties are contained therein.

One could perhaps argue that the BootRom should do that, in the provided
OF-tree reserve maps... but if we're gonna keep pointers into the area,
seems we should protect it.  Adding a
--------
lmb_reserve(__pa(initial_boot_params), initial_boot_params->totalsize);
------------
to early_init_devtree() worked for me.

There is of course then the problem alluded to in
kdump_move_device_tree(), that then this old DT should be un-reserved..
   I don't have a suggestion for that problem; hope some of you do?

thnx.

-dbu.
