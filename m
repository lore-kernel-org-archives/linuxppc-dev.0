Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 63D16679E1
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:04:04 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3SN41Ya001802
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 19:04:01 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3SN41Ok254418
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 19:04:01 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3SN41Lb011127
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 19:04:01 -0400
Date: Fri, 28 Apr 2006 18:04:01 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: PCI init vs. memory init
Message-ID: <20060428230401.GF22621@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,

I'd previously reported a problem where the PCI subsystem 
was getting inited before the memory subsystem. In the unusual
case of an EEH failure, this resulted in a crash in kmalloc,
which I hacked around with a if(!mem_init_done).

You mentioned that the sequence of inits seemed wrong, that the 
PCI init should be done later, after the memory init. I think
I agree; but when I took a very very quick look at the code, there 
was no obvious hook in later init to move the PCI init over to. 

Are you pursuing this further? Should I dig into it?  Any bright
ideas? Am I missing something obvious?  

There are several spots in in the powerpc PCI init code where 
a boot_mem alloc is used instead of kmalloc, and this boot_mem is 
then hacked around in the case of a PCI hotplug remove.  It would 
be nice to fix this...

--linas
