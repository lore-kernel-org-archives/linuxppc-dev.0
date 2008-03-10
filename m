Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 51A21DE012
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 03:38:59 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2AGco33024712
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 09:38:51 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2AGcoKx012559
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 11:38:50 -0500 (CDT)
Message-ID: <47D56419.6000704@freescale.com>
Date: Mon, 10 Mar 2008 11:38:49 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Confused about usercopy_64.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm confused about something in usercopy_64.c:

unsigned long copy_from_user(void *to, const void __user *from, unsigned long n)
{
	if (likely(access_ok(VERIFY_READ, from, n)))
		n = __copy_from_user(to, from, n);
	else
		memset(to, 0, n);
	return n;
}

If access_ok() returns false, then that means that we cannot copy the data from
user-space.  So why are we returning 'n'?  Shouldn't we return zero, to let the
caller know that the function failed?

-- 
Timur Tabi
Linux kernel developer at Freescale
