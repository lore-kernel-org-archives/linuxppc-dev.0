Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 12BB0B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Dec 2011 05:41:41 +1100 (EST)
Received: from mail55-tx2 (localhost [127.0.0.1])	by mail55-tx2-R.bigfish.com
 (Postfix) with ESMTP id 71C7D5A0475	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Dec 2011 18:41:36 +0000 (UTC)
Received: from TX2EHSMHS020.bigfish.com (unknown [10.9.14.251])	by
 mail55-tx2.bigfish.com (Postfix) with ESMTP id 467EB620045	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 18:41:36 +0000 (UTC)
Message-ID: <4EE2565E.7050700@freescale.com>
Date: Fri, 9 Dec 2011 12:41:34 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Shengzhou-B36685 <B36685@freescale.com>
Subject: Re: Linuxppc-dev Digest, Vol 88, Issue 24
References: <mailman.5273.1323013984.15294.linuxppc-dev@lists.ozlabs.org>
 <3F453DDFF675A64A89321A1F352810216B0A24@039-SN1MPN1-005.039d.mgd.msft.net>
In-Reply-To: <3F453DDFF675A64A89321A1F352810216B0A24@039-SN1MPN1-005.039d.mgd.msft.net>
Content-Type: text/plain; charset="GB2312"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo-B35362 <B35362@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2011 03:27 AM, Liu Shengzhou-B36685 wrote:
> Before calling nand_scan_ident(), we can still use 2k FCM RAM, not need=
 a buffer greater than 2k=A3=AC
> After nand_scan_ident(),  if writesize > 2048, then allocate a large bu=
ffer.
> We can do it in fsl_elbc_chip_init_tail()
>   if (mtd->writesize > 2048)
>       ctrl->buffer =3D kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNE=
L);

As we discussed elsewhere in the thread, the buffer is a controller-wide
resource.  It is not associated with any one NAND chip.

-Scott
