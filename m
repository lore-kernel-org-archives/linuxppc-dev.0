Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 4FEB0B713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 04:56:52 +1000 (EST)
Received: by ywg8 with SMTP id 8so3439111ywg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Sep 2010 11:56:49 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100901.082729.135524471.davem@davemloft.net>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
	<20100901.082729.135524471.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Sep 2010 12:56:29 -0600
Message-ID: <AANLkTimkh6ytDmiCQY-gZLHpLzeux1RwMFyr=HyfcDaJ@mail.gmail.com>
Subject: Re: ERR_PTR pattern in phylib
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: netdev@vger.kernel.org, afleming@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 1, 2010 at 9:27 AM, David Miller <davem@davemloft.net> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> Date: Wed, 1 Sep 2010 08:42:49 -0600
>
>> It seems to me that phylib is one of the cases where the users (the
>> network drivers) don't actually care about the specific error code
>> when calling phylib functions. =A0The drivers only seem to care whether
>> or not the function failed, and if it did then bail out. =A0I've also
>> noticed that using the "if (!ptr)" test on phylib return values is a
>> common error for driver writers.
>>
>> In the interest of making driver code easier to write and review,
>> would you be opposed to a set of patches to remove the ERR_PTR()
>> pattern from phylib and its users?
>
> I'm opposed to it because it means that if code actually does
> care about the error code it will no longer be able to obtain
> it.

The error codes in phylib are almost arbitrary and don't really give
enough information about where the a failure lies.  dev_err() is more
useful for debugging.

My experience has been that the encoding of error numbers into a
pointer return is a source of bugs for driver writers and should be
strongly avoided unless the return codes are actually important (ie.
userspace depends on them).  Especially so when the use-case for
keeping them is merely theoretical.  I've looked through the phylib
usage for ERR_PTR(), and it all is related to whether or not a
phy_device pointer can be located.  The error code is pretty much
irrelevant if a phy cannot be obtained.

How about this as a compromise:  I'll investigate all the users of
phylib and if I find even one situation where the specific return code
is actually important to a driver, then I'll back off.  phylib has
been around for 5 years now which should be enough time for that use
case to bubble to the surface.

g.
