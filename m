Date: Fri, 25 Apr 2003 10:32:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Nikunj A. Dadhania" <nikunj.dadhania@fci.com>
Cc: Linux PPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FEC driver doesn't compile
Message-ID: <20030425173245.GA19922@ip68-0-152-218.tc.ph.cox.net>
References: <1051259707.12150.60.camel@127.0.0.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1051259707.12150.60.camel@127.0.0.1>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 25, 2003 at 02:05:08PM +0530, Nikunj A. Dadhania wrote:

> Hi all,
>
> I was trying to compile the FEC driver without MDIO for PHY
> configuration, it gives an error as follows:
>
> I am using linux kernel 2.4.20 from kernel.org.
>
> make[2]: Entering directory
> `/build/usr/nikunj/work/atca/src/linux-2.4.20/arch/ppc/8xx_io'
> powerpc-linux-gcc -D__KERNEL__
> -I/build/usr/nikunj/work/atca/src/linux-2.4.20/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer
> -I/build/usr/nikunj/work/atca/src/linux-2.4.20/arch/ppc -fsigned-char
> -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
> -mcpu=860   -nostdinc -iwithprefix include -DKBUILD_BASENAME=fec  -c -o
> fec.o fec.c
> fec.c: In function `fec_enet_init':
> fec.c:1911: structure has no member named `old_status'
> fec.c: At top level:
> fec.c:1373: warning: `mii_link_interrupt' defined but not used
> make[2]: *** [fec.o] Error 1
>
>
> A quick look into the code of arch/ppc/8xx_io/fec.c, the
> fec_enet_private structure has defined old_status under the
> CONFIG_USE_MDIO define and in function fec_enet_init the variable
> fec->old_status is accessed outside CONFIG_USE_MDIO.
>
> I guess the old_status variable could be kept outside the
> CONFIG_USE_MDIO in the structure declaration.

It's the other way around actually.  This is fixed in 2.4.21-rc1.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
