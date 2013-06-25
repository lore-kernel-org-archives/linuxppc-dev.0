Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F2FA2C092B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:06:33 +1000 (EST)
Message-ID: <1372140384.3944.189.camel@pasglop>
Subject: Re: [PATCH 03/10] powerpc/eeh: Check PCIe link after reset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 16:06:24 +1000
In-Reply-To: <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-4-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 13:55 +0800, Gavin Shan wrote:
>         * don't touch the other command bits
>          */
> -       eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
> -       if (edev->config_space[1] & PCI_COMMAND_PARITY)
> -               cmd |= PCI_COMMAND_PARITY;
> -       else
> -               cmd &= ~PCI_COMMAND_PARITY;
> -       if (edev->config_space[1] & PCI_COMMAND_SERR)
> -               cmd |= PCI_COMMAND_SERR;
> -       else
> -               cmd &= ~PCI_COMMAND_SERR;
> -       eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
> +       if (pdev) {
> +               eeh_ops->write_config(dn, PCI_COMMAND, 4,
> +                                     edev->config_space[1]);
> +       } else {

That needs a much better comment. Why are you doing that instead
of what's below ? In fact there is more to restore in a bridge
right ? (windows etc...). Do you do that ? Should we just have a
different function to restore a device vs. a bridge ?

I also don't see a need to do thing differently between phyp and
powernv. Bridges inside partitions would suffer the same fate in
both cases.

Ben.

> +               eeh_ops->read_config(dn, PCI_COMMAND, 4, &cmd);
> +               if (edev->config_space[1] & PCI_COMMAND_PARITY)
> +                       cmd |= PCI_COMMAND_PARITY;
> +               else
> +                       cmd &= ~PCI_COMMAND_PARITY;
> +               if (edev->config_space[1] & PCI_COMMAND_SERR)
> +                       cmd |= PCI_COMMAND_SERR;
> +               else
> +                       cmd &= ~PCI_COMMAND_SERR;
> +               eeh_ops->write_config(dn, PCI_COMMAND, 4, cmd);
> +       }
> +
