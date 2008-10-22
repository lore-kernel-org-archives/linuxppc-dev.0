Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58A59474C6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 01:59:52 +1100 (EST)
Message-Id: <952F8E0B-3BFD-4E01-A032-2AFF5B4D31FA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48FF3743.1000007@genesi-usa.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Extended Addressing Mode
Date: Wed, 22 Oct 2008 09:59:22 -0500
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
	<48FF3743.1000007@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 22, 2008, at 9:22 AM, Matt Sealey wrote:

>
>
> Kumar Gala wrote:
>> Your bigger issue is if you can setup the DDR controller for the  
>> hole you want.
>
> I just remembered;;
>
> ~~
> The CCSR window always takes precedence over all local access  
> windows. However, the CCSR window must not overlap an LAW that maps  
> to the DDR controller. Otherwise, undefined behavior occurs.
> ~~
>
> So, it's not really possible to map 4GB of RAM in the lower 32-bit  
> area, without interacting badly with the CCSR. This means you're  
> forced to select a 2GB LAW for DDR, then leave 2GB free, then map  
> the rest above.. using more than 2Gb therefore absolutely requires  
> non-contiguous memory..?

As I said, its all about your physical DDR layout.  If you have two  
DDR dimms each 2Gb you can do:

0..2G  - DDR DIMM A
2G..4G - IO
4G..6G - DDR DIMM B

- k
