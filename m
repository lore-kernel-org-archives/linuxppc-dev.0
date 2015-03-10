Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83DA21A0360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 21:55:13 +1100 (AEDT)
Message-ID: <1425984912.1920.4.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 1/2] powerpc: Add a proper syscall for switching
 endianness
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Date: Tue, 10 Mar 2015 21:55:12 +1100
In-Reply-To: <1425980077.4636.265.camel@au1.ibm.com>
References: <1425973006-22759-1-git-send-email-mpe@ellerman.id.au>
 <1425980077.4636.265.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 20:34 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2015-03-10 at 18:36 +1100, Michael Ellerman wrote:
> > We currently have a "special" syscall for switching endianness. This is
> > syscall number 0x1ebe, which is handled explicitly in the 64-bit syscall
> > exception entry.
> > 
> > That has a few problems, firstly the syscall number is outside of the
> > usual range, which confuses various tools. For example strace doesn't
> > recognise the syscalls at all.
> > 
> > Secondly it's handled explicitly as a special case in the syscall
> > exception entry, which is complicated enough without it.
> > 
> > As a first step toward removing the special syscall, we need to add a
> > regular syscall that implements the same functionality.
> > 
> > The logic is simple, it simply toggles the MSR_LE bit in the userspace
> > MSR. This is the same as the special syscall, with the caveat that the
> > special syscall clobbers fewer registers.
> 
> You can set _TIF_RESTOREALL to force a restore of all the registers on
> the way back which should do the job.

Right, I'd forgotten we talked about that.

I'll try that tomorrow.

cheers
