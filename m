Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C111DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 04:31:43 +1100 (EST)
Message-Id: <6BBF4AB4-FFB0-46ED-B591-17DEC3BE547F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Coulter <scott.coulter@cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Gianfar tx-babbling-errors
Date: Wed, 18 Feb 2009 11:29:03 -0600
References: <43EB80E07C42E1408726E4905FB96B04C0769D@CYBORG3.cyclone.com>
	<F122E3A2-3054-4BC9-9C06-0ADE590A8AFC@kernel.crashing.org>
	<43EB80E07C42E1408726E4905FB96B04C076B1@CYBORG3.cyclone.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 18, 2009, at 11:22 AM, Scott Coulter wrote:

> Kumar,
>
>> I'm told this will occur when:
>
>> Transmitted frame > MAXFRM and MACCFG2[Huge En] = 0.
>
> In the driver it looks like the MACCFG2_HUGEFRAME only gets set if the
> mtu > DEFAULT_RX_BUFFER_SIZE (1536 in my kernel).  It appears as  
> though
> the mtu is set to 1500.  Under what conditions would the driver  
> attempt
> to send a frame larger than the mtu?

can't think of any.  How about adding a BUG_ON() in the tx path to see  
if the buffer size > MTU and re-run your tests.

- k
