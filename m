Content-Type: text/plain;
  charset="iso-8859-1"
From: Leonardo Pereira Santos <lsantos@pd3.com.br>
To: linuxppc-embedded@lists.linuxppc.org
Subject: simple PCMCIA questions
Date: Thu, 28 Nov 2002 16:47:22 -0200
MIME-Version: 1.0
Message-Id: <200211281647.24872.lsantos@pd3.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hello Everybody!
	I've got a few pcmcia questions and would apreciate if someone could give me
some directions. Ok, I have a BK 2.4.20-pre11 kernel compiled with built-in
PCMCIA support (NO cardbus). If I insert a wifi card in my board's slot and
use pcmcia-cs' cardctl info, it'll answer me. Next I try to load the card's
driver, so I insmod then in order (I got the card working in a PLX adapter in
my PC and it uses theses drivers) : hermes, orinoco and orinoco_cs. Until
now, so far so good. The first weird thing is that if I do a lsmod, it'll
answer me this:

# lsmod
Module                  Size  Used by
orinoco_cs              5472   0  (unused)
orinoco                31648   0  [orinoco_cs]
hermes                  5840   0  [orinoco_cs orinoco]

Ok, who should use the orinoco_cs module?
In my /etc/modules.conf I have the following line:

alias eth1 orinoco_cs

So I assumed that if I brought up eth1, everything should work in some degree,
but when I type ifconfig eth1 up, I just got the message saying

eth1: unknown interface: No such device

What gives?
At least shouldn't I be able to bring up a interface?

As a last step, I try to load cardmgr, it then fires up a lot of functions but
it'll results in a kernel panic:

Kernel panic: request_irq
 <0>Rebooting in 180 seconds..

I read in a message from Matthew Locke (
http://lists.linuxppc.org/linuxppc-embedded/200104/msg00133.html)

That 8xx socket driver before CS 3.1.26 wouldn't pass the assined irq number
to CS. But BK's m8xx_pcmcia.c  has a copyright line from Locke himself from
2002, and the message's from april, 2001. So, is this still an issue? By the
message's contents, I figured out that this bug would lead just to a
non-functioning card, not ot a kerl-panic crash.
As a last question, why BK's kernel has a very old CS version (3.1.22), when
the current on is 3.2.3? I mean, the kernel's CS should work, doesn't it?
Does someone now where can I get a recent kernel with a more recent version
of CS (assuming that that would fix my problem). Thanks for bearing with me
so far and any help is kindly apreciated.

- --
"All things are ready, if our minds be so"
The Life Of King Henry V - William Sharespeare

Leonardo Pereira Santos
Engenheiro de Projetos
PD3 Tecnologia
av. Pará 330/202
(51) 3337 1237


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
