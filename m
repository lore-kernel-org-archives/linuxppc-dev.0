Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB8591A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 06:51:05 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0106.outbound.protection.outlook.com [157.56.110.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7B2D514010F
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2015 06:51:03 +1100 (AEDT)
Message-ID: <1426276250.27998.6.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: Add a proper syscall for switching endianness
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 13 Mar 2015 14:50:50 -0500
In-Reply-To: <1426228726.23806.3.camel@ellerman.id.au>
References: <1426221564-15086-1-git-send-email-mpe@ellerman.id.au>
 <1426228726.23806.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-03-13 at 17:38 +1100, Michael Ellerman wrote:
> On Fri, 2015-03-13 at 15:39 +1100, Michael Ellerman wrote:
> > We currently have a "special" syscall for switching endianness. This is
> > syscall number 0x1ebe, which is handled explicitly in the 64-bit syscall
> > exception entry.
> > 
> > diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> > index 91062eef582f..c3ee21a1d9cf 100644
> > --- a/arch/powerpc/include/asm/systbl.h
> > +++ b/arch/powerpc/include/asm/systbl.h
> > @@ -367,3 +367,4 @@ SYSCALL_SPU(getrandom)
> >  SYSCALL_SPU(memfd_create)
> >  SYSCALL_SPU(bpf)
> >  COMPAT_SYS(execveat)
> > +PPC_SYS(switch_endian)
> 
> And of course I forgot about 32-bit.
> 
> According to Paul there are no working implementations of LE on 32-bit cpus, so
> the syscall doesn't really make sense there.
> 
> Scott does that sound right to you for FSL stuff?

We don't support LE on FSL chips.

-Scott
