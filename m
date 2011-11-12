Return-Path: <jjdanimoth@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C7FCCB70FF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2011 10:27:39 +1100 (EST)
Received: by bkat8 with SMTP id t8so4671549bka.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 15:27:34 -0800 (PST)
From: DaNiMoTh <jjdanimoth@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: yenta_socket and Machine check in kernel mode
Date: Sun, 13 Nov 2011 00:27:23 +0100
Message-ID: <4362111.VxQkn1oUZp@jack>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2886498.MIYU0OOx6Q";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart2886498.MIYU0OOx6Q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

The error message "Caused by (from SRR1=214b030): Transfer error ack signal"
is everywhere in my (PowerBook G4) messages.log. I checked, and the module 
that cause it is yenta_socket.

That's the messages.log after a rmmod && modprobe (the [...] as for hundred 
and hundred line of the same messages:

Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: CardBus bridge found [0000:0000]
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: Using CSCINT to route CSC interrupts to PCI
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: Routing CardBus interrupts to PCI
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: TI: mfunc 0x00001002, devctl 0x60
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: ISA IRQ mask 0x0000, PCI irq 53
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: Socket status: 30000007
Nov 12 21:41:09 localhost kernel: yenta_cardbus 0001:10:13.0: pcmcia: parent PCI bridge window: [io  0x0000-0x7fffff]
Nov 12 21:41:09 localhost kernel: pcmcia_socket pcmcia_socket0: cs: IO port probe 0x0-0x7fffff:Machine check in kernel mode.
Nov 12 21:41:09 localhost kernel: Caused by (from SRR1=214b030): Transfer error ack signal
Nov 12 21:41:09 localhost kernel: Machine check in kernel mode.
[...]
Nov 12 21:43:47 localhost kernel: Machine check in kernel mode.
Nov 12 21:43:47 localhost kernel: Caused by (from SRR1=214b030): Transfer error ack signal
Nov 12 21:43:47 localhost kernel: Machine check in kernel mode.
Nov 12 21:43:47 localhost kernel: Caused by (from SRR1=214b030): Transfer error ack signal
Nov 12 21:43:47 localhost kernel:
Nov 12 21:43:47 localhost kernel: yenta_cardbus 0001:10:13.0: pcmcia: parent PCI bridge window: [mem 0xf3000000-0xf3ffffff]
Nov 12 21:43:47 localhost kernel: pcmcia_socket pcmcia_socket0: cs: memory probe 0xf3000000-0xf3ffffff: clean.
Nov 12 21:43:47 localhost kernel: yenta_cardbus 0001:10:13.0: pcmcia: parent PCI bridge window: [mem 0x80000000-0xafffffff]
Nov 12 21:43:47 localhost kernel: pcmcia_socket pcmcia_socket0: cs: memory probe 0x80000000-0xafffffff: excluding 0x80000000-0x807fffff 0x84000000-0x8bffffff 0xa0000000-0xa07fffff


I'm using the git 3.2.0-rc1 kernel, but I have the same problem with the 2.6.38.
There's something I can do (apart from blacklisting it, and don't use PCMCIA)?

Thanks

PS: Maybe related:

[1] http://lkml.indiana.edu/hypermail/linux/kernel/1104.3/01793.html
(Using pci=cbmemsize=8M doesn't help.. messages are still here)
[2] https://lists.linux-foundation.org/pipermail/bugme-new/2011-January/026377.html
(No hint if that is fixed or not)


-- 
Stay open, be free.
--nextPart2886498.MIYU0OOx6Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iF4EABEIAAYFAk6/ANsACgkQf3jdaskA4+jd9AEAsvoAb0942t6Zqk+rYfm+s/NG
fbdmvz6U+PLNZalLePwBAJ7Kf+jQeiSf1O9BMv8KUZIZecNcm1zmUCwp8sPeUXHY
=fBXh
-----END PGP SIGNATURE-----

--nextPart2886498.MIYU0OOx6Q--
