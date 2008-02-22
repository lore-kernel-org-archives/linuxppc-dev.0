Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 954A5DDDEF
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 19:01:44 +1100 (EST)
Message-ID: <47BF1089.8060204@freescale.com>
Date: Fri, 22 Feb 2008 12:12:25 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, jdl@jdl.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add support for binary includes.
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080222053450.GH3064@localhost.localdomain>
In-Reply-To: <20080222053450.GH3064@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

>> node {
>> 	prop = /incbin/("path/to/data");
>> };
>>
>> node {
>> 	prop = /incbin/("path/to/data", 8, 16);
>> };
>
> I still dislike the syntax, but haven't thought of a better one yet.
> There are some issues with the implementation too, but I've been a bit
> too busy with ePAPR stuff to review properly.

I'm OK with the syntax, but whatever-ish.

Would these be better?:

    prop = /call/(incbin, "path/to/data", 17, 23);
    prop = /call[incbin]/("path/to/data");
    prop = /call incbin/("path/to/data", 12, 12+10);

What is the aspect of the syntax that you don't like?
I think we essentially need to stick in the /.../ realm
to be consistent with the other non-standard names being
used, like /include/.

I can see a generalized form that allows other pre-defined
or user-defined "functions" to be introduced and called
or used in a similar way:

    prop = <(22 + /fibonacci/(7)) 1000>;

    prop = /directoryof/("/path/to/some/file.doc");

    interrupt-map = /pci_int_map/(8000, 2, 14);

or whatever.  We can paint this bikeshed for a long time
if we need to.  Or, we can get down to some serious issue
if there are any.  Are there?

jdl
