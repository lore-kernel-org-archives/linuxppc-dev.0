Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id C04F567BB2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 22:46:39 +1000 (EST)
Message-ID: <452E3930.8040101@ru.mvista.com>
Date: Thu, 12 Oct 2006 16:46:40 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: robert corley <rdcorle@yahoo.com>
Subject: Re: plb_temac, ML403, linux 2.4.26, EDK 7.1
References: <20061011204632.80180.qmail@web56309.mail.re3.yahoo.com>
In-Reply-To: <20061011204632.80180.qmail@web56309.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robert,

There is no support for TEMAC in MontaVista Linux 3.1. It has been added in MVL 4.0.1.
In 3.1 there is the gige driver, but gige is for ML300's optical gigabit ethernet, not for TEMAC.

Thanks,
Andrei

robert corley wrote:
> Ming;
> 
> Here is what the EDK generates in this file:
> 
> C:\EDK\projects\startup_network\ppc405_0\libsrc\linux_mvl31_v1_01_a\linux\arch\ppc\platforms\xilinx_ocp\xparameters_ml300.h
> 
> <snip>
> #define XPAR_XTEMAC_NUM_INSTANCES 1
> #define XPAR_PLB_TEMAC_0_BASEADDR 0x60000000
> #define XPAR_PLB_TEMAC_0_HIGHADDR 0x60003FFF
> #define XPAR_PLB_TEMAC_0_DEVICE_ID 0
> #define XPAR_PLB_TEMAC_0_IPIF_RDFIFO_DEPTH 131072
> #define XPAR_PLB_TEMAC_0_IPIF_WRFIFO_DEPTH 131072
> #define XPAR_PLB_TEMAC_0_MAC_FIFO_DEPTH 64
> #define XPAR_PLB_TEMAC_0_DMA_TYPE 3
> #define XPAR_PLB_TEMAC_0_TEMAC_DCR_HOST 0
> #define XPAR_PLB_TEMAC_0_INCLUDE_DRE 1
> <snip>
> 
> 
> Which is fine.  However, the file in the linux distribution: linux_2_4_devel/drivers/net/xilinx_enet/adapter.c is looking for "XEMAC" instead of "XTEMAC" as above.
> 
> Also, when I look at the EDK project directory 
> 
> "C:\EDK\projects\startup_network\ppc405_0\libsrc\linux_mvl31_v1_01_a\linux\drivers\net\"
> 
> I see that it is empty.  Which means that nothing in the MVL tree will be overwritten (specifically the adapter.c file, which uses the above defines).
> 
> So, it appears that the driver is not being properly insterted into the tree as expected.  Would you agree?
> 
> -R
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
