Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Kenneth Johansson" <kenneth.johansson@etx.ericsson.se>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: <kuster@pacbell.net>, <acmay@acmay.homeip.ne>
Subject: RE: IBM ocp I2C circular dependency
Date: Tue, 7 May 2002 07:04:59 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEJMDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CD7D04C.1E9122A0@etx.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I can not speak toward the modularization issue but if the i2c is anything
like the old 8260 version, change the interruptible_sleep_on() to
interruptible_sleep_on_timeout(). IMHO this is the easiest fix.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Kenneth
Johansson
Sent: Tuesday, May 07, 2002 6:02 AM
To: linuxppc-embedded@lists.linuxppc.org
Cc: kuster@pacbell.net; acmay@acmay.homeip.ne
Subject: IBM ocp I2C circular dependency



i2c-adap-ibm_ocp.c uses
	i2c_iic_add_bus and i2c_iic_del_bus from i2c-algo-ibm_ocp.c

i2c-algo-ibm_ocp.c uses
	iic_ibmocp_waitforpin from i2c-adap-ibm_ocp.c

This makes it impossible to build as a module. I'am not shure how you want
to
solv this.

Also I found a problem with the code when I access a i2c memory from
userspace and no chip is present at that address. After that it's not
possible to access anything else on the I2C bus. Works OK as long as I use
addresses that have a device that answers (I think).


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
