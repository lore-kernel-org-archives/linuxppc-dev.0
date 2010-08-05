Return-Path: <john.r.fastabend@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id BE3E4B6EE9
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 02:48:03 +1000 (EST)
Message-ID: <4C5AEB41.9050903@intel.com>
Date: Thu, 05 Aug 2010 09:48:01 -0700
From: John Fastabend <john.r.fastabend@intel.com>
MIME-Version: 1.0
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: [linux-next] build failure
References: <4C5A4CF4.4070203@linux.vnet.ibm.com>
In-Reply-To: <4C5A4CF4.4070203@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, "Kirsher,
	Jeffrey T" <jeffrey.t.kirsher@intel.com>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

divya wrote:
> Yestersday's linux-next(2.6.35_next_20100802) build fails with the following error on both system p and x.
> 
> 
>    drivers/net/ixgbe/ixgbe_main.c: In function 'ixgbe_select_queue':
>    drivers/net/ixgbe/ixgbe_main.c:6159: error: 'struct ixgbe_fcoe' has no member named 'up'
>    drivers/net/ixgbe/ixgbe_main.c: In function 'ixgbe_xmit_frame':
>    drivers/net/ixgbe/ixgbe_main.c:6221: error: 'struct ixgbe_fcoe' has no member named 'up'
>    make[3]: *** [drivers/net/ixgbe/ixgbe_main.o] Error 1
>    make[2]: *** [drivers/net/ixgbe] Error 2
>    make[2]: *** Waiting for unfinished jobs....
>    make[1]: *** [drivers/net] Error 2
>    make: *** [drivers] Error 2
> 
> Thanks
> Divya
> 
> 

Hi Divya,

Jeff should have a fix for this in his queue already.  This is caused by 
building with CONFIG_FCOE and without CONFIG_IXGBE_DCB.

Thanks,
John.
