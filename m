Date: Thu, 9 Nov 2000 09:26:53 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Claus <cl.en@gmx.net>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <20001109022256.A261@olis.north.de>
Message-ID: <Pine.LNX.4.10.10011090922050.18340-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've just had a snooze-pmud-cd_module crash, sorry it's not in log/messages.
> I wrote this from the screen: pc c00d82cc lr c00d8aa8
>
> 2:02@pts/1 ~ > uname -a
> Linux apple 2.2.18pre17-ben1 #38 Wed Oct 25 18:51:51 CEST 2000 ppc unknown
>
> c00d82b4 <idepmac_wake_device>:
> c00d82b4:       94 21 ff d0     stwu    r1,-48(r1)
> c00d82b8:       7c 08 02 a6     mflr    r0
> c00d82bc:       bf a1 00 24     stmw    r29,36(r1)
> c00d82c0:       90 01 00 34     stw     r0,52(r1)
> c00d82c4:       7c 7f 1b 78     mr      r31,r3
> c00d82c8:       81 3f 00 54     lwz     r9,84(r31)
> c00d82cc:       80 09 00 24     lwz     r0,36(r9)
> ^^^^^^^^

That would be around

	DRIVER(drive)->media_change(drive);

and indicates that the driver part of the ide_drive struct is hosed, if I
interpret the assembly above right (r9 is loaded from *r31+84, r0 then
loaded from *r9+36).

Something scribbling over kernel memory?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
