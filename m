Message-ID: <3EFAE8F1.4010406@dgt-lab.com.pl>
Date: Thu, 26 Jun 2003 14:37:05 +0200
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: pcf8563 and i2c kernel abstarct
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hell there.

I have some toubles using pcf8563_rtc driver. It causes 'kernel panic'
in rtc_rd function. I've done some debugging, ad discoverd what
back-follows:

- i2c_client *clnt is not set on call to rtc_rd
- it was called from pcf8563_rtc_init (by now = pcf8563_get_rtc_time();)
- clnt is created in pcf8563_attach
- prior call to i2c_add_driver(&pcf8563_driver) does not call
   pcf8563_attach, which should be caled from this part of
   i2c-core.c:i2c_add_driver:

/* now look for instances of driver on our adapters

               if (driver->flags& (I2C_DF_NOTIFY|I2C_DF_DUMMY)) {
                                for (i=0;i<I2C_ADAP_MAX;i++)
                                                 if (adapters[i]!=NULL)
                                                                  /*
Ignore errors */
      driver->attach_adapter(adapters[i]);


-this is because adapters[...] are not set


Q:
- did i miss anything adding this driver
- where and how adaptes should be set


?
I need only add support in ppc_md, so I can write my own functions to
implement talking with pcf8563. But... why to reinvent working (or not
?) code?


--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
