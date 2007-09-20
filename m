Return-Path: <samppa@sundmangroup.com>
Received: from proxy3.bredband.net (proxy3.bredband.net [195.54.101.73])
	by ozlabs.org (Postfix) with ESMTP id 2F049DDE20
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 21:48:01 +1000 (EST)
Message-ID: <14733.194.237.142.6.1190286678.squirrel@www.sundmangroup.com>
In-Reply-To: <200709201322.08359.laurentp@cse-semaphore.com>
References: <AEA1A32F001C6B4F98614B5B80D7647D02D73DEB@esealmw115.eemea.ericsson.se>
	<AEA1A32F001C6B4F98614B5B80D7647D02D73F76@esealmw115.eemea.ericsson.se>
	<200709201322.08359.laurentp@cse-semaphore.com>
Date: Thu, 20 Sep 2007 13:11:18 +0200 (CEST)
Subject: Re: 8270 & Watchdog - early start - II
From: samppa@sundmangroup.com
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

>>> You still shouldn't use direct access with MMU enabled. Use the global
CPM
> mapping and the I/O access macros.

I understand, but I need to kick on the WDT before "cpm2_immr"
is initialized dur to timing constraints.

Cheers // Matias



> On Thursday 20 September 2007 12:06, Matias Sundman wrote:
>> Hi Guys,
>> The Software Service Register (SWSR) is 16-bit wide which Laurent
>> Pinchart [laurentp@cse-semaphore.com] so nicely pointed out for me.
>> So it actually works with;
>> *((volatile unsigned short*)(0xf001000e))=0x556c;
>> *((volatile unsigned short*)(0xf001000e))=0xaa39;
>
> You still shouldn't use direct access with MMU enabled. Use the global CPM
> mapping and the I/O access macros.
>
> out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0x556c);
> out_be16(&cpm2_immr->im_siu_conf.siu_82xx.sc_swsr, 0xaa39);
>
> Best regards,
>
> --
> Laurent Pinchart
> CSE Semaphore Belgium
>
> Chaussée de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
>
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
