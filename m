Return-Path: <Bo.Liu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4B647B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 18:52:06 +1100 (EST)
Message-ID: <4CBD4EFB.6070603@windriver.com>
Date: Tue, 19 Oct 2010 15:55:39 +0800
From: Tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Maria Johansen <m.johansen@no.parkairsystems.com>
Subject: Re: eSDHC controller driver on MPC8308rdb
References: <DF61B4AD1C20A54EADF5C05E1F1110DE08D449@Exchange.parkairsystems.net>
	<4CBC04E8.5030706@windriver.com>
	<DF61B4AD1C20A54EADF5C05E1F1110DE08D44C@Exchange.parkairsystems.net>
In-Reply-To: <DF61B4AD1C20A54EADF5C05E1F1110DE08D44C@Exchange.parkairsystems.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: Bo.Liu@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maria Johansen wrote:
>   
>> -----Original Message-----
>> From: Tonyliu [mailto:Bo.Liu@windriver.com] 
>> <snip>
>>     
>>> Could this be a problem related the eSDHC controller (or the driver), 
>>> or is it the memory card? (a 4GB SanDisk Extreme SDHC card, which unfortunately is the only card I have available at the moment.) I will keep digging into drivers/mmc/host/sdhci.c in search of a solution, and any tips to how I should proceed would be greatly appreciated!
>>>   
>>>       
>> Hi,
>> Try the patch in attatchment. By default, on some e300 platforms such as mpc8308_rdb, the entry "clock-frequency" of section sdchi in DTB is not fixed by u-boot, so has to >caculate the input clock for sdhci controller explicitly in driver.
>>
>> Tony
>>     
>
> Thanks, the missing clock-frequency was part of my problem. The rest was solved by adding some more quirks to the esdhc-driver (SDHCI_QUIRK_FORCE_1_BIT_DATA and SDHCI_QUIRK_RESET_AFTER_REQUEST). Why it is necessary to force 1-bit data transfers I am a bit unsure about, since the mpc8308 reference manual clearly states that 4-bit transfers are supported.
>   
Actually, I did use 4-bit mode. You can try another 2 quicks:

+   if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+       host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+
+   if (of_get_property(np, "sdhci,broken-timeout", NULL))
+       host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+

===================================================
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d4fdfa..b7a1ce4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -807,8 +807,12 @@ static void sdhci_set_transfer_mode(struct 
sdhci_host *host,
    WARN_ON(!host->data);

    mode = SDHCI_TRNS_BLK_CNT_EN;
-   if (data->blocks > 1)
+   if (data->blocks > 1) {
+       if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
+           mode |= SDHCI_TRNS_MULTI | SDHCI_TRNS_ACMD12;
+       else
        mode |= SDHCI_TRNS_MULTI;
+   }
    if (data->flags & MMC_DATA_READ)
        mode |= SDHCI_TRNS_READ;
    if (host->flags & SDHCI_REQ_USE_DMA)
@@ -1099,6 +1103,13 @@ static void sdhci_request(struct mmc_host *mmc, 
struct mmc_request *mrq)
    sdhci_activate_led(host);
 #endif

+   if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12) {
+       if (mrq->stop) {
+           mrq->data->stop = NULL;
+           mrq->stop = NULL;
+       }
+   }
+
    host->mrq = mrq;


I don't have patch for upstream, you can add them manually.

Tony
> Thanks for your help :)
>
> --
> Maria
>
>
>
>
>   
