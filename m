Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Ppc Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: 8260 Network Performance update
Date: Thu, 6 Jun 2002 05:41:39 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFCEECDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3CFEF5FC.6050301@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> link parameters.  You could try increasing the number of receive buffers
> in the Ethernet driver, and I guess we should modify the driver to DMA
> directly into skbufs.  I would be surprised if either of these last two
> would increase the performance, but I've been surprised by a few
> things lately :-).

The table below is performance vs. number of driver buffers. (16 - 64)

			10T Hub	|	100BT switch
		 -------------------------------------|
	16 RTB |	440KBps	|	190KBps	  |
		 --------------------------------------
	32 RTB |	450KBps	|	230KBps	  |
		 --------------------------------------
	64 RTB |	450KBps	|	240KBps	  |
		 --------------------------------------

There is a slight improvement when you increase the number of buffers from
16 (default) to 32. There does not appear to be any benefit beyond that.

I am guessing that the problem is not in the driver unless the driver is
suppose to enforce some soft of fair usage algorithm. Is there a network
usage scheduler of some kind? I do not have this problem on a x86 RedHat
system...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
