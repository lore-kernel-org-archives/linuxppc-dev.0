Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: mesenb@vss.fsi.com,
	"PPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
From: "Allen Curtis" <acurtis@directvinternet.com>
Subject: Re: booting Linux on est8260 using FCC2
Date: Wed, 16 Oct 2002 09:26:31 -0700 (PDT)
Message-Id: <20021016092631.9933.h006.c007.wm@mail.directvinternet.com.criticalpath.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> CONFIG_FEC_ENET is correct.  I do not have any history with this problem
> but a co-worker of mine does.  Back in the early Linux 2.4 days he was
> experiencing the same type of problem.  He remembers that he received
> some code from outside the source tree which solved the problem.  That
> was about a year ago.  Windriver was chosen as the operating system and
> the Linux code has long been deleted.  Nothing seems to jog his memory
> when he looks at the 2.4.20 source.  Of course early 2.4 to 2.4.20 is a
> lifetime ago.  I don't think I am doing anything out of the norm.  I use
> the arch/ppc/configs/est8260_defconfig for my starting point and then I
> disable CONFIG_SCC_ENET and enable CONFIG_FEC_ENET.

1. Did this work until you wanted to bootp?
2. Did you confirm that 8260_io/fcc_enet.c is configured with the same RX/TX
clocks as your hardware? (I had to change this and submitted patches to make this
a configuration option. Never made it into the tree.)
3. If you are not using MII to sense the speed, the driver initializes to
half-duplex. Look at this driver initilization if this is a potential problem.

Hope this helps.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
