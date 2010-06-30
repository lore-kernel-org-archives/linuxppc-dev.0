Return-Path: <jgpobox@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 1AD45B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 05:17:10 +1000 (EST)
Received: by gyd5 with SMTP id 5so672344gyd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 12:17:09 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4C2B9831.9020801@pobox.com>
Date: Wed, 30 Jun 2010 15:17:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v1]460EX on-chip SATA driver<resubmisison>
References: <201006241327.o5ODRY6m032299@amcc.com>
	<20100630115808.2D9241524EC@gemini.denx.de>
	<3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com>
	<20100630184728.C02D014EBF9@gemini.denx.de>
In-Reply-To: <20100630184728.C02D014EBF9@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, sr@denx.de, Rupjyoti Sarmah <rsarmah@apm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2010 02:47 PM, Wolfgang Denk wrote:
> Dear Rupjyoti Sarmah,
>
> In message<3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com>  you wrote:
>>
>> I took the mainline kernel v2.6.35-rc3 and downloaded using the git
>> download link.
>> I created the patch on 6/24/2010 after doing a git pull.
>
> I don;t think that you used v2.6.35-rc3; using this version, I still
> get this:
>
> drivers/ata/sata_dwc_460ex.c:43:1: warning: "DRV_NAME" redefined
> In file included from drivers/ata/sata_dwc_460ex.c:38:
> drivers/ata/libata.h:31:1: warning: this is the location of the previous definition
> drivers/ata/sata_dwc_460ex.c:44:1: warning: "DRV_VERSION" redefined
> drivers/ata/libata.h:32:1: warning: this is the location of the previous definition
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_scr_read':
> drivers/ata/sata_dwc_460ex.c:777: error: 'struct ata_port' has no member named 'ioaddr'
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_scr_write':
> drivers/ata/sata_dwc_460ex.c:793: error: 'struct ata_port' has no member named 'ioaddr'
> drivers/ata/sata_dwc_460ex.c: In function 'sata_dwc_error_intr':
> drivers/ata/sata_dwc_460ex.c:844: error: 'struct ata_port_operations' has no member named 'sff_check_status'

It looks like -your- build config is missing CONFIG_ATA_SFF or similar.

If you actually look at include/linux/libata.h, you see that struct 
ata_port_operations most definitely has a member named sff_check_status, 
for example.  Ditto ata_port and member ioaddr, etc.

	Jeff
