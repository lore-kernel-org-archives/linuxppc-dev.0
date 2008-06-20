Return-Path: <nfont@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EBB87DE1E2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 07:25:12 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5KLP8O5017359
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:25:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5KLP89I193096
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:25:08 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5KLP8PQ024538
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:25:08 -0400
Received: from austin.ibm.com (netmail2.austin.ibm.com [9.41.248.176])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m5KLP78f024523
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 17:25:07 -0400
Received: from [9.53.40.161] (mudbug-009053040161.austin.ibm.com [9.53.40.161])
	by austin.ibm.com (8.13.8/8.12.10) with ESMTP id m5KLP7vK071100
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:25:07 -0500
Message-ID: <485C2033.20101@austin.ibm.com>
Date: Fri, 20 Jun 2008 16:25:07 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/5] Updates for memory dlpar and dynamic reconfiguration
	memory
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patchset corrects a couple of issues with memory dlpar and
adds support for the new memory layout in the device tree on the latest Power
hardware and kernels.

On newer hardware and kernels, the device tree has changed so that all
memory appears under the node ibm,dynamic-reconfiguration-memory.  This node
has several properties that describe lmbs, lmb-size and numa affinity.

The ibm,dynamic-memory property is a list of all possible lmbs, where each
list entry contains the base address, drc index, associativity array index
and a set of flags.

The ibm,associativity-lookup-arrays property contains a list of associativity
arrays and the ibm,lmb-size contains the size of the lmbs

For reference, memory was previously represented with a node, of the form
memory@XXXXXXXX, for each lmb assigned the system.  Each of these memory
nodes had properties such as ibm,my-drc-index for the drc index and regs
for the base address and lmb size.

With the new device tree layout, code associated with memory dlpar needs to
be updated to parse the new device tree layout and properly call the memory
hotplug notifier chains.  Additionally, the numa associativity roiutine
called during hotplug add of memory needs a seperate version for parsing the
new device tree layout.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
