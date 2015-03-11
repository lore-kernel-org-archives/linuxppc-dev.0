Return-Path: <thuth@linux.vnet.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE68E1A0701
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 19:30:19 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <thuth@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 08:30:15 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 228052190046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 08:30:04 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B8UCBI5898552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 08:30:13 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B8UBiE011242
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 02:30:12 -0600
Date: Wed, 11 Mar 2015 09:30:09 +0100
From: Thomas Huth <thuth@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH SLOF] pci-properties: Remove redundant call to device-type
Message-ID: <20150311093009.7c06d26d@oc7435384737.ibm.com>
In-Reply-To: <1426062062.17565.22.camel@kernel.crashing.org>
References: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
 <20150311085030.43ac4fac@oc7435384737.ibm.com>
 <1426062062.17565.22.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 Mar 2015 19:21:02 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2015-03-11 at 08:50 +0100, Thomas Huth wrote:
> > 
> > - Graphic cards should get the "display" device_type ... I guess
> > that's
> >   missing now?
> 
> At least the code for qemu-vga does it

Ah, right, I was only grep'ing for "device-type" (with "-" instead of
"_", the Forth word to set the property), that's why I didn't notice
it ... the code in board-qemu sets the property directly instead.
And so does the code in board-js2x, so this should be fine.

> > - pci bus nodes (like bridges) should get the "pci" device_type
> >   according to the Open Firmware PCI binding, is this still the case?
> 
> Ah yes we need to check that, specifically P2P bridges

There seems to be some code in pci-bridge-generic-setup at last ...
Might be still worth checking this on a real running system, but at a
first glance it looks ok.

> > - Seems like there are some other devices with device_type property
> >   where SLOF does not provide an implemented interface, like in
> >   slof/fs/usb/dev-mouse.fs ... should these be revised, too?
> 
> not a *huge* issue but we can look into it when needed.

Right.

So the patch sounds now fine to me as it is.

 Thomas
