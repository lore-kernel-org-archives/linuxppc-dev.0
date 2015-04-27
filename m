Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF7571A017B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 20:15:00 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3888B140082
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 20:15:00 +1000 (AEST)
Date: Mon, 27 Apr 2015 12:14:43 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 4/4] pci: Use QEMU created PCI device nodes
Message-ID: <20150427121443.0d125901@thh440s>
In-Reply-To: <87y4ldc2tr.fsf@abhimanyu.in.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-5-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150427103816.4ce59f10@thh440s>
 <87y4ldc2tr.fsf@abhimanyu.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Apr 2015 15:26:00 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> Thomas Huth <thuth@redhat.com> writes:
> 
> > On Mon, 27 Apr 2015 13:32:33 +0530
> > Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> >
> >> PCI Enumeration has been part of SLOF. Now with hotplug code addition
> >> in QEMU, it makes more sense to have this code in one place,
> >> i.e. QEMU.
> >> 
> >> Adding routines to walk through the device nodes created by QEMU. SLOF
> >> will now configure the device/bridges and program the BARs for
> >> communicating with the devices.
> >> 
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> ---
> >>  board-qemu/slof/pci-phb.fs | 44 +++++++++++++++++++++++++++++++++++++++++++-
> >>  slof/fs/pci-properties.fs  |  6 +++++-
> >>  2 files changed, 48 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
> >> index 529772f..a8fb7ca 100644
> >> --- a/board-qemu/slof/pci-phb.fs
> >> +++ b/board-qemu/slof/pci-phb.fs
> >> @@ -282,6 +282,41 @@ setup-puid
> >>     THEN
> >>  ;
> >>  
> >> +: phb-pci-walk-bridge ( -- )
> >> +    phb-debug? IF ."   Calling pci-walk-bridge " pwd cr THEN
> >> +
> >> +    get-node child ?dup 0= IF EXIT THEN    \ get and check if we have children
> >> +    0 to pci-device-slots                  \ reset slot array to unpoppulated
> >> +    BEGIN
> >> +        dup                                \ Continue as long as there are children
> >> +    WHILE
> >> +        dup set-node                       \ Set child node as current node
> >> +        my-space pci-set-slot              \ set the slot bit
> >> +        my-space pci-htype@                \ read HEADER-Type
> >> +        7f and                             \ Mask bit 7 - multifunction device
> >> +        CASE
> >> +            0 OF my-space pci-device-setup ENDOF  \ | set up the device
> >> +            1 OF my-space pci-bridge-setup ENDOF  \ | set up the bridge
> >> +            dup OF my-space pci-htype@ pci-out ENDOF
> >> +        ENDCASE
> >> +        peer
> >> +    REPEAT drop
> >> +    get-parent set-node
> >> +;
> >> +
> >> +\ Landing routing to probe the popuated device tree
> >> +: phb-pci-probe-bus ( busnr -- )
> >> +    drop phb-pci-walk-bridge
> >> +;
> >> +
> >> +\ Stub routine, as qemu has enumerated, we already have the device
> >> +\ properties set.
> >> +: phb-pci-device-props ( addr -- )
> >> +    dup pci-class-name device-name
> >> +    dup pci-device-assigned-addresses-prop
> >> +    drop
> >> +;
> >> +
> >>  \ Scan the child nodes of the pci root node to assign bars, fixup
> >>  \ properties etc.
> >>  : phb-setup-children
> >> @@ -289,7 +324,14 @@ setup-puid
> >>     my-puid TO puid                  \ Set current puid
> >>     phb-parse-ranges
> >>     1 TO pci-hotplug-enabled
> >> -   1 0 (probe-pci-host-bridge)
> >> +   s" qemu,phb-enumerated" get-node get-property 0<> IF
> >
> > I think you could simply omit the "0<>" in the above line (get-property
> > returns TRUE if the property has not been found and FALSE if it has
> > been found, so the topmost stack item is already suitable for the IF
> > statement)
> 
> I find the usage of get-property a bit odd, as it returns TRUE when it
> is not found. So have put " != 0"  as the condition, which I felt as more
> intuitive.
> 
> If you don't feel strongly about it, I will like to have it this way.

That's fine for me, too.

 Thomas
