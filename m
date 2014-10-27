Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A74B71A1967
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 00:33:28 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 09:33:26 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5A4586E804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 09:22:07 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9RDXN7065208488
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 13:33:23 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9RDXNBZ006967
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 09:33:23 -0400
Received: from preeti.in.ibm.com ([9.77.204.76])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s9RDXBxX005890
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 09:33:22 -0400
Message-ID: <544E4996.3050403@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 19:03:10 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Warnings reported while building the vanilla kernel on powerpc
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I noticed the following warnings while building the upstream kernel as of yesterday.
The commit I checked out at was cac7f2429872d3 : Linux 3.18-rc2.

Please verify if any of these can be fixed.

a. lib/cpumask.c: In function ‘cpumask_set_cpu_local_first’:
   lib/cpumask.c:194:25: warning: the address of ‘cpu_all_bits’ will always evaluate as ‘true’ [-Waddress]
  if (numa_node == -1 || !cpumask_of_node(numa_node)) {


b. drivers/infiniband/hw/ehca/ehca_mrmw.c: In function ‘ehca_set_pagebuf’:
   drivers/infiniband/hw/ehca/ehca_mrmw.c:1907:6: warning: ‘prev_pgaddr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (pgaddr - PAGE_SIZE != *prev_pgaddr) {
      ^
c. drivers/infiniband/hw/ehca/ehca_mrmw.c:1924:14: note: ‘prev_pgaddr’ was declared here
   u64 pgaddr, prev_pgaddr;
              ^
d. drivers/infiniband/hw/ehca/ehca_mrmw.c: In function ‘ehca_reg_mr’:
   drivers/infiniband/hw/ehca/ehca_mrmw.c:2430:5: warning: ‘hret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   if (hret == H_SUCCESS)
     ^
e. drivers/infiniband/hw/ehca/ehca_mrmw.c:2413:6: note: ‘hret’ was declared here
   u64 hret, *kpage;

f. drivers/net/ethernet/broadcom/tg3.c: In function ‘tg3_set_eeprom’:
    drivers/net/ethernet/broadcom/tg3.c:12059:10: warning: ‘start’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    memcpy(buf, &start, 4);

g.  drivers/net/ethernet/ibm/ehea/ehea_main.c:106:28: warning: ‘ehea_module_device_table’ defined but not used [-Wunused-variable]
    static struct of_device_id ehea_module_device_table[] = {


Thanks

Regards
Preeti U Murthy
