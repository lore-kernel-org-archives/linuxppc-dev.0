Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 3FD931007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 07:55:53 +1000 (EST)
Received: by vws20 with SMTP id 20so2755825vws.15
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Jul 2010 14:55:52 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
References: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 1 Jul 2010 16:55:22 -0500
Message-ID: <AANLkTikLivGEFl_DJsvWArbvE1yYUBFn9yiQxqsZgTma@mail.gmail.com>
Subject: Re: CONFIG_NO_HZ causing poor console responsiveness
To: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Galbraith <efault@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 2:54 PM, Timur Tabi <timur@freescale.com> wrote:
> I'm adding support for a new e500-based board (the P1022DS), and in
> the process I've discovered that enabling CONFIG_NO_HZ (Tickless
> System / Dynamic Ticks) causes significant responsiveness problems on
> the serial console. =A0When I type on the console, I see delays of up to
> a half-second for almost every character. =A0It acts as if there's a
> background process eating all the CPU.

I finally finished my git-bisect, and it wasn't that helpful.  I had
to skip several commits because the kernel just wouldn't boot:

There are only 'skip'ped commits left to test.
The first bad commit could be any of:
6bc6cf2b61336ed0c55a615eb4c0c8ed5daf3f08
8b911acdf08477c059d1c36c21113ab1696c612b
21406928afe43f1db6acab4931bb8c886f4d04ce
5ca9880c6f4ba4c84b517bc2fed5366adf63d191
a64692a3afd85fe048551ab89142fd5ca99a0dbd
f2e74eeac03ffb779d64b66a643c5e598145a28b
c6ee36c423c3ed1fb86bb3eabba9fc256a300d16
e12f31d3e5d36328c7fbd0fce40a95e70b59152c
13814d42e45dfbe845a0bbe5184565d9236896ae
b42e0c41a422a212ddea0666d5a3a0e3c35206db
39c0cbe2150cbd848a25ba6cdb271d1ad46818ad
beac4c7e4a1cc6d57801f690e5e82fa2c9c245c8
41acab8851a0408c1d5ad6c21a07456f88b54d40
6427462bfa50f50dc6c088c07037264fcc73eca1
c9494727cf293ae2ec66af57547a3e79c724fec2
We cannot bisect more!

These correspond to a batch of scheduler patches, most from Mike Galbraith.

I don't know what to do now.  I can't test any of these commits.  Even
if I could, they look like they're all part of one set, so I doubt I
could narrow it down to one commit anyway.

--=20
Timur Tabi
Linux kernel developer at Freescale
