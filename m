Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 5B13B679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 03:50:37 +1000 (EST)
In-Reply-To: <20060728173519.55388.qmail@web33312.mail.mud.yahoo.com>
References: <20060728173519.55388.qmail@web33312.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7348068C-0799-4FE1-A149-DE8043ABB81E@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: using /dev/mem to talk to peripherals on VIIP system
Date: Fri, 28 Jul 2006 13:51:03 -0400
To: scott <scotto2hot-green@yahoo.com>
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


On Jul 28, 2006, at 1:35 PM, scott wrote:

>   ptr = MAP_FAILED; // Initialize to bad value
>   ptr = (int *) mmap(0, 256, PROT_READ|PROT_WRITE, MAP_SHARED, fd,  
> USER_LOGIC_BASEADDR);

Well, this isn't going to detect an error, since the error code
is returned instead of an address.

>
>   if(ptr==MAP_FAILED) {

	if ((int)ptr == -1) {
>     printf("Err: cannot access address!\n");
>     return -1;
>   }
>

> ....  Any other thoughts?

Your mmap is failing because the size is not modulo PAGE_SIZE.


	-- Dan
