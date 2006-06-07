Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C780C67BB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 23:49:29 +1000 (EST)
Date: Wed, 7 Jun 2006 17:49:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM_UART should allocate DPRAM for SMCx parameter RAM on MPC82xx
Message-ID: <20060607174931.766eda5d@vitb.ru.mvista.com>
In-Reply-To: <200606071539.57394.laurent.pinchart@tbox.biz>
References: <200606071434.08905.laurent.pinchart@tbox.biz>
	<20060607173107.53d0ef59@vitb.ru.mvista.com>
	<200606071539.57394.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 7 Jun 2006 15:39:57 +0200
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> > > the move to platform devices introduced a bug in the CPM_UART SMC driver.
> > >
> > > Unlike SCC and FCC, the SMC parameter ram is not at a fixed location. A
> > > pointer to the parameter ram is instead stored at PROFF_SMCx_BASE.
> > >
> > > The SMC platform device resources (in arch/ppc/syslib/pq2_devices.c)
> > > reserves the memory resource PROFF_SMCx_BASE - PROFF_SMCx_BASE+1. The CPM
> > > UART driver considers that value as the SMC parameter ram offset. It
> > > should instead allocate 64 bytes (on a 64 bytes boundary) of DPRAM for
> > > its parameter ram, and store the offset at PROFF_SMCx_BASE.
> > >
> > > I'm not sure how to fix the problem as it seems that the platform device
> > > support is not complete yet (cpm_uart_init_portdesc is still used to
> > > initialize the console). A possible workaround is to set the pram
> > > resource to 0x0000-0x003f and 0x0040-0x007f instead of 0x87fc-0x87fd and
> > > 0x88fc-0x88fd for SMC1 and SMC2. This will not work if
> > > cpm_uart_init_portdesc is not called.
> >
> > No, pdev support for cpm uart is complete and works for every board I have
> > handy, both 8xx and 82xx. 8xx use SMC stuff and are ok, so I suppose the
> > issue got inside because this is first case we head with combination of
> > pq2/smc.
> >
> > init_portedsc is called in compatibility mode only, when driver was
> > unable to locate platform device (early_uart_get_pdev call). The
> > offsets are definitely odd - we should count the proper values (as it
> > was done for 8xx - offset from immr where pram will be located that
> > is). So, pq2_devices should be fixed, as well as bsp code should
> > provide early_uart_get_pdev call (see 8272 as reference).
> 
> From my understanding, SMC pram should be allocated, and its offset should be 
> stored at PROFF_SMCx_BASE. pq2_devices returns the PRFF_SMCx_BASE resource, 
> and the CPM UART driver should use cpm_dpalloc to allocate the parameter RAM. 
> Is that right ? If so, where should I allocate memory (and where should I 
> free it) in the CPM UART driver ?
> 
As I said, SMC offsets relative to pram things are screwed for PQ2.
That needs to be fixed. It is assumed, that for each SMC ready-for-use offset should be defined in pram resource (as for 8xx). There is no need to dpalloc/dpfree because the idea is that pram thing should be fixed to prevent confusion. So the odd offset for SMC devices in pq2_devices.c should be replaced with correct values (which should be dpram_start+PROFF_SMCx - have a look at 8xx as reference)

-- 
Sincerely, 
Vitaly
