Message-ID: <81A66F72DCACD511B0600002A551BFCB02ABC2D4@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: /drivers/mtd/mtdblock_ro.c is buggy
Date: Wed, 19 Mar 2003 17:05:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody,
After a lot of debugging I seen that there is a bug in the MTD read only
block driver.
It seems that in the mtdblock_request, something goes wrong withe the
handling of the request structure.
between two calls to end_request, the pointer bh->req_qnext of the last used
buffer head is corrupted.
I didn't find the cause but since this happens only with the
mtdblock_request function I suppose there is something wrong in it.

If I ever find what's wrong I will try to correct it, but don't hope too
much I don't have a lot of time.

----------------------------------------------------------------------------
------
Benoit Callebaut
Software Development Engineer
Barco | Control Rooms
Noordlaan 5, 8520 Kuurne, Belgium

Tel 	+32(0)56 36 84 28
Fax 	+32(0)56 36 86 05

mailto:benoit.callebaut@barco.com
http://www.barcocontrolrooms.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
