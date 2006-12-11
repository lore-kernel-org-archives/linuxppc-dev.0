Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD59167C61
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 01:33:58 +1100 (EST)
Message-ID: <457D6C4F.6090303@pobox.com>
Date: Mon, 11 Dec 2006 09:33:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
	DMA_NONE
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
	<20061211140258.GB18947@htj.dyndns.org>
	<200612111518.46887.arnd@arndb.de>
In-Reply-To: <200612111518.46887.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Tejun Heo <htejun@gmail.com>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 11 December 2006 15:02, Tejun Heo wrote:
>>  {
>>         struct scatterlist sg;
>> +       unsigned int n_elem = 0;
>>  
>> -       sg_init_one(&sg, buf, buflen);
>> +       if (dma_dir != DMA_NONE) {
>> +               WARN_ON(!buf);
>> +               sg_init_one(&sg, buf, buflen);
>> +               n_elem++;
>> +       }
>>  
> Ok, looks good as well. I still think we should have the WARN_ON()
> in sg_set_buf(), but I can send a separate patch for that to linux-mm.

Please CC me and linux-ide on all libata patches (certainly akpm as 
well).  Andrew picks up most of the libata changes automatically via git 
from my libata-dev.git#ALL.

	Jeff
