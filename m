Return-Path: <legoater@free.fr>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 86E28DE05A
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 02:42:30 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.14.3/8.13.8) with ESMTP id n2DFgPS7139332
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 15:42:25 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n2DFgONI4214794
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 16:42:24 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n2DFgNU6008568
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 16:42:23 +0100
Message-ID: <49BA7EDC.1000705@free.fr>
Date: Fri, 13 Mar 2009 16:42:20 +0100
From: Cedric Le Goater <legoater@free.fr>
MIME-Version: 1.0
To: Oren Laadan <orenl@cs.columbia.edu>
Subject: Re: [PATCH 1/3] powerpc: bare minimum
	checkpoint/restart	implementation
References: <1233182478-27113-1-git-send-email-ntl@pobox.com>	<1233182478-27113-2-git-send-email-ntl@pobox.com>	<49814FA2.9060108@cs.columbia.edu>	<20090129214035.GB6913@localdomain>	<20090217010355.58afd5cf@thinkcentre.lan>
	<49B9D37A.1070503@cs.columbia.edu>
In-Reply-To: <49B9D37A.1070503@cs.columbia.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: containers@lists.osdl.org, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> More specifically, I envision restart to work like this:
> 
> 1) user invokes user-land utility (e.g. "cr --restart ..."
> 2) 'cr' will create a new container
> 3) 'cr' will start a child in that container

process 1 in its private namespaces.

> 4) child will create rest of tree (in kernel or in user space - tbd)
> 5) each task in that tree will restore itself
> 6) 'cr' monitors this process
> 7) if all goes well - 'cr' report ok.
> 8) if something goes bad, 'cr' notices and notifies caller/user

that's MCR implementation of restart. 
 
> so tasks that are restarting may just as well die badly - we don't care.

just sigkill them, but at end, before releasing the container from 
a frozen state, we have to make sure the right number of tasks have 
restarted ... so you need to track them along the way.

C.
