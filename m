Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate3.mot.com (motgate3.mot.com [144.189.100.103])
	by ozlabs.org (Postfix) with ESMTP id B1DF467BDF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 09:39:01 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate3.mot.com (8.12.11/Motorola) with ESMTP id k7ONct8R020572
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 16:38:55 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k7ONcrqH026536
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 18:38:54 -0500 (CDT)
Date: Thu, 24 Aug 2006 18:38:53 -0500 (Central Daylight Time)
From: T Ziomek <ctz001@email.mot.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: "ip=" command line strangeness...
Message-ID: <Pine.WNT.4.61.0608241815440.200@holyoke.labs.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: tomz <CTZ001@email.mot.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On my previous project, a 2.4 kernel on PPC, I frequently used 
"ip=w.x.y.z" on the kernel command line to specify a static IP address for
my target board (when booting with a flash- or RAM-based root filesystem).
    Similarly, when using an NFS-mounted root fs, I would use
"ip=w.x.y.z:a.b.c.d", along with the appropriate "nfsroot=..." setting,
with my NFS server having IP a.b.c.d .

Now I am working with a 2.6.10-based kernel on ARM.  Using an NFS root fs
works fine when I use the expected "ip=w.x.y.z:a.b.c.d".  And booting off
with "root=/dev/hda1" works fine with "ip=dhcp".
    I'd expect to be able to use "root=/dev/hda1 ip=w.x.y.z" if I want the
target using a static IP address.  But this fails, and in a VERY weird
way:  (1) It tries doing DHCP, which it shouldn't, and (2) the DHCP fails,
which it shouldn't because it works when I want DHCP to be used.
    Here's a snippet of console output:
             .
             .
             .
            NET: Registered protocol family 2
            IP: routing cache hash table of 512 buckets, 4Kbytes
            TCP: Hash tables configured (established 8192 bind 16384)
            NET: Registered protocol family 1
            NET: Registered protocol family 17
            Sending DHCP requests ...... timed out!
            EMAC: TX Complete: Starting queue
            IP-Config: Reopening network devices...
            Sending DHCP requests ...

Okay, that's two weird things.  There is a third -- this problem goes a-
way if I change the command line to something like
"root=/dev/hda1 ip=w.x.y.z:a.b.c.d".  The only change is adding an NFS
server IP address to the "ip=" command, which should have no effect be-
cause NFS is not being used.  Yet when I do that the board boots as ex-
pected -- it does not try to do DHCP, it does use /dev/hda1 for its root
fs, and it does take the specified IP address.

In fact, it works even if I use a command line with, literally,
"root=/dev/hda1 ip=199.5.233.72:gobbledygook":
             .
             .
             .
            NET: Registered protocol family 2
            IP: routing cache hash table of 512 buckets, 4Kbytes
            TCP: Hash tables configured (established 8192 bind 16384)
            NET: Registered protocol family 1
            NET: Registered protocol family 17
            IP-Config: Guessing netmask 255.255.255.0
            IP-Config: Complete:
                  device=eth0, addr=199.5.233.72, mask=255.255.255.0, gw=255.255.255.255,
                 host=199.5.233.72, domain=, nis-domain=(none),
                 bootserver=232.0.0.0, rootserver=232.0.0.0, rootpath=
             .
             .
             .

This isn't a big problem, but can anybody explain what the heck is going
on?

Thanks, Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
