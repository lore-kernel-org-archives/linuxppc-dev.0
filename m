Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 68868B6F76
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 01:03:47 +1100 (EST)
Subject: Re: Different behaviour when using "nosmp" parameter on SMP and UP
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
Date: Thu, 1 Dec 2011 08:03:42 -0600
Message-Id: <D70E8CC4-9FA3-4DC9-B623-02F32EFBFE0F@kernel.crashing.org>
References: <CAL8zT=juU_PC92R4za31R8Lmur0PrFwog1m1fk+PEarW_0C6ng@mail.gmail.com>
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 1, 2011, at 3:57 AM, Jean-Michel Hautbois wrote:

> Hi,
>=20
> I have a P2020 CPU (powerpc) and I compiled it with two different =
defconfigs.
> The first one is a SMP, 2 cores, launched with the "nosmp" kernel
> parameter, the other one is an UP kernel.
>=20
> My driver behaviour is not the same whether launching one or the
> other. It is hard to explain more precisely, as it deals only with
> ioctl which only does ioread32/iowrite32 on a PCIe device.
> But I can tell that it never works the same way when UP (not working
> correctly), or SMP "nosmp" (working) or even SMP (not working).
>=20
> AFAIK, the "nosmp" parameter should tell the kernel to act the same is
> if it is an UP kernel, and it disables IO APIC, which is not an issue
> in my case.
>=20
> Can you think about anything that would explain it, or would help me
> debugging it ?

This is a bit odd, hard to say w/o more details on what exactly your =
code is trying to do and wait the failure is.

The larger differences between SMP & UP build would be setting of memory =
attribute for cache coherency.  In UP case we don't set it.

Between SMP 'nosmp' and SMP 'on' cases you seem like you're hitting some =
locking condition.

Guessing your running into a timing & locking issue that you're getting =
lucky on the SMP 'nosmp' case such that it just happens to work.

- k=
