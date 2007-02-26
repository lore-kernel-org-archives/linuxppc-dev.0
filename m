Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF115DDD05
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 07:52:00 +1100 (EST)
In-Reply-To: <1172505099.11949.13.camel@localhost.localdomain>
References: <200612112059.kBBKx1j7022473@hera.kernel.org>
	<1172448057.3971.9.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0702251614420.12485@woody.linux-foundation.org>
	<1172452660.3971.33.camel@shinybook.infradead.org>
	<1172505099.11949.13.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <21943DC0-5FA7-4769-9EFD-6A0461C5664A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Make sure we populate the initroot filesystem late enough
Date: Mon, 26 Feb 2007 14:51:00 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	john stultz <johnstul@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 26, 2007, at 9:51 AM, Benjamin Herrenschmidt wrote:

> On Sun, 2007-02-25 at 20:17 -0500, David Woodhouse wrote:
>> On Sun, 2007-02-25 at 16:24 -0800, Linus Torvalds wrote:
>>> Hmm. No, I don't think that should be a problem. free_initmem() only
>>> happens at the very, after do_basic_setup() has been run, which
>>> includes all the initcall stuff.
>>
>> I'm inclined to agree that it _shouldn't_ be a problem. Nevertheless,
>> even this hack seems sufficient to 'fix' it:
>
> Could be a powerpc specific bug in initrd handling... I'm still
> traveling so I can't really look at it right now, but I wouldn't be
> surprised if some of that code did indeed bitrot.
>
> Ben.

Could there be some issue with initrd getting reserved properly via  
prom_init.c.  I know we make sure there are memreserve's in the fdt  
for initrd on embedded ppc.

- k
