Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 72201B70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 21:36:41 +1000 (EST)
Received: by wwa36 with SMTP id 36so2774012wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Oct 2010 04:36:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Date: Fri, 1 Oct 2010 07:36:35 -0400
Message-ID: <AANLkTikHcoccu-WGtSOSdkwU6Tw_An_VFkUcEoY==8=c@mail.gmail.com>
Subject: Re: Introduce support for little endian PowerPC
From: Josh Boyer <jwboyer@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 1, 2010 at 3:05 AM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> This patch set in combination with a patched GCC, binutils, uClibc and
> buildroot has allowed for a full proof of concept little endian environme=
nt on
> a 440 Taishan board, which was able to successfully run busybox, OpenSSH =
and a
> handful of other userspace programs without problems.

Aside from my general "uh, why?" stance, I'm very very hesitant to
integrate anything in the kernel that doesn'.t have released patches
on the toolchain side.

Also, which uClibc?  The old and crusty uClibc that uses the horrible
linuxthreads, or the somewhat less crusty that just switched to NPTL
(which hasn't been verified on normal PowerPC that I recall).  Why not
use glibc...

> This is not yet complete support for little endian PowerPC, some outstand=
ing
> issues that I am aware of are:
> =A0* We only support 32bit PowerPC for now (and indeed, only 44x)
> =A0* The vdso has not been fixed to be endian agnostic - any userspace pr=
ogram
> =A0 accessing it will get an unexpected result.
> =A0* I have not touched PCI at all
> =A0* Remaining device tree accesses still need to be examined to ensure t=
hey are
> =A0 correctly handling the endianess of the device tree.
> =A0* Any other driver that uses the device tree is likely be broken for t=
he same reason.
> =A0* I've included a patch for the alignment handler, however it is as ye=
t
> =A0 completely untested due to a property of the hardware I've been using=
 for
> =A0 testing.

I'm not meeting to detract here, but the Kconfig should be dependent
on && BROKEN until the above is fixed.

josh
