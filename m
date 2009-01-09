Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6b.your-server.co.za [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A285476A7
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 00:33:17 +1100 (EST)
Message-ID: <49675205.9010800@vastech.co.za>
Date: Fri, 09 Jan 2009 15:32:53 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: Trouble moving custom MPC8548 board to U-boot 1.3
References: <49635C62.5090307@vastech.co.za>
	<1231260769.21398.5.camel@ld0161-tx32>
In-Reply-To: <1231260769.21398.5.camel@ld0161-tx32>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms060701060001010106020805"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms060701060001010106020805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,
>> I have spent quite some time trying to move from U-Boot 1.2 to a newer
>> version.. I am stuck at the initialization of the ram. The ram checksum
>> fails and gives me a "total memory of 0". (the board has 512MB and work
>> when booting uboot 1.2)
>>
>> can anyone pls. point me in the right direction?
>>
>>     
> This is your root cause:  Unable to get the SPD information
> for the DDR DIMM in slot 0 of controller 0.
>
> What part are you using?  Does it support SPD?
> Is your I2C to it hooked up correctly?
> Can you dump the SPD information that is read?
> Does it match the part specs?
>
> HTH,
> jdl
I have managed to read the SPD data for the dram. I also confirmed that
the dram control and timing settings correspond to the settings that
worked in the previous uboot.
 I am now able to run uboot up to the "relocate_code". The new Stack
pointer is set to 0x0FF8DF58 witch is close enough to what i expected.
This is however where the board hangs. (The board also hang when running
the "testram").  I tried reading the data at the new stack pointer but
get "SAP: read access failed"  i get the same error when trying to read
any address within the RAM or any address of other devices.  This leads
me to think that my LAW or TLB setup is incorrect.

Looking at LAW setup: (based on board sbc8548)

    /* LAW(Local Access Window) configuration:
     * 0x0000_0000     0x1fff_ffff     DDR             512M/Auto
     * 0x8000_0000     0xbfff_ffff     PCI1 MEM        1G
     * 0xc000_0000     0xcfff_ffff     PCI1 IO         16M
     * 0xe000_0000     0xffff_ffff      LBC                       512M */
     
    struct law_entry law_table[] = {
    #ifndef CONFIG_SPD_EEPROM
            SET_LAW(CONFIG_SYS_DDR_SDRAM_BASE, LAWAR_SIZE_512M,
    LAWAR_TRGT_IF_DDR),
    #endif
            SET_LAW(CONFIG_SYS_PCI1_MEM_PHYS, LAWAR_SIZE_1G,
    LAWAR_TRGT_IF_PCI1 ),
            SET_LAW(CONFIG_SYS_PCI1_IO_PHYS, LAWAR_SIZE_16M,
    LAWAR_TRGT_IF_PCI1),
            SET_LAW(CONFIG_SYS_LBC_BASE, LAWAR_SIZE_512M, LAWAR_TRGT_IF_LBC)
    };

Since my board uses SPD_EEPROM, where does the LAW entry for DDR get
initilized or should the #ifndef statement be removed?



Am I on the  right track to solving my problem?



--------------ms060701060001010106020805
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
fm/CvZ7jaL+Z+M24w9UfxQAAAAAAAA==
--------------ms060701060001010106020805--
