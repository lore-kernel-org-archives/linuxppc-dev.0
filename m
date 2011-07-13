Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 2E784B6F75
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 23:02:12 +1000 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	p6DD286I015549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 08:02:08 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id p6DD28vR015548
	for linuxppc-dev@ozlabs.org; Wed, 13 Jul 2011 08:02:08 -0500
Date: Wed, 13 Jul 2011 08:02:08 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@ozlabs.org
Subject: grasping why mpt2sas fails with BITS_PER_LONG conditional
Message-ID: <20110713130208.GA15267@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've had problems with the mpt2sas driver
(drivers/scsi/mpt2sas/mpt2sas_base.c) when using it on my
ppc44x.  Basically, there is a check in the code for
BITS_PER_LONG and certain code is executed if it is 64 vs 32
bit.  I am guessing it is a problem with the driver but it
only shows up on powerpc.  If i force it to take the 64 bit
path it works fine, but if I let the preprocessor decide it
will take the 32 bit path and fail later.  I am not
configuring my kernel as 64 bit, but I am guessing this has
to do with the 36 bit plb bus on these parts.

can somebody enlighten me as to what the right thing to do
here is?

thanks
ayman
