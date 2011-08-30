Return-Path: <pratyush.anand@st.com>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B33C5B6F97
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Aug 2011 22:26:41 +1000 (EST)
From: Pratyush Anand <pratyush.anand@st.com>
To: <linux-usb@vger.kernel.org>
Subject: [PATCH 00/14] Modifications for DWC OTG since v13
Date: Tue, 30 Aug 2011 17:27:47 +0530
Message-ID: <cover.1314704557.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Pratyush Anand <pratyush.anand@st.com>, viresh.kumar@st.com,
	vipulkumar.samar@st.com, bhupesh.sharma@st.com, tmarri@apm.com,
	vipin.kumar@st.com, shiraz.hashim@st.com, Amit.VIRDI@st.com,
	rajeev-dlh.kumar@st.com, mmiesfeld@apm.com, deepak.sikri@st.com,
	linuxppc-dev@lists.ozlabs.org, fchen@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches are based on:http://patchwork.ozlabs.org/patch/89560/
After not getting any reply from developers, I started to do
modifications for my platform (SPEAr1340).
I have done modifications in such a way that all the code in 
driver/usb/dwc/ would be platform independent.
I have tested this code for host/device/dma/slave mode.
My fifo configuration is dedicated and dynamic.

Changes since v13:

1. All the patches has been renamed from usb/ppc4xx to dwc/otg. Changes
   has been done, because these files are valid for other architecture
   also.
2. Parameter passing mechanism has been modified. Now, driver can also
   receive parameters from a platform device.
3. Next request is started after clear halt for all slave transfer
    There might be a situation, when there are data into fifo, EP is
    receiving IN token, but EP is disabled. In this case, EP will just
    stop and do nothing.  So, for each transfer type start_next_request
    is enabled.
4. Dynamic fifo was configured by reading number of endpoints. Number
   of endpoints can be different than the number of dynamic fifo in the
   controller. Number of dynamic fifo is programmed in fifo_number
   parameter. Program fifos only for fifo_number of fifo.
5.  If platform specific functions like phy_init and param_init is
    defined then call it.
6.  Few define which are used for TX, were defined as RX in the code.
    All such definition has been replaced throughout the code.
7. There are some defined steps to disable an endpoint.  It can not be
   disabled just by setting epdisable bit.  Now, it is disabled as
   specification says.
    
    During stall of and endpoint, first stall bit should be set and then
    endpoint should be disabled.
    
    In dwc_otg_pcd_ep_disable, TX fifo must be flushed along with
    disabling of endpoint.
    
    In DMA mode if Fifo is flushed only once then, DMA will write data
    into it again. So, it must be flushed till DMA transfer is complete.
8. dwc_otg_ep_deactivate is called after dwc_otg_ep_disable.
9. platform_get_irq return -ENXIO , if requested IRQ is not found.  So,
   return must be checked accordingly.
    
10.  There is a struct (core_params) for all possible variable
     parameters of OTG.  Earlier, these parameters were not modifiable
     for any platform data. It was reading from the HW and then was
     programming the same value again.
    
    Now, it has been modified. A platform code can modify these
    parameters.
    
    Struct definition has been moved from cil.h to a new file
    include/linux/usb/dwc_otg.h.
    
    Some of the parameters have been initialized with default values,
    while other with -1.
    
    A new parameter fifo_number has been added. This parameter is also
    defined in the specification. Otg code was reading number of
    endpoint from hwcfg regs for the purpose of this parameter, which
    was wrong.
    
    SW checks for only fifo_number fifos and not MAX_TX_FIFOS.
    
    Now , there is only one define for MAX_TX_FIFO and MAX_PERIO_FIFOS.
    As, per specification they can not be different.
11. In dwc_otg_pcd_handle_np_tx_fifo_empty_intr a different interrupt
    was cleared. Corrected it to clear NP TX Fifo empty interrupt.
    
    Re-enabling of interrupt was not correct when packets were still
    pending. This patch also corrects this behaviour.
12. Code checks for space availability in fifo during
    write_epmty_tx_fifo.  It was writing only when space available was
    more than data to be written. So, it was writing 512 bytes only when
    516 bytes space was available.  Modified condition check from > to
	>=.
13.  When TX fifo empty interrupt is received, transfer completion may
     not be true. Next transfer should only be started when transfer is
     complete, i.e. packet count in dieptsiz register has become zero.
14.  Max number of EP increased to 16
15. There can be few devices like SPEAr1340, which issues a connection
    only after removal of soft disconnect. Default reset value is
    disconnected.  It will not have any side effect even for the device
    where reset value is connected.
16.  As per data sheet, when bit 31 of GRSTCTL is 1 then AHB is IDLE.
     Earlier function was waiting for this but to be 0, which was wrong.
17. Although name of file suggest that it is specific for PPC.  But, all
    of its content are common for OTG and can be used for any platform.
    There were some compilation issued on ARM platform with this file.
    It has been removed by calling by proper functions.



Pratyush Anand (4):
  dwc/otg: Structure declaration for shared data
  include/linux/usb/gadget.h : include <linux/device.h> for successful
    compilation
  usb/gadget/kconfig: added dwc otg as an option for peripheral
    controller
  arm/include/asm/io.h : added macros to read/write big/little endian
    register

Tirumala Marri (10):
  dwc/otg: Add Register definitions
  dwc/otg: Add driver framework
  dwc/otg: Add Core Interface Layer (CIL)
  dwc/otg: Add HCD function
  dwc/otg: Add HCD interrupt function
  dwc/otg: Add HCD queue function
  dwc/otg: Add PCD function
  dwc/otg: Add PCD interrupt function
  dwc/otg: Add driver kernel configuration and Makefile
  dwc/otg: Driver enable gadget support

 arch/arm/include/asm/io.h         |    8 +
 drivers/Makefile                  |    1 +
 drivers/usb/Kconfig               |    2 +
 drivers/usb/dwc/Kconfig           |   84 ++
 drivers/usb/dwc/Makefile          |   19 +
 drivers/usb/dwc/apmppc.c          |  436 +++++++
 drivers/usb/dwc/cil.c             |  969 +++++++++++++++
 drivers/usb/dwc/cil.h             |  921 ++++++++++++++
 drivers/usb/dwc/cil_intr.c        |  616 +++++++++
 drivers/usb/dwc/driver.h          |   76 ++
 drivers/usb/dwc/hcd.c             | 2465 +++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc/hcd.h             |  416 +++++++
 drivers/usb/dwc/hcd_intr.c        | 1481 ++++++++++++++++++++++
 drivers/usb/dwc/hcd_queue.c       |  696 +++++++++++
 drivers/usb/dwc/param.c           |  219 ++++
 drivers/usb/dwc/pcd.c             | 1818 +++++++++++++++++++++++++++
 drivers/usb/dwc/pcd.h             |  139 +++
 drivers/usb/dwc/pcd_intr.c        | 2316 ++++++++++++++++++++++++++++++++++
 drivers/usb/dwc/regs.h            | 1324 ++++++++++++++++++++
 drivers/usb/gadget/Kconfig        |   17 +
 drivers/usb/gadget/gadget_chips.h |   18 +-
 include/linux/usb/dwc_otg.h       |  274 ++++
 include/linux/usb/gadget.h        |    1 +
 23 files changed, 14315 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/dwc/Kconfig
 create mode 100644 drivers/usb/dwc/Makefile
 create mode 100644 drivers/usb/dwc/apmppc.c
 create mode 100644 drivers/usb/dwc/cil.c
 create mode 100644 drivers/usb/dwc/cil.h
 create mode 100644 drivers/usb/dwc/cil_intr.c
 create mode 100644 drivers/usb/dwc/driver.h
 create mode 100644 drivers/usb/dwc/hcd.c
 create mode 100644 drivers/usb/dwc/hcd.h
 create mode 100644 drivers/usb/dwc/hcd_intr.c
 create mode 100644 drivers/usb/dwc/hcd_queue.c
 create mode 100644 drivers/usb/dwc/param.c
 create mode 100644 drivers/usb/dwc/pcd.c
 create mode 100644 drivers/usb/dwc/pcd.h
 create mode 100644 drivers/usb/dwc/pcd_intr.c
 create mode 100644 drivers/usb/dwc/regs.h
 create mode 100644 include/linux/usb/dwc_otg.h

-- 
1.7.2.2
