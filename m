Message-ID: <004301c4551b$07f6a8a0$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: fec multicast question
Date: Fri, 18 Jun 2004 12:00:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi folks,

i'm working on fec driver modification. I'm implementing the
set_multicast_list. dev->dmi_addr is saved on LSB format. I want to do a
multicast filter. I'm doing it by sw.

Now i'm using crc32 from /linux/crc.h, witch use a table.

I convert LSB dmi_addr to MSB. Then apply crc32. Result obtained is for UART
tx purpose(LSB), pass result
to MSB again. Then mask with 0x7C000000 to obtain bit on
hash_table_register. mask with 0x80000000 to select what register.

on mine board, diferent to anyone you can know, multicast filter is done.
but not correctly. I can't access to any SCC(all used, modes diferent from
ETHERNET). I can't access to boards with scc enet.

when i call to crc32 val take 0xFFFFFFFF value, like
scc dpram says(c_pres, section 28.8 MPC860 PowerQuicc User's Manual), and
mask is not used(c_mask).

Can anyone give mi hex value of hash_table_high and hash_table_low using
CPM_SET_GROUP? i.e, for address 224.0.0.123. better for three or four
direcctions, then maybe can obtain algorithm used by cpm and sw
CPM_SET_GROUP can be do.

thanks all

----------------------------------------------------------------------------
----------------------------------------
"No nos atrevemos a muchas cosas porque son difíciles, pero son difíciles
porque no nos atrevemos a hacerlas"
Lucio Anneo Séneca , 2 AC-65

Jose Manuel Martin Bravo

jmartin@prodys.net
termita@ya.com

Madrid,Spain
----------------------------------------------------------------------------
----------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
