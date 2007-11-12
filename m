Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61665DDE0F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 01:11:00 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Ira05-0007cM-Vd
	for linuxppc-dev@ozlabs.org; Mon, 12 Nov 2007 08:10:55 -0600
To: linuxppc-dev@ozlabs.org
Subject: DTC Update: New /dts-v1/ support!
Date: Mon, 12 Nov 2007 08:10:53 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ira05-0007cM-Vd@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

Dave and I have finally comes to an agreement [*1*] about
the new format for some literals in DTS files as supported
by the Device Tree Compiler.

With that, I have just pushed out some changes to the DTC
repository on jdl.com [*2*] that supports the new /dts-v1/
formatted files with C-like literal support.

I encourage everyone to upgrade to this version of the DTC
as soon as they can.  Log messages for the three relevant
commits implementing it are below [*3*].

Please let me know if you have any problems with it!

Thanks,
jdl


[*1*] He beat me senseless until I relented.

[*2*] git://jdl.com/software/dtc.git

[*3*]

commit 91967acabdfbff8b44fd3a19f432bc6e690df8cc
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Nov 7 11:17:37 2007 +1100

    dtc: -Odts produces v1 output
    
    This patch alters the -Odts mode output so that it uses dts-v1 format.
    This means that dtc -Idts -Odts used on a v0 dts file will convert
    that file to v1.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Jon Loeliger <jdl@freescale.com>

commit 9138db565adeb2fbba3181fb589f1c9a3f818dde
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Nov 7 11:17:17 2007 +1100

    dtc: Switch dtc to C-style literals
    
    dtc: Switch dtc to C-style literals
    
    This patch introduces a new version of dts file, distinguished from
    older files by starting with the special token /dts-v1/.  dts files in
    the new version take C-style literals instead of the old bare hex or
    OF-style base notation.  In addition, the "range" for of memreserve entries
    (/memreserve/ f0000-fffff) is no longer recognized in the new format.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Jon Loeliger <jdl@freescale.com>

commit 9ed27a2aac6f7bbbb16d48854763a6d79f6a9857
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Nov 7 11:16:19 2007 +1100

    dtc: Simplify lexing/parsing of literals vs. node/property names
    
    The current scheme of having CELLDATA and MEMRESERVE states to
    recognize hex literals instead of node or property names is
    arse-backwards.  The patch switches things around so that literals are
    lexed in normal states, and property/node names are only recognized in
    the special PROPNODENAME state, which is only entered after a { or a
    ;, and is left as soon as we scan a property/node name or a keyword.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Jon Loeliger <jdl@freescale.com>
