Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 00/14] powerpc: Add support for POWER8 relocation on exceptions
Date: Fri,  9 Nov 2012 17:18:58 +1100
Message-Id: <1352441953-29096-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches adds support for taking exceptions with the MMU on which is
supported by POWER8.

A new set of exception vectors is added at 0xc000_0000_0000_4xxx.  When the HW
takes us here, MSR IR/DR will be set already and we no longer need a costly
RFID to turn the MMU back on again.

The original 0x0 based exception vectors remain for when the HW can't leave the
MMU on.  Examples of this are when we can't trust the current the MMU mappings,
like when we are changing from guest to hypervisor (HV 0 -> 1) or when the MMU
was off already.  In these cases the HW will take us to the original 0x0 based
exception vectors with the MMU off as before.

The core of these patches were originally written by Matt Evans.  

Ian Munsie (5):
  powerpc: Add set_mode hcall
  powerpc: Add wrappers to enable/disable relocation on exceptions
  powerpc: Move get_longbusy_msecs into hvcall.h and remove duplicate
    function
  powerpc: Enable relocation on during exceptions at boot
  powerpc: Disable relocation on exceptions when kexecing

Michael Neuling (9):
  powerpc: Add POWER8 architected mode to cputable
  powerpc: Whitespace changes in exception64s.S
  powerpc: Remove unessessary 0x3000 location enforcement
  powerpc: Make load_hander handle upto 64k offset
  powerpc: Turn syscall handler into macros
  powerpc: Add new macros needed for relocation on exceptions
  powerpc: Add relocation on exception vector handlers
  powerpc: Move initial mfspr LPCR out of __init_LPCR
  powerpc: Setup relocation on exceptions for bare metal systems

 arch/powerpc/include/asm/exception-64s.h        |   97 ++++++-
 arch/powerpc/include/asm/firmware.h             |    4 +-
 arch/powerpc/include/asm/hvcall.h               |   23 +-
 arch/powerpc/include/asm/reg.h                  |    2 +
 arch/powerpc/kernel/cpu_setup_power.S           |    8 +-
 arch/powerpc/kernel/cputable.c                  |   15 ++
 arch/powerpc/kernel/exceptions-64s.S            |  306 +++++++++++++++++++----
 arch/powerpc/kernel/head_64.S                   |    3 +-
 arch/powerpc/kernel/setup_64.c                  |    5 +
 arch/powerpc/platforms/pseries/firmware.c       |    1 +
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   36 +++
 arch/powerpc/platforms/pseries/setup.c          |   71 ++++++
 drivers/infiniband/hw/ehca/hcp_if.c             |   20 --
 drivers/net/ethernet/ibm/ehea/ehea_phyp.h       |   20 --
 14 files changed, 516 insertions(+), 95 deletions(-)

-- 
1.7.9.5
