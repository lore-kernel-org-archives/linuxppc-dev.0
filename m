Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 4B57CDDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:21:13 +1100 (EST)
Received: by gxk7 with SMTP id 7so440429gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 15:21:10 -0700 (PDT)
Message-ID: <48FFA755.5050808@genesi-usa.com>
Date: Wed, 22 Oct 2008 17:21:09 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<1224713506.7654.353.camel@pasglop>
In-Reply-To: <1224713506.7654.353.camel@pasglop>
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



Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-22 at 08:08 -0500, Kumar Gala wrote:
>>> We are developing a board based on Freescale 8641D which can get
>> 4GB  
>>> of ram. So I need 4GB+IOs (~1GB) of physical addressing space.
>>> My plan is to put a part of this ram above of 4GB to keep accesses  
>>> to the IOs below the 4GB limit. It means non-contiguous ram  
>>> addressing and XAEN features to be working.
> 
> Why would you put the IOs below the 4G point ? It's actually easier
> to have the IOs up above, like a lot of 4xx do.

Because we're Genesi! And we have a firmware solution that 
kind of has to keep 32-bit pointers in the unlikely event that 
someone actually uses the client interface (besides yaboot!).

Having I/O in the 36-bit range could cause all sorts of 
explosions, and we're running real-mode so trapping and faking 
I/O accesses is REALLy difficult :}

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
