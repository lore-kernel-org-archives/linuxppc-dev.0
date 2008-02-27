Return-Path: <jyoung5@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C54DDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 06:40:47 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1RJeisp031174
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 14:40:44 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1RJeiKZ176516
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 14:40:44 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1RJei54019234
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 14:40:44 -0500
Received: from [9.53.41.205] (thinkpad.austin.ibm.com [9.53.41.205])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1RJehE2019159
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 14:40:43 -0500
Subject: [dtc] breaking out libfdt from dtc so other progs can use it
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 13:40:43 -0600
Message-Id: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
Mime-Version: 1.0
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the dtc source code has libfdt integrated in it. This seems to
have become place for upstream libfdt changes. Now we all know everyone
(linux kernel, cuboot) also have their own versions over libfdt. But if
another userspace app wants to use libfdt , it has to copy it from the
dtc source and try to maintain it's own copy.

The question I have is can libfdt be split out from dtc source, and
become it's own thing. This way other userspace apps can easily download
it and link with it?

The reason I ask is I have added dynamic manipulation support of device
trees in memory into qemu for KVM. But the issue is keeping a copy of
libfdt in the KVM userspace repository, which is getting some opposition
(understandably). But this would be much easier if there was a libfdt
repo for the library so that we wouldn't need to keep our own copy.
