From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: tlbia and PPC603
Date: Thu, 20 Jun 2002 09:53:55 +0200
Message-Id: <20020620075355.30719@smtp.adsl.oleane.com>
In-Reply-To: <20020620174254U.ekato@ees.hokudai.ac.jp>
References: <20020620174254U.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Your xmon trace show something interesting: xmon itself crashes with a
trap 300 while trying to access the hash table. The hash beeing mapped
with a BAT, that shouldn't be an issue with the TLB handlers nor with
a stale TLB entry. I currently fail to see what could be going on there,
could you try to reproduce that crash ? In this case, once "h" fails
within xmon, type

 di %pc
 r

and send me what it days.

Ben.

---

vector: 300 at pc = c0190888, lr = c01907fc
msr = 9032, sp = c7e49e10 [c7e49d60]
dar = 1180, dsisr = 20000000
current = c7e48000, pid = 579, comm = sshd
mon> t
backtrace:
c01907fc
c01aef10
c016c6b4
c016c7d8
c003b128
c0005cbc
exception:c00 [c7e49f50] fd98038
100040e0
10005cbc
0fce5b90
00000000
mon> S
msr = 1032, pvr = 71201
sprg0-3 = c0210000 1 0 7e48270
srr0 = c0010340, srr1 = 80011032
sr0-15 = 607bbb50 607bbc61 607bbd72 6
07bbe83 607bbf94 607bc0a5 607bc1b6 607bc2c7 20000888 20000999 20000aaa
20000bbb 20000ccc 20000ddd 20000eee 20000fff
sp = c7e49b80 toc = c7e480000
mon> h
Mappings for context 0
vector: 300 at pc = c00c2ef4, lr = c00c3114
msr = 1032, sp = c7e49b50 [c7e49aa0]
dar = 0, dsisr = 20000000
current = c7e48000, pid = 579, comm = sshd


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
