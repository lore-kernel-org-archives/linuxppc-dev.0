Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 0/3] powerpc: Open PIC binding and "pic-no-reset"
Date: Mon, 14 Mar 2011 15:01:04 -0500
Message-Id: <1300132867-4840-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set provides a binding for Open PIC and implements support for
a new property, specified by that binding, called "pic-no-reset".

v5 - Moved the Open PIC binding to its rightful home of
     ".../Documentation/devicetree/bindings/".  Also, fixed up
     the lazy reset code to take better advantage of existing
     functions.  Finally, did some minor refactoring to put
     cpu id fetching in its own helper function.

v4 - Per Ben's feedback the protected sources implementation was left
     completely intact.  As such, the DTS cleanup and "protected-sources"
     removal patches were dropped.

v3 - the Open PIC binding was changed to be more consistent with existing
     bindings, several DTS files were cleaned up, "no-reset" was changed to
     "pic-no-reset", and a check to treat "protected-sources" as a synonym for
     "pic-no-reset" was added.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>

Meador Inge (3):
  powerpc: document the Open PIC device tree binding
  powerpc: make MPIC honor the "pic-no-reset" device tree property
  powerpc: factoring mpic cpu id fetching into a function

 Documentation/devicetree/bindings/open-pic.txt |   98 ++++++++++++++++++++++++
 arch/powerpc/include/asm/mpic.h                |    4 +
 arch/powerpc/sysdev/mpic.c                     |   85 +++++++++++++++-----
 3 files changed, 165 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/open-pic.txt
