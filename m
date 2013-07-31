Return-Path: <cbf123@mail.usask.ca>
Received: from smtp.usask.ca (smtp.usask.ca [128.233.192.40])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "*.usask.ca", Issuer "RapidSSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F09E2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 03:40:48 +1000 (EST)
Received: from conversion-daemon.usask.ca by usask.ca
 (Sun Java(tm) System Messaging Server 7.3-11.01 64bit (built Sep  1 2009))
 id <0MQT000007HJ6I00@usask.ca> for linuxppc-dev@lists.ozlabs.org; Wed,
 31 Jul 2013 10:40:05 -0600 (CST)
Date: Wed, 31 Jul 2013 16:40:05 +0000
From: "Friesen, Christopher" <cbf123@mail.usask.ca>
Subject: RE: visible memory seems wrong in kexec crash dump kernel
In-reply-to: <1375139436.30721.63@snotra>
To: Scott Wood <scottwood@freescale.com>
Message-id: <CFBB0F4944BCD94BAC0398D7DB81D705EAF91D@CAMPUSMB5.usask.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <51E0F41A.20904@mail.usask.ca> <1375139436.30721.63@snotra>
Cc: Paul Mackerras <paulus@samba.org>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


=46rom: Scott Wood [scottwood@freescale.com]
Sent: Monday, July 29, 2013 5:10 PM
To: Friesen, Christopher
Cc: Michael Ellerman; kexec@lists.infradead.org; Paul Mackerras; linu=
xppc-dev@lists.ozlabs.org; Vivek Goyal
Subject: Re: visible memory seems wrong in kexec crash dump kernel

On 07/13/2013 01:30:50 AM, Chris Friesen wrote:
> The upshot is that there seems to be a number of things that could =
be
> improved:
>
> 1) kexec should accept "/memory" and not just "/memory@"
> 2) lmb_reserve() should really respect the crashkernel memory limit
> 3) the freescale stuff really shouldn't assume it can map things
> wherever it feels like

What "board-specific freescale code" are you referring to?

-Scott


Sorry for the crappy quoting, I'm using a web outlook portal.

I've switched employers so I don't have access to the exact details a=
ny more.  The system in question was a Kontron AM4150 which uses the =
P5020.  As I recall, one of the Freescale drivers (I think it was the=
 buffer or queue manager that the network driver makes use of) was at=
tempting to call lmb_reserve() with a base address in the 4GB range e=
ven though the recovery kernel was limited to 224MB of memory.

While I've got your attention, the other thing that I found was that =
the "dpa" network driver didn't properly work in a kexec'd kernel eve=
n when given lots of memory.  It would work for a little bit and then=
 hang.

This was all on a Wind River Linux 4.3 system, which is based on 2.6.=
34.  It's possible it's been fixed in more recent kernels.  The testc=
ase to see if current kernels are still affected should be fairly sim=
ple:

1) Take a P5020 board and boot it with NFS rootfs, reserving 224MB fo=
r crashkernel.
2) Load a crashkernel into it, configured to use NFS rootfs.
3) Trigger a panic on the main kernel.
4) Ensure it loads the recovery kernel properly, that it is limited t=
o the correct amount of memory, that it has visibility of the origina=
l kernel's memory,  that it has network connectivity and is stable wh=
en copying a few gigs of data over the network.

Chris
