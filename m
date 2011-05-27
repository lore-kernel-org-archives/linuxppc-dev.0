Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
	by ozlabs.org (Postfix) with ESMTP id 4F887B6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 May 2011 16:44:45 +1000 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
	by duster.selinc.com (8.14.4/8.14.4) with ESMTP id p4R6Be5d007799
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2011 23:11:40 -0700
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: MPC8308 bursting question
Message-ID: <OF1B4E92C8.698C0AE4-ON8825789D.00209684-8825789D.002206EF@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 26 May 2011 23:11:40 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

This isn't really a Linux PPC question, but this is the smartest mailing 
list I know for asking PPC hardware questions, so here goes.

We're using an MPC8308 and want to use the DMA engine to move data in and 
out of an FPGA hanging on the local bus.  Our bandwidth/local bus burden 
calculations were done assuming that we could use bursting.  So I've setup 
a UPM to do single beat and burst reads/writes.  I've also configured my 
DMA TCD to use a data transfer size of 32-bytes when accessing the FPGA. 
The problem I'm having is I can't seem to get the UPM to ever trigger the 
burst write sequence using the DMA.  Single beat reads and writes work 
okay, but no bursting.  In fact, the only thing I've been able to find in 
the manual that causes a burst transaction is a cache line miss, which is 
wholly in the purview of the core and really does me no good.

Does anyone know of any way (short of issuing a run command to the UPM via 
MxMR) to force a burst transaction on the 8308?  Am I just being dumb and 
missing something totally fundamental?

Thanks.

Bruce
