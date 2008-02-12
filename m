Return-Path: <haveblue@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C46E1DDF4B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 05:04:22 +1100 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1CI4JBK030316
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 13:04:19 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1CI4EEv2457820
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 13:04:15 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1CI45LM009866
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:04:05 -0700
Subject: Re: [PATCH] drivers/base: export gpl (un)register_memory_notifier
From: Dave Hansen <haveblue@us.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200802111724.12416.ossthema@de.ibm.com>
References: <200802111724.12416.ossthema@de.ibm.com>
Content-Type: text/plain
Date: Tue, 12 Feb 2008 10:04:09 -0800
Message-Id: <1202839449.11188.35.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Cc: "Themann, Jan-Bernd" <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <RAISCH@de.ibm.com>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-02-11 at 17:24 +0100, Jan-Bernd Themann wrote:
> Drivers like eHEA need memory notifiers in order to 
> update their internal DMA memory map when memory is added
> to or removed from the system.
> 
> Patch for eHEA memory hotplug support that uses these functions:
> http://www.spinics.net/lists/netdev/msg54484.html

This driver is broken pretty horribly.  It won't even compile for a
plain ppc64 kernel:

http://sr71.net/~dave/linux/ehea-is-broken.config

I know it's used for very specific hardware, but this is the symptom of
it not using the proper abstracted interfaces to the VM.

In file included from /home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_main.c:42:
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.h:44:14: warning: "SECTION_SIZE_BITS" is not defined
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.h:45:2: error: #error eHEA module cannot work if kernel sectionsize < ehea sectionsize
  CC      drivers/net/mii.o
make[4]: *** [drivers/net/ehea/ehea_main.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  CC      drivers/net/ixgb/ixgb_param.o
In file included from /home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:32:
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.h:44:14: warning: "SECTION_SIZE_BITS" is not defined
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.h:45:2: error: #error eHEA module cannot work if kernel sectionsize < ehea sectionsize
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c: In function 'ehea_create_busmap':
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:574: error: 'NR_MEM_SECTIONS' undeclared (first use in this function)
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:574: error: (Each undeclared identifier is reported only once
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:574: error: for each function it appears in.)
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:575: error: implicit declaration of function 'valid_section_nr'
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c: In function 'ehea_map_vaddr':
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:606: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c: In function 'ehea_reg_kernel_mr':
/home/dave/work/linux/2.6/23/linux-2.6.git/drivers/net/ehea/ehea_qmr.c:655: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)

-- Dave
