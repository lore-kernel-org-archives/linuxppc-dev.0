Return-Path: <bergner@vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BFDE82C008A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2012 11:26:24 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bergner@vnet.ibm.com>;
 Mon, 17 Dec 2012 19:26:19 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C83A0C90081
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2012 19:26:15 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBI0QFit293284
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2012 19:26:15 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBI0QFX8006468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2012 19:26:15 -0500
Subject: Re: [PATCH] powerpc: POWER7 optimised memcpy using VMX and
 enhanced prefetch
From: Peter Bergner <bergner@vnet.ibm.com>
To: Jimi Xenidis <jimix@pobox.com>
In-Reply-To: <20121217223333.6cb00476@kryten>
References: <20120531162209.04bd9bdc@kryten>
 <D5CF6D4A-8F60-4853-9F7C-EFE5133CEB33@pobox.com>
 <20121217223333.6cb00476@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 Dec 2012 18:26:13 -0600
Message-ID: <1355790373.5180.26.camel@otta>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Kumar Gala <kumar.gala@gmail.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-12-17 at 22:33 +1100, Anton Blanchard wrote:
> Hi Jimi,
> 
> > I know this is a little late, but shouldn't these power7 specific
> > thingies be in "obj-$(CONFIG_PPC_BOOK3S_64)". The reason I ask is
> > that my compiler pukes on "dcbtst" and as I deal with that I wanted
> > to point this out.
> 
> I guess we could do that. It's a bit strange your assembler is
> complaining about the dcbtst instructions since we wrap them with
> power4:
> 
> .machine push
> .machine "power4"
>         dcbt    r0,r4,0b01000
>         dcbt    r0,r7,0b01010
>         dcbtst  r0,r9,0b01000
>         dcbtst  r0,r10,0b01010
>         eieio
>         dcbt    r0,r8,0b01010   /* GO */
> .machine pop

Jimi, are you using an "old" binutils from before my patch that
changed the operand order for these types of instructions?

    http://sourceware.org/ml/binutils/2009-02/msg00044.html

Peter
