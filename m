Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 75644DE3AB
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 07:31:00 +1100 (EST)
Date: Thu, 21 Feb 2008 23:30:58 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [USB POWERPC] ehci-fsl: add PPC_MPC837x to default y
Message-ID: <20080221203058.GA18624@localhost.localdomain>
References: <20080221195021.GC12896@localhost.localdomain>
	<9AD13D2E-B57F-4F19-B89C-C8A83157E0F2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <9AD13D2E-B57F-4F19-B89C-C8A83157E0F2@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2008 at 01:58:18PM -0600, Kumar Gala wrote:
> 
> On Feb 21, 2008, at 1:50 PM, Anton Vorontsov wrote:
> 
> >Without this patch it's impossible to select ehci-fsl on PPC_MPC837x.
> >Another option would be to convert USB_EHCI_FSL to verbose bool,
> >but I presume EHCI_FSL is purposely made silent.
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> >---
> >drivers/usb/host/Kconfig |    2 +-
> >1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> >index d97b16b..33da056 100644
> >--- a/drivers/usb/host/Kconfig
> >+++ b/drivers/usb/host/Kconfig
> >@@ -72,7 +72,7 @@ config USB_EHCI_FSL
> >	bool
> >	depends on USB_EHCI_HCD
> >	select USB_EHCI_ROOT_HUB_TT
> >-	default y if MPC834x || PPC_MPC831x
> >+	default y if MPC834x || PPC_MPC831x || PPC_MPC837x
> 
> Can we just change this to FSL_SOC

Easily. But not "default y"... "depends on" instead, ok?
There are plenty of FSL chips without EHCI built-in, so with
default y we'll enable it wrongly.

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [USB POWERPC] ehci-fsl: handles other freescale processors

This patch converts USB_EHCI_FSL config option into the verbose
bool, so we'll able to select it for other freescale processors
with built-in EHCI controller.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/usb/host/Kconfig |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d97b16b..bf8be2a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -69,10 +69,9 @@ config USB_EHCI_BIG_ENDIAN_DESC
 	default y
 
 config USB_EHCI_FSL
-	bool
-	depends on USB_EHCI_HCD
+	bool "Support for Freescale on-chip EHCI USB controller"
+	depends on USB_EHCI_HCD && FSL_SOC
 	select USB_EHCI_ROOT_HUB_TT
-	default y if MPC834x || PPC_MPC831x
 	---help---
 	  Variation of ARC USB block used in some Freescale chips.
 
-- 
1.5.2.2
