Return-Path: <schihei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5F557679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 03:40:40 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4FHeae1032474
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 17:40:36 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FHg2vT130326
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 19:42:02 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FHeZXV024922
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 19:40:35 +0200
Message-ID: <4468BD2D.5000103@de.ibm.com>
Date: Mon, 15 May 2006 19:41:01 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	schihei@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

many thanks for your comments. They are very helpful for us. All
17 patches have to be applied, otherwise the driver won't compile.

We would appreciate for any comments and feedbacks.

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
Changelog-by:  Heiko J Schick <schickhj@de.ibm.com>

Changelog:

Differences to PatchSet http://openib.org/pipermail/openib-general/2006-April/020584.html
Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/018144.html
Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/017412.html

- Linux kernel coding style
- Reduce number of parameters passed to firmware interface wrappers
- Remove ehca_kernel.h
- Remove implementation of plpar_hcall_7arg_7ret() and plpar_hcall_9arg_9ret(),
   which are now included in kernel code
- Remove simulation stub

  drivers/infiniband/hw/ehca/Kconfig                |    6
  drivers/infiniband/hw/ehca/Makefile               |   16
  drivers/infiniband/hw/ehca/ehca_av.c              |  306 ++
  drivers/infiniband/hw/ehca/ehca_classes.h         |  350 +++
  drivers/infiniband/hw/ehca/ehca_classes_pSeries.h |  251 ++
  drivers/infiniband/hw/ehca/ehca_cq.c              |  431 +++
  drivers/infiniband/hw/ehca/ehca_eq.c              |  222 +
  drivers/infiniband/hw/ehca/ehca_hca.c             |  282 ++
  drivers/infiniband/hw/ehca/ehca_irq.c             |  710 ++++++
  drivers/infiniband/hw/ehca/ehca_irq.h             |   77
  drivers/infiniband/hw/ehca/ehca_iverbs.h          |  181 +
  drivers/infiniband/hw/ehca/ehca_main.c            |  966 ++++++++
  drivers/infiniband/hw/ehca/ehca_mcast.c           |  194 +
  drivers/infiniband/hw/ehca/ehca_mrmw.c            | 2474 ++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_mrmw.h            |  143 +
  drivers/infiniband/hw/ehca/ehca_pd.c              |  118 +
  drivers/infiniband/hw/ehca/ehca_qes.h             |  274 ++
  drivers/infiniband/hw/ehca/ehca_qp.c              | 1565 +++++++++++++
  drivers/infiniband/hw/ehca/ehca_reqs.c            |  683 ++++++
  drivers/infiniband/hw/ehca/ehca_sqp.c             |  123 +
  drivers/infiniband/hw/ehca/ehca_tools.h           |  411 +++
  drivers/infiniband/hw/ehca/ehca_uverbs.c          |  391 +++
  drivers/infiniband/hw/ehca/hcp_if.c               | 1476 +++++++++++++
  drivers/infiniband/hw/ehca/hcp_if.h               |  330 ++
  drivers/infiniband/hw/ehca/hcp_phyp.c             |   92
  drivers/infiniband/hw/ehca/hcp_phyp.h             |   95
  drivers/infiniband/hw/ehca/hipz_fns.h             |   68
  drivers/infiniband/hw/ehca/hipz_fns_core.h        |  122 +
  drivers/infiniband/hw/ehca/hipz_hw.h              |  395 +++
  drivers/infiniband/hw/ehca/ipz_pt_fn.c            |  177 +
  drivers/infiniband/hw/ehca/ipz_pt_fn.h            |  254 ++
  31 files changed, 13183 insertions(+)
