Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07FBF67BF2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Oct 2006 02:40:21 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9KGeHYF020863
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 12:40:17 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9KGeGFe314920
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:40:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9KGeGOt027219
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:40:16 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org, Anthony J Marsala <marsala@us.ibm.com>
Subject: Selecting the ppc_md.power_save method at boot time
Date: Fri, 20 Oct 2006 18:40:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610201840.14389.arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anthony was asking me to add support for disabling the cbe_idle
function for cell at boot time, in order to make it easier to
use some debugging tools.

I already intend to move the cbe_idle implementation over to
a simpler power_save method, so these two changes could be
combined by making the power_save function selectable at
boot time.

I could imagine two ways to implement this:

1. Add a boot option to simply disable calling ppc_md->power_save
on all platforms. E.g. powersave=off.

2. Make it possible to have multiple implementations, e.g.
powersave=cbe, powersave=nap, powersave=cede, powersave=off,
powersave=power4, with a per-platform default.

Is anyone interested in the second solution? Otherwise I'd post
a simple patch to just do powersave=off.

	Arnd <><
