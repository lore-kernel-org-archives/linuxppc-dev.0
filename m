Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (unknown [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id BC99FDDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 14:30:21 +1100 (EST)
Message-ID: <396305910.05464@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: "Scott Wood" <scottwood@freescale.com>,
	"vijay baskar" <cn.vijaibaskar@gdatech.co.in>
Date: Thu, 29 Nov 2007 11:11:50 +0800
Subject: Re: The question about the high memory support on MPC8360?
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,friends,

   I plug in 2GB DDR-1 in my MPC8360 board,there are two DIMM-184 slots,each
DIMM-184 slot hold 1GB.Could you tell me how to let the linux know about those
2GB?
   In uboot, I set up each DDR CS to visit 512MB, total 4 CS signal. DDR window
range is 2GB. I think the uboot has passed those DDR parameter to linux.
   I once did a test that config the bootargs with mem=512M, then the linux just
only find 512MB, but if I config the mem=2048M, the linux still find about 750MB.
   How to make the linux find the total 2GB memory?
   




>From: Scott Wood <scottwood@freescale.com>
>Reply-To: 
>To: vijay baskar <cn.vijaibaskar@gdatech.co.in>
>Subject: Re: The question about the high memory support on MPC8360?
>Date:Wed, 28 Nov 2007 10:57:38 -0600
>
>vijay baskar wrote:
>> Hi, "The kernel also allows hardcoded mapping of IO regions into its 
>> virtual address space through the io_block_mapping interface."
>> 
>> Can u tell me how this is in current arch/powerpc.
>
>Everything is explicitly ioremapped.
>
>> Also does it mean that whatever be the size of the ram > 768 MB there
>>  is not going to be much improvement in performance in kernel space 
>> irrespective of invoking CONFIG_HIGHMEM or not?
>
>Well, the kernel can use highmem for cache...  I'm not sure what you
>mean by "in kernel space".
>
>> Also do you think this low mem be enough if i have lots of kernel 
>> space processes each invoking lots of kmallocs.
>
>That depends on what you mean by "lots". :-)
>
>You'll have 768MB of lowmem, and kmallocs can only use lowmem.
>
>> Will there be bottle necks?? Also what alternative do we have if  low
>> mem of 768 MB is not enough??
>
>You'll need to change the user/kernel split, and deal with anything that 
>breaks in the process.
>
>Or get a 64-bit chip. :-)
>
>-Scott
> 
