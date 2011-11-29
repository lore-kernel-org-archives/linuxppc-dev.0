Return-Path: <acrux_it@libero.it>
Received: from outrelay01.libero.it (outrelay01.libero.it [212.52.84.101])
 by ozlabs.org (Postfix) with ESMTP id 4D6331007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 12:00:34 +1100 (EST)
Message-ID: <29308092.5681751322528430078.JavaMail.defaultUser@defaultHost>
Date: Tue, 29 Nov 2011 02:00:30 +0100 (CET)
From: "acrux_it@libero.it" <acrux_it@libero.it>
To: <agust@denx.de>
Subject: Re: sam460ex, sm501 incorrect device id with kernel >=linux-2.6.39
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: "acrux_it@libero.it" <acrux_it@libero.it>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>Da: agust@denx.de
>Data: 28/11/2011 21.22
>A: "acrux"<acrux_it@libero.it>
>Cc: "Josh Boyer"<jwboyer@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
>Ogg: Re: sam460ex, sm501 incorrect device id with kernel &gt;=linux-2.6.39
>
>On Mon, 28 Nov 2011 20:56:55 +0100
>acrux <acrux_it@libero.it> wrote:
>...
>> it seems to be an endianess issue but i didn't find when it was
>> introduced.  Really strange this kind of issue was never noticed
>> bumping from 2.6.38.x to 2.6.39.x .
>
>Look at commit bf5f0019046d596d613caf74722ba4994e153899
>(video, sm501: add I/O functions for use on powerpc).
>This is the issue, I think. Especially changes in include/linux/sm501.h
>by this commit. Since CONFIG_PPC32 is defined for canyonlands,
>ioread32be() is used to access the registers at PCI space which
>is wrong. The patch was tested on tqm5200 with sm501 connected
>on localbus, so using ioread32be() worked there. Your sm502 is on
>PCI bus I suppose. This issue needs to be fixed.
>
>HTH,
>Anatolij
>

hallo Anatolij,
you are absolutely right altought i don't have a skill to fix it.
Indeed, this SM502 is located on PCI bus. Here a schema:
http://oi39.tinypic.com/34r9mw2.jpg


cheers,
--nico
