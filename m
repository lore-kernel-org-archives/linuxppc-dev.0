Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 685CBB6FB0
	for <linuxppc-dev@ozlabs.org>; Mon, 23 May 2011 19:21:45 +1000 (EST)
Message-ID: <4DDA2509.6070702@matrix-vision.de>
Date: Mon, 23 May 2011 11:12:41 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: PCI DMA to user mem on mpc83xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira,

we have a pretty old PCI device driver here that needs some basic rework 
running on 2.6.27 on several MPC83xx.
It's a simple char-device with "give me some data" implemented using 
read() resulting in zero-copy DMA to user mem.

There's get_user_pages() working under the hood along with 
SetPageDirty() and page_cache_release().

Main goal is to prepare a sg-list that gets fed into a DMA controller.

I wonder if there's a more up-to-date/efficient and future proof scheme 
of creating the mapping.


Could you provide some pointers or would you stick to the current scheme ?


Regards,
André

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
