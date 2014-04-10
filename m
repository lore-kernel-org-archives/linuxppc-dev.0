Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-f170.google.com (mail-ig0-f170.google.com
 [209.85.213.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9A67514007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 01:27:36 +1000 (EST)
Received: by mail-ig0-f170.google.com with SMTP id uq10so927386igb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 08:27:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
References: <1397112695-3945-1-git-send-email-qiudayu@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 10 Apr 2014 09:27:12 -0600
Message-ID: <CAErSpo6U7W+Nph3kCOBXcBTN7SeR9pVc5cfdQKTBDedWNnV8jg@mail.gmail.com>
Subject: Re: [PATCH] Fix 3bc95598 'powerpc/PCI: Use list_for_each_entry() for
 bus traversal'
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Yijing Wang <wangyijing@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, anton@samba.org,
 "paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 10, 2014 at 12:51 AM, Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000041d78
> Oops: Kernel access of bad area, sig: 11 [#1]
> ...
> NIP [c000000000041d78] .sys_pciconfig_iobase+0x68/0x1f0
> LR [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0
> Call Trace:
> [c0000003b4787db0] [c000000000041e0c] .sys_pciconfig_iobase+0xfc/0x1f0 (unreliable)
> [c0000003b4787e30] [c000000000009ed8] syscall_exit+0x0/0x98
>
> This bug was introduced by commit 3bc955987fb377f3c95bc29deb498e96819b8451
> The root cause was the 'bus' has been set to null while try to access
> bus->next.
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci_64.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 2a47790..7b6c1ae 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -209,6 +209,7 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>  {
>         struct pci_controller* hose;
>         struct pci_bus *bus = NULL;
> +       struct pci_bus *tmp_bus = NULL;
>         struct device_node *hose_node;
>
>         /* Argh ! Please forgive me for that hack, but that's the
> @@ -229,10 +230,12 @@ long sys_pciconfig_iobase(long which, unsigned long in_bus,
>          * used on pre-domains setup. We return the first match
>          */
>
> -       list_for_each_entry(bus, &pci_root_buses, node) {
> -               if (in_bus >= bus->number && in_bus <= bus->busn_res.end)
> +       list_for_each_entry(tmp_bus, &pci_root_buses, node) {
> +               if (in_bus >= tmp_bus->number &&
> +                   in_bus <= tmp_bus->busn_res.end) {
> +                       bus = tmp_bus;
>                         break;
> -               bus = NULL;
> +               }

Good fix, thanks.  Sorry we didn't catch it before you tripped over
it.  Your code is much cleaner than the previous "clear out 'bus' if
we didn't match" style.

Nit: I don't think you need to initialize tmp_bus to NULL.

Ben, I'll pick this up for v3.15 since the original change
(3bc955987fb3) went through my tree, unless you want to handle it.

Bjorn

>         }
>         if (bus == NULL || bus->dev.of_node == NULL)
>                 return -ENODEV;
> --
> 1.8.0.1
>
