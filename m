From: Ruedi.Hofer@ascom.ch
Date: Mon, 25 Sep 2000 16:24:58 +0100 (CED)
Subject: Limon & PowerQUICC II, Booting the kernel
To: linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G1G0093N5EZUI@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_41PqGbsqhsWW8+BPUvGmnw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_41PqGbsqhsWW8+BPUvGmnw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

I have Limon up and running. I managed to set up the host in order
to serv the linux kernel.
The kernel I download is the ordinary kernel from Montavista HH1.2.
I prepared the zImage in the following way:
1. I stripped off the elf header. (dd if=zImage of=stripZImage bs=64k skip=1)
2. I run it through mklimon to add the limon specific header.

After I've loaded the kernel I can see the kernel in the RAM from addr 0.

When I issue the 'run' command the target crashes.

---------------- Linux Monitor 1.4.2-SBC-8260 ----------------
limon>
limon>
limon> load
BOOTP/TFTP from server 10.1.20.2; our IP address is 10.1.20.1.
Filename '/usr/src/nfs/limonZImage'.
Loading: >.................................................................<
done.
limon>
limon> debug
limon> dw
00000000   48000005  7c6b1b78  7cb92b78  38600040  H...|k.x|.+x8`.@
00000010   7c600124  3c800040  60840000  7c6802a6  |`.$<..@`...|h..
00000020   3863fffc  7c681b78  7c032000  40820028  8c..|h.x|. .@..(
00000030   3c800040  60840000  3ca00040  60a5b274  <..@`...<..@`..t
00000040   38a50003  7ca42850  54a5f0be  7ca72b78  8...|.(PT...|.+x
limon>
limon>
limon> run
... crash


Question:

1. Is my kernel image munging correct?

2. Is the start address 0 correct?

3. Some data are transferred from limon to the kernel.
 - Does Limon handle this correctly?
 - Where are these data located?


Thank you for any help

Ruedi

--Boundary_(ID_41PqGbsqhsWW8+BPUvGmnw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
