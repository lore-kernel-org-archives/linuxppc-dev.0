Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFFA002@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>
Cc: "'Troy Benjegerdes'" <hozer@drgw.net>,
	linuxppc-embedded@lists.linuxppc.org, paulus@samba.org,
	Gabriel Paubert <paubert@iram.es>
Subject: RE: Bogomips and loops_per_jiffy
Date: Wed, 8 May 2002 14:30:18 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Benjamin,

> I'd rather
> change the test from >= to > (which in the old could would mean
> changing the while (... < 0 to <= 0) as I see no reason to trigger
> a new decrementer interrupt in ... 0 ticks !

I think I did not change the previous 'while' logic.
It said:
    while ( diff < 0 )

Now it says:
    while ( 1 ) {
        if ( diff >= 0 )
            break;

Previously, the while could be left for a next_dec of 0.
But I agree with you: it could be changed.
Why leaving the loop just to set the decrementer to 0!?

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
