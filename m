Date: Tue, 30 May 2000 11:11:31 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: rpx_cfg() copy to NVRAM?
Message-ID: <Pine.LNX.3.96.1000530110746.8009A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I just noticed the following snippet in rpx_cfg() :

        iic_read(0xa8, eebuf, 0, 128);
        iic_read(0xa8, &eebuf[128], 128, 128);
        {
                int i;
                cp = (u_char *)0xfa000000;

                for (i=0; i<256; i++)
                        *cp++ = eebuf[i];
        }

It appears to be copying the eeprom data to NVRAM.  Is anyone using this?
Can I safely take it out?  We have RPX boards that don't have NVRAM and
this seems a little pointless.

I'm in the process of changing head.S and embed_config.c to work with the
new EP bootloader.

-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
