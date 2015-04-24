Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF15E1A0C9F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 05:31:12 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8C0D11402DA
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2015 05:31:12 +1000 (AEST)
Date: Fri, 24 Apr 2015 21:30:58 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] pci: Use Qemu created PCI device nodes
Message-ID: <20150424213058.2889af29@thh440s>
In-Reply-To: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1429700240-32373-2-git-send-email-nikunj@linux.vnet.ibm.com>
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


 Hi Nikunj,

On Wed, 22 Apr 2015 16:27:20 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> PCI Enumeration has been part of SLOF. Now with hotplug code addition
> in Qemu, it makes more sense to have this code a one place, i.e. Qemu.

s/Qemu/QEMU/ and s/code a one place/code in one place/ ?

> Adding routines to walk through the device nodes created by Qemu. SLOF
> will configure the device/bridges and program the BARs for
> communicating with the devices.

I wonder whether it would make more sense to also set up the BARs etc.
in QEMU instead of SLOF?

> 
> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
> index e307d95..30b7443 100644
> --- a/board-qemu/slof/pci-phb.fs
> +++ b/board-qemu/slof/pci-phb.fs
> @@ -283,6 +283,41 @@ setup-puid
>     THEN
>  ;
>  
> +: phb-pci-walk-bridge ( -- )
> +    phb-debug? IF ."   Calling pci-walk-bridge " pwd cr THEN
> +
> +    get-node child ?dup 0= IF EXIT THEN    \ get and check if we have children
> +    BEGIN
> +        dup                           \ Continue as long as there are children
> +    WHILE

Most Forth code uses the same indentation for the code between
BEGIN...WHILE and WHILE...REPEAT ... so I think you could decrease the
indentation of the following block by one level.

> +            \ Set child node as current node:
> +            dup set-node

Below you are calling pci-device-setup which in turn might include some
pci-class_*.fs or pci-device_*.fs files (or even run some FCODE?). At
least pci-class_02.fs seems to use an INSTANCE VARIABLE, i.e. the
instance template should get modified in that case ==> Please
double-check whether you need to use extend-device here instead (I'm
not 100% sure right now ... what happens
for example when you run qemu with a network device that SLOF does not
provide a pci-device_*.fs for? I guess it will try to include
pci-class_02.fs and fail due to the INSTANCE VARIABLE ?)

> +            my-space pci-set-slot       \ set the slot bit

pci-set-slot seems to rely on the pci-device-slots global variable.
This is normally initialized by pci-probe-bus. Now that you provide
your own implementation of that function below, I think it should
likely also set up the pci-device-slots variable, shouldn't it?

> +            my-space pci-htype@         \ read HEADER-Type
> +            7f and                      \ Mask bit 7 - multifunction device
> +            CASE
> +               0 OF my-space pci-device-setup ENDOF  \ | set up the device
> +               1 OF my-space pci-bridge-setup ENDOF  \ | set up the bridge
> +               dup OF my-space pci-htype@ pci-out ENDOF
> +           ENDCASE
> +           peer
> +    REPEAT drop
> +    get-parent set-node
> +;

The remaining part of the patch looks ok to me.

 Thomas
