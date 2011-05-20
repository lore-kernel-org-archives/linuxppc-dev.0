Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] powerpc: define and implement MPIC message register
	support
Date: Fri, 20 May 2011 11:36:37 -0500
Message-Id: <1305909399-26969-1-git-send-email-meador_inge@mentor.com>
Cc: openmcapi-dev@googlegroups.com, devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set defines a binding for FSL MPIC message registers and implements
an API for accessing those message registers.  Testing was done on a MPC8572DS
in an Linux-Linux AMP setup using OpenMCAPI (www.openmcapi.org) to communicate
between OS instances.  The message register API is used by the OpenMCAPI shared 
memory driver to send notifications between cores.

* v2 - Incorporate feedback from Scott Wood
   * Make binding less implementation specific.
   * Add 'mpic-' prefix to message register node properties and aliases.
   * Remove 'interrupt-parent' from binding.
   * Fixed some example bugs with receive masks.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>

Meador Inge (2):
  powerpc: document the FSL MPIC message register binding
  powerpc: add support for MPIC message register API

 .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 +++++
 arch/powerpc/include/asm/mpic_msgr.h               |   35 +++
 arch/powerpc/platforms/Kconfig                     |    8 +
 arch/powerpc/sysdev/Makefile                       |    3 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |  279 ++++++++++++++++++++
 5 files changed, 386 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
 create mode 100644 arch/powerpc/include/asm/mpic_msgr.h
 create mode 100644 arch/powerpc/sysdev/mpic_msgr.c
