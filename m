Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x244.google.com (mail-ot0-x244.google.com
 [IPv6:2607:f8b0:4003:c0f::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjwCn4Lj8zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 02:15:49 +1100 (AEDT)
Received: by mail-ot0-x244.google.com with SMTP id a12so3146537ota.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 08:15:49 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
References: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Mar 2017 16:15:46 +0100
Message-ID: <CAK8P3a1+LtWf-VdJeA-0TycrEDkiPztMOnNN5wCfjrxYPtsVvg@mail.gmail.com>
Subject: Re: ioctl structs differ from x86_64?
To: Harshal Patil <harshal.patil@in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Sudipto Ghosh <sudiptoghosh@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 14, 2017 at 11:37 AM, Harshal Patil
<harshal.patil@in.ibm.com> wrote:
> Hello,
>
> I am looking into a bug,
> https://bugzilla.linux.ibm.com/show_bug.cgi?id=152493 ( external mirror is
> at, https://github.com/opencontainers/runc/issues/1364)
>
> Recently in runc code, they added this code
> https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155.
> As you can see they set -onlcr to get rid of \r (line no. 164). Golang, in
> which runc is written, doesn't have any bindings for ioctls.  This means you
> have to invoke C code directly (that's what they are doing there).
>
> Our guess is the ioctls in ppc64le differ than x86_64, and thats why the
> code which is clearing onclr bit
> (https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR164)
> is failing on ppc64le but works fine on x86_64.
>
> Any pointers on the possible solution would be really helpful.

There are a couple of reasons for ioctl numbers to differ:

- like this one, the command number may be defined in asm/ioctls.h.
Most architectures
  in the kernel are the same, some (arm, blackfin, frv, m68k, and
s390) only differ
  in FIOQSIZE, others (alpha, mips, parisc, powerpc, sh, sparc, and
xtensa) redefine
  all the traditional file (FIO*) and tty (TC*, TIO*) commands

- command numbers that are defined in terms of structure sizes depend on the
  architectures type definitions (e.g. long, off_t, uid_t, ...) that
can differ in both
  size and alignment

- alpha, mips, powerpc and sparc use _IOC_SIZEBITS==13, everything else uses
  _IOC_SIZEBITS==14, and that in turn means that the majority of ioctl commands
  are different between those four and the rest.

      Arnd
