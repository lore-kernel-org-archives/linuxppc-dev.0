Return-Path: <hollis@penguinppc.org>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.130])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e32.co.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 40CA72BF07
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 03:52:46 +1100 (EST)
Received: from westrelay03.boulder.ibm.com (westrelay03.boulder.ibm.com
	[9.17.195.12])
	by e32.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j05Gq5FJ755400
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 11:52:10 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay03.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j05Gq5ws285454
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 09:52:05 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j05Gq4fh004927
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 09:52:05 -0700
In-Reply-To: <200501051718.19198.pguyot@cvf.fr>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<C9ACD772-5F30-11D9-A2C3-000A95A0560C@penguinppc.org>
	<20050105160816.GA28046@pegasos> <200501051718.19198.pguyot@cvf.fr>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1F68CEAC-5F3A-11D9-A2C3-000A95A0560C@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Wed, 5 Jan 2005 10:52:02 -0600
To: Philippe Guyot <pguyot@cvf.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 5, 2005, at 10:18 AM, Philippe Guyot wrote:
> On Wednesday 05 January 2005 17:08, Sven Luther wrote:
>> On Wed, Jan 05, 2005 at 09:45:13AM -0600, Hollis Blanchard wrote:
>>>
>>> The size of that partition depends on firmware limitations. I have
>>> definitely seen reports of systems not booting when the PReP boot
>>> partition was too large. I think on some systems that has even 
>>> happened
>>> at 8MB.
>>
>> Is the problem really the size of the partition, or the space used by 
>> the
>> kernel. I mean we could make a 100MB partition at start, and since we 
>> just
>> dd the kernel to it, the kernel would be found at the start of the
>> partition, and the firmware probably doesn't care about the real size 
>> of
>> the partition, as long as it can access all the kernel data we dded 
>> to it,
>> no ?
>
> I agree, see the IEEE P1275 on solinno's site. OF determines the load 
> image
> length and transfers only that. I was able to verify that by dumping 
> storage
> after a "load" when debugging boot process.

Are you specifically talking about booting from a PReP partition and 
not a floppy disk or netboot? Did you dump the bytes from the disk just 
after the kernel and see if they were also present in memory?

I have no doubt that OF will correctly load an ELF file, but a PReP 
boot partition does not contain an ELF file.

>> Do we have some documentation of the firmware limitations ?
>
> Yes, on solinnos's site.

That page (http://www.solinno.co.uk/7043-140/getstarted.php) doesn't 
mention any restrictions on the size of the PReP boot partition, so 
it's clearly not a complete list. :)

-Hollis
