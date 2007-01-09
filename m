Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87E39DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 01:26:12 +1100 (EST)
In-Reply-To: <17827.5922.667200.166153@cargo.ozlabs.ibm.com>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <997ed7c7982f75ca4a4fab7f097e0968@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
Date: Tue, 9 Jan 2007 15:21:32 +0100
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> During power outages, the ups notifies the system for a shutdown. In 
>> the
>> current setup, it isn't possible to power on when power is restored.
>> This patch fixes the issue by calling the right ibm,power-off-ups 
>> token
>> during such events. It also adds a proc interface so that rc.powerfail
>> can parse the epow events and modify the power-off behavior 
>> accordingly
>> to enable the right token to be called.
>
> Creating new non-process-related files in /proc is frowned upon these
> days, so we'll have to find somewhere in /sys for this.  Anybody got a
> suggestion?

/sys doesn't sound too good either; it sounds like what
Manish really wants is a character device?  I could be
way off though, not looking at the actual patch :-)


Segher
