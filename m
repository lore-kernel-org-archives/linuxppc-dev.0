Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 44565679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 03:06:14 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 3819829ECA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 17:04:35 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25288-01 for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 17:04:34 +0100 (CET)
Received: from archvile (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 48F2B29EC9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 17:04:34 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: How to quickly write cleanmarkers to jffs2 partitions?
Date: Thu, 2 Mar 2006 17:06:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603021706.14618.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I was wondering if there is a trick or common technique I am ignoring to make 
this more efficient:

This is for a 2.4 kernel based system.
In production we use either u-boot or a NFS mounted linux system to erase 
flash and write jffs2 partitions to it. The jffs2 images are small (not 
padded to full partition size to save programming time), but the partitions 
are rather big (12 Mbyte in one case). Problem is that when booting for the 
first time, one has to wait several minutes (during which the system is more 
or less useless and busy) to get all cleanmarkers written to flash by the 
jffs2 gc thread. This huge delay is rather unacceptable for production, so we 
are looking for a work-around.

One option would be to make jffs2 images that are padded to full partition 
size, but that also isn't very efficient, considering the image is only about 
100k in beginning and the partition is 12 Mbyte in size. That would take a 
lot of time programming flash (less time than having the jffs2 driver fix 
this nevertheless).

Another option is making a little program that writes cleanmarkers in every 
eraseblock starting from the first completely empty one in a partition before 
mounting that partition for the very first time after flashing.

Since this seems to me like a common situation, I'd like to know if anybody 
knows about a better solution, or if anybody has already dealt with this 
before.

Greetings,

-- 
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1689 AL Zwaag
