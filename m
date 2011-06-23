Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0736DB6F77
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Jun 2011 06:43:08 +1000 (EST)
Message-ID: <4E03A557.2010008@embedded-sol.com>
Date: Thu, 23 Jun 2011 23:43:03 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Connecting SGMII PHY to eTSEC1 on P1022
References: <4E021113.10909@embedded-sol.com> <4E0215E5.5060606@freescale.com>
	<4E02229B.50707@embedded-sol.com>
In-Reply-To: <4E02229B.50707@embedded-sol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 06/22/2011 08:12 PM, Felix Radensky wrote:
> Hi Timur,
>
> On 06/22/2011 07:18 PM, Timur Tabi wrote:
>> Felix Radensky wrote:
>>> What am I doing wrong ?
>> Can you debug the PHY driver to see if it's getting called and 
>> trying to talk to
>> the PHY itself?
>>
> I'll do that tomorrow and report back.

I've found the problem by looking at the code. My SGMII PHY is Marvell 
88E1112.
Marvell PHY driver claims it supports that PHY, but in reality it 
doesn't. It uses
routines initially written for 88E1111 to configure 88E1112, 
essentially writing
to registers that do not exist on that PHY. After disabling Marvell 
PHY driver my
PHY started working.

Felix.
