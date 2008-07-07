Return-Path: <chandru@in.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E254DE243
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 04:44:19 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67IhbJx028272
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:43:37 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67IiHBi283984
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:44:17 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67IiHiu024489
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 04:44:17 +1000
From: Chandru <chandru@in.ibm.com>
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 00:14:15 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807080014.15648.chandru@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Following is a patch series that contains changes for kexec/kdump on Power6 
machines. Power6 machines have most of their memory represented 
in /proc/device-tree/ibm,dynamic-reconfiguration-memory node. kexec-tools 
currently read only memory@ nodes of device-tree.  Patch 1/4 contains changes 
in the kernel. Patch {2,3,4}/4 are changes for kexec-tools.  The kernel 
changes are similar to what was earlier present for memory@ nodes 
for 'linux,usable-memory' property.  Unlike memory@ nodes, since now there is 
one node under which most of the memory ranges are represented ( 
ibm,dynamic-memory) , I have appended the lmb entry number to 
the 'linux,usable-memory' string so as to identify usable-memory ranges in 
the device-tree. 

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
