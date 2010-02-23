Return-Path: <Kari.Davidsson@marel.com>
Received: from mail.marel.com (mail.mymarel.com [213.167.134.75])
	by ozlabs.org (Postfix) with ESMTP id 2640AB7D05
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Feb 2010 02:59:41 +1100 (EST)
Message-ID: <4B83FA1C.8000902@marel.com>
Date: Tue, 23 Feb 2010 15:54:04 +0000
From: =?UTF-8?B?S8OhcmkgRGF2w63DsHNzb24=?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Subject: Re: [PATCH v4 04/11] mtd: Add MPC5121 NAND Flash Controller driver
References: <1265377377-29327-5-git-send-email-agust@denx.de>	<1266255305-29224-1-git-send-email-agust@denx.de>
	<1266307868.11659.177.camel@localhost>
In-Reply-To: <1266307868.11659.177.camel@localhost>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Anatolij Gustschin <agust@denx.de>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Any special reason this in MPC5121 Revision 2 only?
I did not see anything that contradicted the rev 3 manual in the code.

But there is one harmless bug (since the NFC_CMD_FAIL symbol is never used), i.e.

git diff
diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 191bf99..38a99ef 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -100,7 +100,7 @@
  #define NFC_OUTPUT             (1 << 3)
  #define NFC_ID                 (1 << 4)
  #define NFC_STATUS             (1 << 5)
-#define NFC_CMD_FAIL           (1 << 15)
+#define NFC_CMD_FAIL           (1 << 14)
  #define NFC_INT                        (1 << 15)

  /* Bit Definitions: NFC_WRPROT */

The NAND chip is is detected (given that I disable the Revison check),
but the /dev7mtd0 is not accessable as block device. Is that normal?
The UBIFS also gives up I am assuming because the /dev/mtd0 is not block device.

rg
kd

On 02/16/2010 08:11 AM, Artem Bityutskiy wrote:
> On Mon, 2010-02-15 at 18:35 +0100, Anatolij Gustschin wrote:
>> Adds NAND Flash Controller driver for MPC5121 Revision 2.
>> All device features, except hardware ECC and power management,
>> are supported.
>>
>> Signed-off-by: Piotr Ziecik<kosmo@semihalf.com>
>> Signed-off-by: Wolfgang Denk<wd@denx.de>
>> Signed-off-by: Anatolij Gustschin<agust@denx.de>
>> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>> Cc:<linux-mtd@lists.infradead.org>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: John Rigby<jcrigby@gmail.com>
>> ---
>> Changes since v3:
>>   - include 'asm/mpc5121.h' header instead of 'asm/mpc5xxx.h'.
>>     This change is needed because arch patch adding reset
>>     module definition was reworked and doesn't add mpc5121
>>     specific definitions to common header for mpc52xx/mpc5121.
>>
>> Changes since v2:
>>   - move the arch bits into separate patch
>>     (it is the next patch in this series now)
>>   - use __devinit/__devexit/__devexit_p and __devinitdata
>>
>> Changes since v1:
>>   - add logfile with changes since previous version
>>
>> Changes since the patch version submitted in May 2009:
>>
>>   - move mpc5121_nfc.h to the driver .c as there is only one user
>>   - remove DRV_VERSION macro
>>   - replace printk() by dev_*()
>>   - drop unnecessary .suspend and .resume initializations
>>   - remove duplicate .name/.owner settings
>>   - fix mpc5121_nfc_init() to "return of_register_platform_driver(&mpc5121_nfc_driver);"
>>   - move module_init() to just below the init function
>>   - remove MODULE_VERSION
>>   - use "mtd: Add MPC5121 NAND Flash Controller driver" as the subject,
>>     previously it was "mpc5121: Added NAND Flash Controller driver.
>>
>>   drivers/mtd/nand/Kconfig       |    7 +
>>   drivers/mtd/nand/Makefile      |    1 +
>>   drivers/mtd/nand/mpc5121_nfc.c |  916 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 924 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/mtd/nand/mpc5121_nfc.c
>
> Pushed to my l2-mtd-2.6.git / dunno.
>
