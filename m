Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 73FECDE14D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 00:24:45 +1000 (EST)
Message-ID: <49F07A15.9010006@mlbassoc.com>
Date: Thu, 23 Apr 2009 08:24:21 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>	<49EE5021.4020703@mlbassoc.com>	<306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>	<49EE5A80.4030209@mlbassoc.com>
	<B869D8DC-2A3B-4B53-8BFD-15D403CE20D4@kernel.crashing.org>
In-Reply-To: <B869D8DC-2A3B-4B53-8BFD-15D403CE20D4@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------000604020806060603060703"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000604020806060603060703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> 
> On Apr 21, 2009, at 6:45 PM, Gary Thomas wrote:
> 
>> Kumar Gala wrote:
>>>
>>> On Apr 21, 2009, at 6:00 PM, Gary Thomas wrote:
>>>
>>>>
>>>> I found the difference - in 2.6.28 the inbound/outbound windows
>>>> don't seem to be set up at all.  In 2.6.26, the function
>>>> 'fsl_add_bridge'
>>>> was common among architectures and ended up calling 'setup_pci_atmu'
>>>> which created those mappings.  In 2.6.28, the 83xx PCI setup code
>>>> has been refactored.  It uses 'mpc83xx_add_bridge' instead of
>>>> 'fsl_add_bridge' and 'setup_pci_atmu' is not called at all :-(
>>>>
>>>> I'm sure this is the problem.
>>>
>>> Looking at a diff between 2.6.26 and .28 I don't see the 83xx pci code
>>> calling setup_pci_atmu().
>>
>> It did not directly; it called 'fsl_add_bridge' which in turn called
>> 'setup_pci_atmu'
> 
> Don't ever see 83xx boards calling fsl_add_bridge -- that is 85xx/86xx
> only in 83xx.

Sorry, you're correct.  I got lost looking through the code :-(
No matter, none of that code seems to be relevant to the change
in behaviour.

>> I modified the 2.6.28 driver to also call this function.  Now the
>> inbound/outbound windows are set up, but the bridge still has
>> no allocations, so the problem remains.
>>
>> I need to move on; I may just live with sliding the PCI space
>> up for now (doesn't really hurt anything, just seems like a hack)
> 
> It is and you are glossing over a real bug.

I have found the culprit - in arch/powerpc/kernel/pci_32.c

static void
fixup_hide_host_resource_fsl(struct pci_dev *dev)
{
	int i, class = dev->class >> 8;

#if 0
	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
	     class == PCI_CLASS_BRIDGE_OTHER) &&
#else
        if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
#endif
		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
		(dev->bus->parent == NULL)) {
		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
			dev->resource[i].start = 0;
			dev->resource[i].end = 0;
			dev->resource[i].flags = 0;
		}
	}
}
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MOTOROLA, PCI_ANY_ID, fixup_hide_host_resource_fsl);
DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, fixup_hide_host_resource_fsl);

This function is now (the #if 0 case is in 2.6.28) tossing out
the memory resources used by the PCI bridge itself.  This makes
everything fall over, at least on my 834x platform.

This change was applied 2008-10-08, but it seems incorrect on the 834x.

> Are you using u-boot to boot?  If so is the board port public?

My systems use RedBoot (I'm the original author of RedBoot, so one would
expect that).  At this moment, the code isn't public, sorry.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

--------------000604020806060603060703
Content-Type: message/rfc822;
 name="Attached Message"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Attached Message"

Return-Path: <linuxppc-dev-bounces+gary=mlbassoc.com@ozlabs.org>
X-Original-To: gary@mlbassoc.com
Delivered-To: gary@mlbassoc.com
Received: from localhost.localdomain [127.0.0.1]
	by hermes.chez-thomas.org with POP3 (fetchmail-6.3.8)
	for <gthomas@localhost> (single-drop); Tue, 07 Oct 2008 13:02:01 -0600 (MDT)
Received: by mail.chez-thomas.org (Postfix, from userid 999)
	id B4A9F3B5264B; Tue,  7 Oct 2008 13:01:30 -0600 (MDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00 autolearn=ham
	version=3.2.5
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by mail.chez-thomas.org (Postfix) with ESMTP id EFC1C3B52624
	for <gary@mlbassoc.com>; Tue,  7 Oct 2008 13:01:29 -0600 (MDT)
Received: from ozlabs.org (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 2F81FDE342
	for <gary@mlbassoc.com>; Wed,  8 Oct 2008 06:01:23 +1100 (EST)
X-Original-To: linuxppc-dev@ozlabs.org
Delivered-To: linuxppc-dev@ozlabs.org
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1139DE07C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 06:01:08 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m97J0cRZ004505
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2008 12:00:41 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-244.am.freescale.net
	[10.214.72.244])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m97J0Lci020784;
	Tue, 7 Oct 2008 14:00:23 -0500 (CDT)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc: pci: 5121: Hide pci bridge.
Date: Tue,  7 Oct 2008 13:00:20 -0600
Message-Id: <1223406020-12278-4-git-send-email-jrigby@freescale.com>
X-Mailer: git-send-email 1.5.6.2.255.gbed62
In-Reply-To: <1223406020-12278-3-git-send-email-jrigby@freescale.com>
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
	<1223406020-12278-2-git-send-email-jrigby@freescale.com>
	<1223406020-12278-3-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
X-BeenThere: linuxppc-dev@ozlabs.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linuxppc-dev-bounces+gary=mlbassoc.com@ozlabs.org
Errors-To: linuxppc-dev-bounces+gary=mlbassoc.com@ozlabs.org

The class of the MPC5121 pci host bridge is PCI_CLASS_BRIDGE_OTHER
while other freescale host bridges have class set to
PCI_CLASS_PROCESSOR_POWERPC.

This patch makes fixup_hide_host_resource_fsl match
PCI_CLASS_BRIDGE_OTHER in addition to PCI_CLASS_PROCESSOR_POWERPC.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/kernel/pci_32.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 174b77e..a848c63 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -54,11 +54,12 @@ LIST_HEAD(hose_list);
 static int pci_bus_count;
 
 static void
-fixup_hide_host_resource_fsl(struct pci_dev* dev)
+fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
 	int i, class = dev->class >> 8;
 
-	if ((class == PCI_CLASS_PROCESSOR_POWERPC) &&
+	if ((class == PCI_CLASS_PROCESSOR_POWERPC ||
+	     class == PCI_CLASS_BRIDGE_OTHER) &&
 		(dev->hdr_type == PCI_HEADER_TYPE_NORMAL) &&
 		(dev->bus->parent == NULL)) {
 		for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
-- 
1.5.6.2.255.gbed62

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

--------------000604020806060603060703--
