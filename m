Return-Path: <Charles.A.Wright@snapon.com>
Received: from ken48.snapon.com (dns1.snapon.com [12.20.116.2])
	by ozlabs.org (Postfix) with ESMTP id AB25FDDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 06:16:00 +1000 (EST)
Received: from lisl-xfnt-02-pp.snaponglobal.com (lisl-xfnt-02-pp.snapon.com
	[10.245.128.49])
	by ken48.snapon.com (8.11.7p1+Sun/8.11.7) with ESMTP id m8MK7td13337
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 15:07:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Memcpy() on MPC5200B
Date: Mon, 22 Sep 2008 15:07:51 -0500
Message-ID: <C0DD8F5AD4467E45B3D82B7D7A57885B16E2559E@LISL-XBCK-C1-V2.snaponglobal.com>
In-Reply-To: <mailman.1567.1222082514.3127.linuxppc-dev@ozlabs.org>
From: "Wright, Chuck" <Charles.A.Wright@snapon.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've found a case where memcpy() is failing on copies longer that 4
bytes.=20

Closer investigation found that the destination pointer is not pointing
to a word aligned address.

The problem comes from the JFFS2 driver where there is a struct that is
being used to create the destination pointer for the memcpy() function.

If I insert my own padding into the struct, my memcpy() problems go
away!
I'm concerned that this problem may be lurking in other areas of code.
(I get no warnings during compile)

On the MPC5200B processor, is that the assumed behavior for an unaligned
memcpy()??
Is there a gcc option to force word alignment??

I'm using a MontaVista supplied kernel and compiler. (not my choice!)=20
Unfortunately, six weeks later, MontaVista is still confused.

Thanks for any help you can offer,

Chuck Wright
