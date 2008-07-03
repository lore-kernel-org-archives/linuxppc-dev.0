Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 271D4DDDFD
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 13:15:48 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m633Fi1R005446
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:15:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m633Fi88223850
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:15:44 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m633Fivr028171
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:15:44 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m633FiNp028149
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 23:15:44 -0400
Received: from [9.65.174.195] (sig-9-65-174-195.mts.ibm.com [9.65.174.195])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m633FhYR043658
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jul 2008 22:15:43 -0500
Message-ID: <486C4462.4010004@austin.ibm.com>
Date: Wed, 02 Jul 2008 22:15:46 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5 v2] Update memory dlpar for dynamic reconfiguration memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patchset corrects a set of issues for memory dlpar and the
representation of memory in the device tree under the 
ibm,dynamic-reconfiguration-memory node.

On newer hardware and kernels, the device tree has changed so that all
memory appears under the ibm,dynamic-reconfiguration-memory node in the
device tree.  This node has several properties that describe all possible
lmbs, lmb-size and numa affinity.

The ibm,dynamic-memory property is a list of all possible lmbs, where each
list entry contains the base address, drc index, associativity array index
and a set of flags.

The ibm,associativity-lookup-arrays property contains a list of associativity
arrays and the ibm,lmb-size property contains the size of the lmbs

For reference, each lmb available to the system was previously represented 
with a node in the device tree, of the form /proc/device-tree/memory@XXXXXXXX.
Each of these memory nodes had properties such as "ibm,my-drc-index" for the
drc index and "regs" which contained the base address and lmb size of the lmb.

With the new device tree layout, code associated with memory dlpar needs to
be updated to parse the new device tree layout and properly call the memory
hotplug notifier chains.  Additionally, numa associativity done during hotplug
add of memory needs an update for parsing the new device tree layout.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com> 
