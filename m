Return-Path: <legoater@free.fr>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 675FDDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 17:55:48 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.14.3/8.13.8) with ESMTP id n2H6td5A153126
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 06:55:39 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n2H6td3G4280540
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 07:55:39 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n2H6tdOB018288
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 07:55:39 +0100
Message-ID: <49BF4969.3080308@free.fr>
Date: Tue, 17 Mar 2009 07:55:37 +0100
From: Cedric Le Goater <legoater@free.fr>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/3] powerpc: bare minimum
	checkpoint/restart	implementation
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>	<1233182478-27113-2-git-send-email-ntl@pobox.com>	<49814FA2.9060108@cs.columbia.edu>
	<20090129214035.GB6913@localdomain>	<20090217010355.58afd5cf@thinkcentre.lan>	<49B9D37A.1070503@cs.columbia.edu>
	<20090316133745.4f636979@thinkcentre.lan>
In-Reply-To: <20090316133745.4f636979@thinkcentre.lan>
Content-Type: text/plain; charset=ISO-8859-1
Cc: containers@lists.osdl.org, Oren Laadan <orenl@cs.columbia.edu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Again, how would 'cr' obtain exit status for these tasks, and how would
> it distinguish failure from normal operation?

Here's our solution to this issue.

mcr maintains in its kernel container object an exitcode attribute for 
the mcr-restart process. This process is detached from the fork tree of 
the restarted application.  

when the restart is finished, an mcr-wait command can be called to reap 
this exitcode. This make it possible to distinguish an exit of the 
application process from an exit of the mcr-restart process.

This is a must-have for batch managers in an HPC environment. 

Cheers,

C.
