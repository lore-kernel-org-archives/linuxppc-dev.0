Return-Path: <kernelppc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 6FC58DDF89
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 19:18:00 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so993494nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 May 2008 02:17:57 -0700 (PDT)
From: "mojtaba" <kernelppc@gmail.com>
To: "'Sergey Temerkhanov'" <temerkhanov@yandex.ru>,
	<linuxppc-embedded@ozlabs.org>
References: <012401c8b9c3$74b947c0$5e2bd740$@com> <4831CCA2.6000107@yandex.ru>
In-Reply-To: <4831CCA2.6000107@yandex.ru>
Subject: RE: Instruction OCM
Date: Tue, 20 May 2008 11:19:26 +0200
Message-ID: <016b01c8ba5a$9a621000$cf263000$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you for your email. But what is the solution to that? I have seen this
in a thesis: 

"when using the OCM buses to connect memory, we can only use virtual memory
as long as the virtual address is the same as the physical address, which is
conceptually
the same as using a system without MMU. Therefore porting Linux to a
system based on an OCM memory system is not possible"

http://ce.et.tudelft.nl/publicationfiles/1367_700_thesis.pdf

Is that right? What do you suggest?

-----Original Message-----
From: linuxppc-embedded-bounces+kernelppc=gmail.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+kernelppc=gmail.com@ozlabs.org] On Behalf
Of Sergey Temerkhanov
Sent: Monday, May 19, 2008 8:53 PM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Instruction OCM

mojtaba wrote:
>
> Dear all,
>
> I cannot run Linux when I have an instruction OCM in my design but, 
> without instruction OCM everything is fine. I tried to do some 
> debugging. It seems that the Linux memory management unit has a 
> problem with that.  After entering the MMU initialization phase, it 
> suddenly jumps to address 0x00000700 it get stuck there. Is there 
> anybody who have tried a design with instruction OCM? Do I need to do 
> special configuration for the Linux kernel?
>
> Regards,
>
> Mojtaba
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
Address 0x700 means invalid opcode exception.
If instruction OCM is same as data OCM (I think it's so) then any MMU 
mapping is not applicable to this region at all as OCM controller 
decodes virtual addresses bypassing any MMU mappings.
In your situation MMU maps virtual address of OCM to physical address 
containing some random data and CPU tries to execute it. So you get 
invalid opcode exception.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
