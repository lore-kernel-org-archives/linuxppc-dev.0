Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6BD467BAC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 05:39:53 +1000 (EST)
In-Reply-To: <1146512012.24239.28.camel@cashmere.sps.mot.com>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Date: Mon, 1 May 2006 14:39:44 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2006, at 2:33 PM, Jon Loeliger wrote:

> On Sat, 2006-04-29 at 11:00, Kumar Gala wrote:
>> All,
>>
>> What evilness would it be to change the use of '#' in the .dts format
>> to some other character like '$' or '%'.
>
> Uh, use of '#' for what?  Current comment style is
> either C or C++, ie, /* ... */ or //.

Comment aren't the issue.

>>   The problem is the use of
>> '#' prevents use from using cpp which would make some aspects of
>> building up .dts for boards far more useful.
>
> I think to get CPP to be usable, it will need to handle
> the # emitted line-location markers, "# <line> <file> <level>".

Don't follow you here.

>> We can easily provide a one line script to convert people's .dts to
>> the new format.
>
> I don't think there is a conversion necessary yet.
> Did I miss something here?

Try running a current .dts through cpp today.  You will get errors like:

oftree.dts:15:3: error: invalid preprocessing directive #address
oftree.dts:16:3: error: invalid preprocessing directive #size
oftree.dts:20:4: error: invalid preprocessing directive #cpus
oftree.dts:21:4: error: invalid preprocessing directive #address
oftree.dts:22:4: error: invalid preprocessing directive #size
oftree.dts:25:2: error: invalid preprocessing directive #foobar

Because of props like:

       #cpus = <1>;
       #address-cells = <1>;
       #size-cells = <0>;

If these used some other symbol instead of '#' cpp will be happy and  
we can use it to create macros for us.

- k
