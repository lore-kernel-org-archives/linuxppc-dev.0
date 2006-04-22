Return-Path: <stefan.eletzhofer@inquant.de>
Received: from gonzo.webpack.hosteurope.de (gonzo.webpack.hosteurope.de
	[217.115.142.69])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4688679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 21:55:34 +1000 (EST)
In-Reply-To: <200604212332.55123.antonio.dibacco@aruba.it>
References: <20060421202308.D508F3526B7@atlas.denx.de>
	<200604212332.55123.antonio.dibacco@aruba.it>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <27FB8E28-233C-42CF-9C2A-696C70BF45C1@inquant.de>
From: Stefan Eletzhofer <stefan.eletzhofer@inquant.de>
Subject: Re: Upgrading cramfs root file system while running (DENX wrote that
	is not possible)
Date: Sat, 22 Apr 2006 13:40:20 +0200
To: Antonio Di Bacco <antonio.dibacco@aruba.it>
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

Hi,

Am 21.04.2006 um 23:32 schrieb Antonio Di Bacco:

> Little bit off topic:
> I decided to adopt a different strategy, the sw download web page  
> will contain
> a java applet that will act as a tftp server, then the board will  
> be rebooted
> and an environment variable will instruct the u-boot to tftp the  
> new software
> from the applet. What do you think? I know that applets cannot read  
> local
> files on the PC, unless they have a valid certificate but the user  
> should
> trust me.

nice idea IMHO. Is that applet available somewhere? That would surely  
fit my needs
(and others probably, too).

Cheers,
Stefan.

>
> Bye,
> Antonio.
>
> On Friday 21 April 2006 22:23, Wolfgang Denk wrote:
>> In message <200604210853.32860.david.jander@protonic.nl> you wrote:
>>> What do you mean with "something bad could happen"?
>>
>> System crashes.
>>
>>> The only thing I can think of is pulling the power plug while  
>>> flash is
>>> being erased or written. What else could go wrong?
>>
>> The kernel may try to (re-) load some pages of a  running  executable
>> or  library  which  is  no  longer  available  (at  least  not at the
>> addresses where they used to be). The kernel will either stumble over
>> what it believes to be a corrupted file system,  or  load  the  wrong
>> data -> kaboom.
>>
>>> We do the following: system running from read-only jffs2 partition.
>>> Sometimes that partition is remounted read-write and single files  
>>> are
>>> replaced, but in some occasions we need to upgrade the whole fs.  
>>> In that
>>> case a CGI lodas the image into a ramdisk, and the upgrade  
>>> process is
>>> started. For upgrade,
>>
>> You *have* to unmount the old file system here.
>>
>>> partition, and then "dd" again to copy the image. At that point no
>>> critical flash-read access should be requested since dd is  
>>> already in
>>> cache (it's
>>
>> The kernel might reload any page of any running executable or  
>> library.
>>
>> Best regards,
>>
>> Wolfgang Denk
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
