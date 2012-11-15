Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7B5A72C0491
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2012 04:58:41 +1100 (EST)
Received: by mail-wi0-f180.google.com with SMTP id x18so1128031wia.3
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 09:58:38 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PROBLEM: Linux 3.6.2 fails to boot on IBM Cell
To: Dennis Schridde <devurandom@gmx.net>
In-Reply-To: <1573571.I7ElC3JheV@ernie>
References: <5521875.6lkx8Qvfk5@ernie>
 <CACxGe6t103JQ8mY1Q0nZBrEPW9+MH3oB49gatEEd2UCj7=XrUg@mail.gmail.com>
 <6566742.NTPeeo2QHT@ernie> <1573571.I7ElC3JheV@ernie>
Date: Thu, 15 Nov 2012 17:58:35 +0000
Message-Id: <20121115175835.652C43E197F@localhost>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Oct 2012 21:33:41 +0200, Dennis Schridde <devurandom@gmx.net> wrote:
> Hello everyone!
> 
> Am Freitag, 19. Oktober 2012, 09:04:08 schrieb Dennis Schridde:
> > Am Freitag, 19. Oktober 2012, 00:17:55 schrieb Grant Likely:
> > > What does the boot log look like with the attached patch? (compiled
> > > only, I haven't booted with it)
> > 
> > Please find the log attached.
> Have you found the cause or a fix for the problem?

Umm, no. Some suggestions were made so I assumed you'd try those.

Anyway, here is a real patch. Try this:

g.

diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 59c1a16..348a27b 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -382,7 +382,7 @@ static int __init cbe_init_pm_irq(void)
 	unsigned int irq;
 	int rc, node;
 
-	for_each_node(node) {
+	for_each_online_node(node) {
 		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
 					       (node << IIC_IRQ_NODE_SHIFT));
 		if (irq == NO_IRQ) {
