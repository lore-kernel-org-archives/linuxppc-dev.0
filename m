Return-Path: <neko@genesi-usa.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by ozlabs.org (Postfix) with ESMTP id E498DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 00:43:11 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so1589101wxc.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 06:43:10 -0700 (PDT)
Message-ID: <48FF2DDE.9060301@genesi-usa.com>
Date: Wed, 22 Oct 2008 08:42:54 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
In-Reply-To: <88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
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
> On Oct 22, 2008, at 7:59 AM, Régis Odeyé wrote:
> 
>> of ram. So I need 4GB+IOs (~1GB) of physical addressing space.
>> My plan is to put a part of this ram above of 4GB to keep accesses to 
>> the IOs below the 4GB limit. It means non-contiguous ram addressing 
>> and XAEN features to be working.
> 
> So we have XAEN support in the tree.. however non-contiguous is 
> something you'll have to work on yourself.  Patches are welcome for this

So to confirm, XAEN support through Becky's patches does 
support the MPC8641D/e600 cores?

>> Where can I glance through Becky patches ?
> 
> This is the bulk:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=4ee7084eb11e00eb02dc8435fd18273a61ffa9bf 

I'd also be interested in any work done to enable 
non-contiguous memory areas. Reading the docs for the MPC8641D 
though I am not sure you can set up LAWs for it?

One thing I wanted to try was installing 4GB in a system and 
"overlapping" IO (since there is very little of it on a stock 
MPC8641DHPCN) in the top ~256MB-512MB, but I am fairly sure 
this is NOT supported because of the way the LAWs work, and 
also the alignment of the LAWs means it is not fine enough 
granularity to map between 2GB and 4GB into a window (you can 
have 2GB or 4GB but not some more arbitrary value?)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
