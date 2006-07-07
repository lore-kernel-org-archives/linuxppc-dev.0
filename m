Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4632D67A3F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 23:19:54 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4DF278@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4DF278@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <02206875-0FBA-4390-A8AC-14D5446EBA50@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Freescale QE UCC gigabit ethernet driver
Date: Fri, 7 Jul 2006 08:19:37 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 7, 2006, at 3:59 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, July 06, 2006 9:45 PM
>> To: Li Yang-r58472
>> Cc: Andrew Morton; jgarzik@pobox.com; netdev@vger.kernel.org;
>> linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 1/3] Freescale QE UCC gigabit ethernet driver
>>
>> Nack.  Here are some high level things that should be addressed:
>> * There is a ton of debug code that should probably be stripped out,
>> such as dump_regs, etc..
>
> The reason I left these debug code in is that, QE is very flexible.
> User probably needs to fine tune parameters for their own application.
> It will be good to give them some clue doing that.  It's fine to  
> remove
> them, if you do think they are too verbose.

Then I suggest you look at debugfs.

>> * The phy support should use the phylib instead
>
> I'll do this when I do get some time. ;)
>> * convert from being a platform_device to of_device
>
> I'm not up against moving to use of_device.  But why are we putting
> extra effort in closing the door to backward compatibility with ppc
> arch, and doesn't provide any new feature. ;)

Because the intent is for arch/ppc to go away in the future.  You are  
introducing a new driver and a new platform, this is the ideal time  
for us to use of_device.  The benefits are that the driver is the  
ideal place to parse the details of the device node rather than  
platform code in arch/powerpc.

- kumar
