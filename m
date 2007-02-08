Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id 0A342DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Feb 2007 00:38:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: multiple devices using ELDK NFS mounts
Date: Thu, 8 Feb 2007 14:04:51 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AAF68@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Daniel Ng" <daniel_ng11@lycos.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel Ng wrote:
> I am working on multiple ELDK devices. So far, I just have one copy of
the ELDK=20
> NFS mount per device. This gets unwieldly when we have more than a few
devices,=20
> especially considering the size of one NFS mount being over 800Mb.=20
>
> Can you suggest a more efficient way? Something like sharing part of a
single=20
> NFS mount across multiple devices? Or some other way?

You can mount the NFS root read-only and modify startup
scripts/fstab/etc.
so that /var and /tmp are mounted as ramfs or tmpfs. Use some soft links
to provide mutable files in previous mount points. Works great.
And nobody is going to wreck the NFS root by mistake.  :-)
Throw in additional services: PAM, NIS, etc.
ELDK is not an end-product, it's a starter-product ;-)
Thank goes to DENX Software Engineering for their nice package.
BTW, ELDK 4.1 has been released recently, and it includes among
other things Xenomai and the long awaited uClibc support.
http://www.denx.de/en/News/PressReleaseELDK41

Have fun.
--=20
Stephane

PS: I am in no way associated with DENX, I'm just a happy customer who
speak=20
on my own behalf, not for my employer.
