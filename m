Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22BEC1A009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:06:21 +1100 (AEDT)
Message-ID: <1448240780.3061.5.camel@neuling.org>
Subject: Re: [PATCH 1/8] selftests/powerpc: Test the preservation of FPU and
 VMX regs across syscall
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 12:06:20 +1100
In-Reply-To: <20151123115853.17185e4a@camb691>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-2-git-send-email-cyrilbur@gmail.com>
 <1448238193.3483.104.camel@neuling.org> <20151123115853.17185e4a@camb691>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-23 at 11:58 +1100, Cyril Bur wrote:
> On Mon, 23 Nov 2015 11:23:13 +1100
> Michael Neuling <mikey@neuling.org> wrote:
>=20
> > On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> > > Test that the non volatile floating point and Altivec registers
> > > get
> > > correctly preserved across the fork() syscall. =20
> >=20
> > Can we add a test for VSX too?  I realise it's the same registers,
> > but
> > the enable bits in the MSR are different so it's easy to get them
> > wrong
> > in the kernel.
>=20
> Yeah, I'm sure I could get that wrong haha.
>=20
> Hmmmm this got me thinking. Today we always enable FP and Altivec
> when we
> enable VSX but isn't there a world where we could actually run with
> FP and
> Altivec disabled and VSX on? In which case, is the whole thing
> volatile or
> does the kernel still need to save the subset of the matrix which
> corresponds=20
> to non-volatile FPs and non-volatile Altivec?

The hardware can run with FP and VMX off and VSX on but we should never
do that in Linux.

Mikey
