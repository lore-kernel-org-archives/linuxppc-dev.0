Return-Path: <gvb.uboot@gmail.com>
Message-ID: <492CC398.5080108@gmail.com>
Date: Tue, 25 Nov 2008 22:33:44 -0500
From: Jerry Van Baren <gvb.uboot@gmail.com>
MIME-Version: 1.0
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: Re :Re: [Ltib] ltib error -linux2.6.20.6 with MPC8360E MDS
References: <DFTSgh6rR4.old.1227276970.57828@webmail.rediffmail.com>
	<4926C8C2.60802@freescale.com>
In-Reply-To: <4926C8C2.60802@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Ltib@nongnu.org, seh@zee2.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> nanda wrote:
>> Hi Stuart,
>>    Thanks for the information.   gpp access was resolved.
>>    I was successful in building the linux 2.6.11 using the ltib and 
>> able to bring up the MPC8360 EMDS.
>> But, I still face the problem for linux kernel 2.6.19 and 2.6.20.   
>> When I tried using ltib in the bringing up the board.   The MPC 8360 
>> board keeps rebooting after downloading the image Power PC Kernel 
>> Image(uImage) and Power PC RAMDisk Image(rootfs.ext2.gz.uboot)  build 
>> by the "ltib"     Please clarrify on the same.
>>
> 
> I'm not a kernel expert and don't know what failure you
> are seeing here, but I might observe that 2.6.19 and .20
> are two years old, and 2.6.11 is more than 3 years old.
> 
> If you think we, collectively, haven't improved things in
> that time period, please, complain about 2.6.11, .19, and .20.
> 
> If on the off chance you think things *might* have gotten
> better due to a *bit* of development effort over the past
> three years, you might try installing a modern U-Boot and
> a modern Kernel.
> 
> Thanks,
> jdl

I would strongly recommend switching to ELDK from denx.de and the latest 
released (or tip-o-the-tree) u-boot.  This will allow you to build and 
boot the latest kernel with a flattened device tree (FDT).

ELDK:
   <http://www.denx.de/wiki/DULG/ELDK>
   <http://ftp.denx.de/pub/eldk/>
Specifically:
   <http://ftp.denx.de/pub/eldk/4.2/ppc-linux-x86/iso/>

u-boot:
   make MPC8360EMDS_HOST_66_config && make

linux:
   Start with: arch/powerpc/configs/83xx/mpc836x_mds_defconfig

Trying to use an old u-boot and old toolset with a recent kernel isn't 
worth the headaches.  The ToT supports the MPC8360EMDS directly.

Best regards,
gvb
