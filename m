Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1D032DE662
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 06:04:04 +1000 (EST)
Message-ID: <485818AA.8090701@freescale.com>
Date: Tue, 17 Jun 2008 15:03:54 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] [Rev2] MPC5121 FEC support
References: <1213729717-26688-1-git-send-email-jrigby@freescale.com>
	<48581188.90102@freescale.com>
	<20080617195739.GB13147@uranus.ravnborg.org>
In-Reply-To: <20080617195739.GB13147@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, John Rigby <jrigby@freescale.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
> On Tue, Jun 17, 2008 at 02:33:28PM -0500, Scott Wood wrote:
>> John Rigby wrote:
>>> config FS_ENET
>>>        tristate "Freescale Ethernet Driver"
>>> -       depends on CPM1 || CPM2
>>> +       depends on CPM1 || CPM2 || FS_ENET_MPC5121_FEC
>>>        select MII
>>>        select PHYLIB
>>>
>>> +config FS_ENET_MPC5121_FEC
>>> +	bool "Freescale MPC512x FEC driver"
>>> +	depends on PPC_MPC512x
>>> +	select FS_ENET
>>> +	select PPC_CPM_NEW_BINDING
>>> +	default y
>> No default y.
> I by the way do not see the need for the prompt of FS_ENET.

Agreed, especially since it's overly broad (there is Freescale ethernet 
hardware that this driver doesn't support).  We'd need to change depends 
into selects in the more specific entries.

> Do you ever want to change it if one of the dependencies
> are selected?

Do you mean if CPM1 or CPM2 is selected?  Yes, it's quite possible that 
the user has no need for the CPM ethernet and would rather reclaim the 
memory (especially on CPM1, which has boards as small as 8MiB).

-Scott
