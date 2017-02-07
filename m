Return-Path: <hanpt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHR435D7BzDqCs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 12:06:11 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1713ahp032207
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 20:06:09 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28etucx2f7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 20:06:08 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hanpt@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 20:06:07 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 742136E803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 20:05:36 -0500 (EST)
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v171642514024976
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Feb 2017 01:06:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CC12124052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 20:06:04 -0500 (EST)
Received: from localhost.localdomain (unknown [9.115.120.216])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 282CF124035
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 20:06:04 -0500 (EST)
Date: Tue, 7 Feb 2017 09:05:58 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/pseries: Increase busy loop in pseries_cpu_die
References: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <20170207010558.GA5493@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2017 at 04:58:16PM -0200, Thiago Jung Bauermann wrote:
> This was reproduced in v4.10-rc6 as well, but I don't have a crash log
> handy for that version right now. Sorry.
> 
This is the crash log of v4.10:

roselp4 login: [  505.097727] sysrq: SysRq : Changing Loglevel
[  505.097743] sysrq: Loglevel set to 9
[  595.183727] iommu: Removing device 0021:01:00.0 from group 0
[  605.213053] pci_bus 0021:01: busn_res: [bus 01-ff] is released
[  605.213204] rpadlpar_io: slot PHB 33 removed
[  624.623544] min_free_kbytes is not updated to 16826 because user defined value 547628 is preferred
[  647.574039] cpu 152 (hwid 152) Ready to die...
[  647.803624] cpu 153 (hwid 153) Ready to die...
[  647.813371] cpu 154 (hwid 154) Ready to die...
[  647.823646] cpu 155 (hwid 155) Ready to die...
[  647.833371] cpu 156 (hwid 156) Ready to die...
[  647.843392] cpu 157 (hwid 157) Ready to die...
[  647.853368] cpu 158 (hwid 158) Ready to die...
[  647.863358] cpu 159 (hwid 159) Ready to die...
[  648.233756] cpu 144 (hwid 144) Ready to die...
[  648.383417] cpu 145 (hwid 145) Ready to die...
[  648.383488] cpu 146 (hwid 146) Ready to die...
[  648.383551] cpu 147 (hwid 147) Ready to die...
[  648.402845] cpu 148 (hwid 148) Ready to die...
[  648.403329] cpu 149 (hwid 149) Ready to die...
[  648.403384] cpu 150 (hwid 150) Ready to die...
[  648.413398] cpu 151 (hwid 151) Ready to die...
[  648.583466] cpu 136 (hwid 136) Ready to die...
[  648.833672] cpu 137 (hwid 137) Ready to die...
[  648.843481] cpu 138 (hwid 138) Ready to die...
[  648.843541] cpu 139 (hwid 139) Ready to die...
[  648.843589] cpu 140 (hwid 140) Ready to die...
[  648.843635] cpu 141 (hwid 141) Ready to die...
[  648.853426] cpu 142 (hwid 142) Ready to die...
[  648.863105] Querying DEAD? cpu 142 (142) shows 2
[  648.863697] cpu 143 (hwid 143) Ready to die...
[  649.013280] cpu 128 (hwid 128) Ready to die...
[  649.253575] cpu 129 (hwid 129) Ready to die...
[  649.253634] cpu 130 (hwid 130) Ready to die...
[  649.253689] cpu 131 (hwid 131) Ready to die...
[  649.253741] cpu 132 (hwid 132) Ready to die...
[  649.253793] cpu 133 (hwid 133) Ready to die...
[  649.253836] cpu 134 (hwid 134) Ready to die...
[  649.253885] cpu 135 (hwid 135) Ready to die...
[  649.353116] cpu 120 (hwid 120) Ready to die...
[  649.553776] cpu 121 (hwid 121) Ready to die...
[  649.563626] Querying DEAD? cpu 122 (122) shows 2
cpu 0x7b: Vector: 400 (Instruction Access) at [c000000007bc7d40]
    pc: f81f0070801f0078
    lr: f81f0070801f0078
    sp: ec20d28
   msr: 8000000042801000
  current = 0xc000000474838600
  paca    = 0xc000000007b65300   softe: 0        irq_happened: 0x01
    pid   = 0, comm = swapper/123
Linux version 4.10.0-rc6 (bauermann@u1604le) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #1 SMP Fri Feb 3 18:55:20 BRST 2017
WARNING: exception is not recoverable, can't continue
enter ? for help
SP (ec20d28) is in userspace
7b:mon> e
cpu 0x7b: Vector: 400 (Instruction Access) at [c000000007bc7d40]
    pc: f81f0070801f0078
    lr: f81f0070801f0078
    sp: ec20d28
   msr: 8000000042801000
  current = 0xc000000474838600
  paca    = 0xc000000007b65300   softe: 0        irq_happened: 0x01
    pid   = 0, comm = swapper/123
Linux version 4.10.0-rc6 (bauermann@u1604le) (gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) ) #1 SMP Fri Feb 3 18:55:20 BRST 2017
7b:mon> 
