Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: IBM ocp I2C circular dependency
Date: Tue, 7 May 2002 08:10:38 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEKCDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CD7ED38.448C21D1@etx.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The problem I have, but our source is very old, is that it hung the process.
Implementing a timeout is half of the solution. The other thing you need to
do is issue a STOP_TX command to the CP. (allow the CP to continue to the
next request) Perhaps that is what you are seeing? Check the buffer
descriptors and see if the CP is still "busy" with the current descriptor
pointer.

-----Original Message-----
From: innkeon@etx.ericsson.se [mailto:innkeon@etx.ericsson.se]On Behalf
Of Kenneth Johansson
Sent: Tuesday, May 07, 2002 8:05 AM
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM ocp I2C circular dependency


Would that kind of problem not hang the process?? I don't see that.

Allen Curtis wrote:
>
> I can not speak toward the modularization issue but if the i2c is anything
> like the old 8260 version, change the interruptible_sleep_on() to
> interruptible_sleep_on_timeout(). IMHO this is the easiest fix.
>
> -----Original Message-----
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kenneth
> Johansson
> Also I found a problem with the code when I access a i2c memory from
> userspace and no chip is present at that address. After that it's not
> possible to access anything else on the I2C bus. Works OK as long as I use
> addresses that have a device that answers (I think).
>

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
