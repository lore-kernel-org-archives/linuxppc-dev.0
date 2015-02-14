Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id CC3BA1A0C21
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Feb 2015 21:29:59 +1100 (AEDT)
Message-ID: <54DF239E.6080705@c-s.fr>
Date: Sat, 14 Feb 2015 11:29:50 +0100
From: christophe leroy <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: K Richard Pixley <rpixley@graphitesystems.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: embedding dtb file into kernel
References: <54DE3732.2080707@graphitesystems.com>
In-Reply-To: <54DE3732.2080707@graphitesystems.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 13/02/2015 18:41, K Richard Pixley a écrit :
> I'm having trouble figuring out how to embed a dtb file into my 
> kernel.  I'm thinking that there should be a standard, architecture 
> independent facility for this akin to initramfs, yes?
>
> Could someone please either point me to the standard facility, 
> relevant doc, a currently building board that uses the standard 
> facility, or outline what needs to be done to do this with a new board?
>
> If it matters, (I can't think why it would), I'm working with powerpc 
> on a 3.10 kernel.  But if there are better facilities in other 
> versions I'd appreciate hearing about that too.
>
> Thank you in advance.
>

Hi,

The device tree (DTB file) is not supposed to be embedded into the 
kernel but loaded independently by the boot loader (for instance Uboot).
Then a pointer to the device tree is handed over by Uboot to the kernel 
when calling the _start function.

You also have in arch/powerpc/boot/ a facility called cuboot which 
allows to create a ppcboot image with kernel and device tree bound together.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
http://www.avast.com
