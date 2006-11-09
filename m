Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B8CD367C6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 01:49:56 +1100 (EST)
Date: Thu, 9 Nov 2006 17:49:47 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: robin.gilks@tait.co.nz
Subject: Re: Freescale combined ethernet driver
Message-ID: <20061109174947.415c7f7f@vitb.ru.mvista.com>
In-Reply-To: <45515913.3080206@tait.co.nz>
References: <45515913.3080206@tait.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 08 Nov 2006 17:12:03 +1300
Robin Gilks <robin.gilks@tait.co.nz> wrote:

> OK - I give up - whats the name of the device?
> 
> I've tried eth0, fsl-cpm-fec0 (and other combinations) with a 
> commandline of the form:
> 
>    ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:fsl-cpm-fec0:off \ 
> panic=1 console=ttyCPM0
> 
I am not following why you're touching netdev name here... Your problem clearly points to the unregistered platform device (which should be added to the identification code that maps system to the platform device list). In short, bsp code does name matching of the supported boards, and ties it to the enum of platform devices aught to be registered for this board. It registers nothing by default, and since fs_enet fail to found anything suitable on platform bus, not network devices created.

Yet it may be not the case of course - too less information to be sure. 

Assuming it is not relevant to you anymore, just for archive purposes.

-- 
Sincerely, 
Vitaly
