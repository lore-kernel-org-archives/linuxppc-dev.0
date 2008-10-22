Return-Path: <neko@genesi-usa.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 71CEBDDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 05:25:47 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so1541725wag.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:25:45 -0700 (PDT)
Message-ID: <48FF7028.6050409@genesi-usa.com>
Date: Wed, 22 Oct 2008 13:25:44 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
	<48FF3743.1000007@genesi-usa.com>
	<952F8E0B-3BFD-4E01-A032-2AFF5B4D31FA@kernel.crashing.org>
In-Reply-To: <952F8E0B-3BFD-4E01-A032-2AFF5B4D31FA@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
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



Kumar Gala wrote:
> 
> On Oct 22, 2008, at 9:22 AM, Matt Sealey wrote:
> 
>> ~~
>> The CCSR window always takes precedence over all local access windows. 
>> However, the CCSR window must not overlap an LAW that maps to the DDR 
>> controller. Otherwise, undefined behavior occurs.
>> ~~
>>
>> So, it's not really possible to map 4GB of RAM in the lower 32-bit 
>> area, without interacting badly with the CCSR. This means you're 
>> forced to select a 2GB LAW for DDR, then leave 2GB free, then map the 
>> rest above.. using more than 2Gb therefore absolutely requires 
>> non-contiguous memory..?
> 
> As I said, its all about your physical DDR layout.  If you have two DDR 
> dimms each 2Gb you can do:
> 
> 0..2G  - DDR DIMM A
> 2G..4G - IO
> 4G..6G - DDR DIMM B

I assume on the HPCN "DDR DIMM A" would be one or both of one 
set of DDR slots, and DDR DIMM B would be one or both o the 
other set (since there are 4 slots, two for each controller)?

Or are we talking about actual, physical DIMMs?

If we're talking about controllers, could you not do;

0..2GB DDR Controller 1 (partial)
2G..4GB IO
4GB..NGB DDR Controller 1 (the rest)
NGB-64GB DDR Controller 2 (or whatever)

Or do LAWs not cooperate when for the same target? I would 
assume if you set up the CSn_BNDS registers right you could 
get a real fine grained mapping of DDR controller to memory 
space in combination with the LAWs? It would then be actually 
possible (however disgusting this config would be) to have a 
2GB DIMM, 1GB DIMM on the first controller with two LAWs, and 
the appropriate chip selects, then 1GB IO space, then up to 
32GB (since 16GB DIMMs are about as high as it goes for DDR2) 
memory space mapped after that, with a single LAW?

Or more comfortably, pair up 2x 2GB DIMMs and simply ignore 
the last 1GB, and pair up 2x 16GB DIMMs?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
