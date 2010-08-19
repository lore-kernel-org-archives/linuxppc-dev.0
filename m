Return-Path: <mroos@linux.ee>
Received: from smtp1.it.da.ut.ee (smtp1.it.da.ut.ee [193.40.5.66])
	by ozlabs.org (Postfix) with ESMTP id 2809CB70E0
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 07:33:37 +1000 (EST)
Date: Fri, 20 Aug 2010 00:03:47 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-scsi@vger.kernel.org
Subject: qla4xxx compile failure on 32-bit PowerPC: missing readq and
 writeq
Message-ID: <alpine.SOC.1.00.1008192359310.19654@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is current 2.6.36-rc1+git on 32-bit PowerPC:

  CC [M]  drivers/scsi/qla4xxx/ql4_nx.o
drivers/scsi/qla4xxx/ql4_nx.c: In function 'qla4_8xxx_pci_mem_read_direct':
drivers/scsi/qla4xxx/ql4_nx.c:717: error: implicit declaration of function 'readq'
drivers/scsi/qla4xxx/ql4_nx.c: In function 'qla4_8xxx_pci_mem_write_direct':
drivers/scsi/qla4xxx/ql4_nx.c:788: error: implicit declaration of function 'writeq'

readq and writeq are defined in io.h but only when compiling for 64-bit 
kernel. Adding manual #include <linux/io.h> does not help here.

-- 
Meelis Roos (mroos@linux.ee)
