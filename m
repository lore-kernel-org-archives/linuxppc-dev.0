Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 539ECDE3B2
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:10:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m2PM9uc5024734
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 15:09:57 -0700 (MST)
Message-ID: <47E9783F.4@freescale.com>
Date: Tue, 25 Mar 2008 17:10:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Jon Loeliger <jdl@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: dtc: Simplify error handling for unparseable input
References: <20080324034424.GC29985@localhost.localdomain>
	<20080324173641.GA22159@loki.buserror.net>
	<20080325012805.GA1227@localhost.localdomain>
	<20080325143619.GB13187@ld0162-tx32.am.freescale.net>
	<20080325212127.GA8281@localhost.localdomain>
In-Reply-To: <20080325212127.GA8281@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Tue, Mar 25, 2008 at 09:36:19AM -0500, Scott Wood wrote:
>> On Tue, Mar 25, 2008 at 12:28:05PM +1100, David Gibson wrote:
>>> On Mon, Mar 24, 2008 at 12:36:41PM -0500, Scott Wood wrote:
>>>> If you remove this, there'll be no way to indicate semantic errors other
>>>> than die() (the NULL approaches are no good, since they inhibit recovery),
>>>> which is suboptimal if the error is not immediately fatal.
>>> But everything is immediately fatal.  When we have a *real* example of
>>> something that's not, we can restore an error code.
>> Failed binary includes are not immediately fatal.
> 
> And is there any advantage to having them not immediately fatal?

It's generally nice to the user if you can report as many bugs as you 
can rather than fail on the first one.

It's also nice to someone down the road trying to turn this code into a 
library if it passes return status up the call chain gracefully.

-Scott
