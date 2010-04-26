Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95B4AB7D47
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 04:34:38 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3QIYZAq026125
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 11:34:35 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3QIid1k016232
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 13:44:39 -0500 (CDT)
Message-ID: <4BD5DCBA.9090304@freescale.com>
Date: Mon, 26 Apr 2010 13:34:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
References: <681077.39599.qm@web83502.mail.sp1.yahoo.com>
In-Reply-To: <681077.39599.qm@web83502.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> I am having what appears to be a little conflict
> with this driver, particularly with the MDR.  My
> hardware uses NAND flash and an FPGA connected
> through the UPM.  After the kernel is up and
> running, sometimes I cannot verify the data in
> the UPM RAM array.  I am guessing right now that
> this is due to a use conflict between my
> application and the fsl_elbc_nand driver both
> trying to use the MDR at once.
> 
> Is there currently any sort of coordination that
> exists for the MDR in the fsl_elbc_nand driver?
> I have been looking through the code and have
> not been able to find any.

There is not yet any such coordination.  The current UPM code does not 
use MDR that I can see.

> Any ideas on how to solve this would be
> appreciated as well.

Probably just add a mutex that protects the shared resources.

-Scott
