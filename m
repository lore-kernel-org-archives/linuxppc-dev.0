Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx3.magma.ca (unknown [209.217.78.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5000B679F6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 03:55:51 +1000 (EST)
Received: from mail2.magma.ca (mail2.internal.magma.ca [10.0.10.12])
	by mx3.magma.ca (8.13.0/8.13.1) with ESMTP id k49Hth2U001307
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 May 2006 13:55:43 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail2.magma.ca (Magma's Mail Server) with ESMTP id k49HtdVo006071
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 May 2006 13:55:43 -0400
Message-ID: <4460D79F.2060001@ics-ltd.com>
Date: Tue, 09 May 2006 13:55:43 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: system hang in early_init
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It seems that my PPC405 V2Pro system is hanging in the function 
early_init, in arch/ppc/kernel/setup.c. Using LEDs, I've been able to 
determine that the following line seems to be where it dies:
memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);

Looking in System.map, I see that __bss_start is 0xC013F000 and _end is 
0xC014DA60, with a whole bunch of stuff in between.
Any idea what might cause this?

Regards,
Chris
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
