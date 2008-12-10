Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id DCA8B474C3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 17:27:14 +1100 (EST)
Date: Tue, 09 Dec 2008 22:27:06 -0800
Subject: Indirect DCR Access
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C564A13A.135C2%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh:

In working through the PPC4XX "memory-controller","ibm,sdram-4xx-ddr2"
adapter driver for the EDAC MC driver, there are a substantial number of
indirect DCR accesses.

Ideally, I would use the address and data DCRs implied from the SDRAM0
dcr-reg device tree property; however, the mtdcri and mfdcri are
mnemonic-only at present. Consequently, I've done:

    #define DCRN_SDRAM0_BASE        0x010
    #define DCRN_SDRAM0_CONFIG_ADDR (DCRN_SDRAM0_BASE+0x0)
    #define DCRN_SDRAM0_CONFIG_DATA (DCRN_SDRAM0_BASE+0x1)

    #define mfsdram(reg)        mfdcri(SDRAM0, SDRAM_ ## reg)
    #define mtsdram(reg, value) mtdcri(SDRAM0, SDRAM_ ## reg, value)

for the short-term.

Is there a long-term strategy or set of options under discussion about
expanding the DCR accessors in dcr.h to include indirect access from a
device tree property as in the case above?

It appears that the processors that use this memory controller core all have
the same DCR address and data registers, so this isn't a huge portability
issue for the immediate future; however, I endeavor to get things as close
to "best practices" as possible up front.

Regards,

Grant
