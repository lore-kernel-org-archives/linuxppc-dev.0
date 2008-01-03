Return-Path: <mgreer@mvista.com>
Date: Thu, 3 Jan 2008 08:40:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH v2] powerpc: #address-cells & #size-cells properties not
	inherited
Message-ID: <20080103154047.GB18716@mag.az.mvista.com>
References: <20080103000750.GA22035@mag.az.mvista.com>
	<20080102194640.48c97d0c@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080102194640.48c97d0c@vader.jdub.homelinux.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Fix error in booting-without-of.txt that indicates that a node can inherit
its #address-cells and #size-cells definitions from its parent's parent.
This is not correct.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 Documentation/powerpc/booting-without-of.txt |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index ee0209a..58db5ea 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -671,10 +671,10 @@ device or bus to be described by the device tree.
 
 In general, the format of an address for a device is defined by the
 parent bus type, based on the #address-cells and #size-cells
-property. In the absence of such a property, the parent's parent
-values are used, etc... The kernel requires the root node to have
-those properties defining addresses format for devices directly mapped
-on the processor bus.
+properties.  Note that the parent's parent definitions of #address-cells
+and #size-cells are not inhereted so every node with children must specify
+them.  The kernel requires the root node to have those properties defining
+addresses format for devices directly mapped on the processor bus.
 
 Those 2 properties define 'cells' for representing an address and a
 size. A "cell" is a 32-bit number. For example, if both contain 2
