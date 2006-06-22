Return-Path: <mkravetz@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E286F67A58
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 09:59:53 +1000 (EST)
Received: from e3.ny.us.ibm.com (e3.pok.ibm.com [9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MMtwA4023498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 18:55:59 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5MMtsuo027768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 18:55:55 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5MMtsPj285540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 18:55:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5MMtsmI030432
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 18:55:54 -0400
Date: Thu, 22 Jun 2006 15:56:09 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060622225609.GA4877@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	Nathan Lynch <ntl@pobox.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is an updated version of the hcall instrumentation patches.
Unfortunately, I have not been able to spend as much time as I
would like on this (and it seems that will continue).  

This version addresses all comments received except Arnd's issue
with an #ifdef for each function in the assembly file.  I like
Jimi's suggestion for creating macros(which could also minimize
the #ifdefs), but have not got around to implementing this.
Suggestions of others way to accomplish this are welcome.

Statistic files are moved to debugfs, and remain split out by CPU.
After some thought, disable/enable of preemption was added around
the statistic gathering(mostly for timing).

-- 
Mike
