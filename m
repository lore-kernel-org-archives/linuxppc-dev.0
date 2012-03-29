Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0CF2B6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 07:30:32 +1100 (EST)
Message-ID: <4F74C65A.2000006@freescale.com>
Date: Thu, 29 Mar 2012 15:30:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Fabio <pozzi.fabio@gmail.com>
Subject: Re: Help initialize phy-less ethernet in 2.6.38
References: <CAP-cLV5pF-j_izadBSVD7p4hQte96O_g2udCxi=9tkaPwxEsaw@mail.gmail.com>
 <4F74AB70.7070209@freescale.com>
 <CAP-cLV5hAT8sp7uxy5o3_NOw5xoAvoz-rV04zB4pmULSp3pXcg@mail.gmail.com>
In-Reply-To: <CAP-cLV5hAT8sp7uxy5o3_NOw5xoAvoz-rV04zB4pmULSp3pXcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Fleming <afleming@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2012 02:56 PM, Fabio wrote:
>> Which old kernel driver?  Why do you need to mess with fs_platform_info?
> I have to port a custom platform driver written for 2.6.10 to support
> this custom board.

So it's old arch/ppc stuff.  Now fs_platform_info is driver-internal and
info comes from the device tree.  You shouldn't touch the struct directly.

>> Why do you think the interrupt is misconfigured?
> Because I don't get any error during boot or when I run ifconfig, but
> I don't see
> any interrupt if I run 'cat /proc/interrupts':

That could mean that something else is failing, such that you don't
have the activity that would cause an interrupt.

>> Looking at the code, though, I'm not sure if this stuff still works --
>> e.g. I don't see where any fields of fixed-link but the ID are used, or
>> what's supposed to happen when of_phy_connect_fixed_link() calls
>> phy_connect().
> If it isn't so, do you have any suggestion about how to re-add this
> functionality to the existing code?

Andy, do you know what the state of this stuff is?

-Scott
