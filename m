Message-ID: <3CD7D04C.1E9122A0@etx.ericsson.se>
Date: Tue, 07 May 2002 15:02:04 +0200
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Cc: kuster@pacbell.net, acmay@acmay.homeip.ne
Subject: IBM ocp I2C circular dependency
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i2c-adap-ibm_ocp.c uses
	i2c_iic_add_bus and i2c_iic_del_bus from i2c-algo-ibm_ocp.c

i2c-algo-ibm_ocp.c uses
	iic_ibmocp_waitforpin from i2c-adap-ibm_ocp.c

This makes it impossible to build as a module. I'am not shure how you want to
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
