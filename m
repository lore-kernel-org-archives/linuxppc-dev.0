Message-ID: <83E3831A88E65844B01DB1A73FB66F93140829@CSDNT99.cdcgy.com>
From: "Dang, James" <James.Dang@gdcanada.com>
To: "'greggiraud@netcourrier.com'" <greggiraud@netcourrier.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260ADS
Date: Thu, 10 Apr 2003 09:42:00 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


PPCBoot, when comes up, will relocate IMMR from CFG_DEFAULT_IMMR to
CFG_IMMR. The CFG_DEFAULT_IMMR value must match your HRCW setting for your
processor. Therefore, when ppcboot transfers control to linux, linux kernel
needs to know where is the new IMMR location. That's why ppcboot CFG_IMMR
and linux IMAP_ADDR have to be the same.

For your BCSR and others, use ioremap().

James Dang

-----Original Message-----
From: greggiraud@netcourrier.com [mailto:greggiraud@netcourrier.com]
Sent: Thursday, April 10, 2003 11:20 AM
To: linuxppc-embedded@lists.linuxppc.org
Cc: James.Dang@gdcanada.com
Subject: MPC8260ADS

So you said that for my MPC8260ADS (I am using a MPC8266ADS, it is the
same...) board, I had to put My IMMR to 0xF0000000 on
ppcboot/include/configs/mpc8260ads.h, instead of 0x04700000. Moreover you
said that for my kernel IMAP register had to be the same (0xF0000000)

OK but why?
Moreover the MPC8260ADS has BCSR registers mapped at 0x04500000...
So I won't be able to use them?

I know that internal registers can be moved with the IMMR register. But what
about the BCSR and the others registers?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
