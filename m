Return-Path: <ammubhai@gmail.com>
Received: from marmot.shef.ac.uk (marmot.shef.ac.uk [143.167.1.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9996867DC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 18:27:40 +1000 (EST)
Message-ID: <4524C1F2.3080308@gmail.com>
Date: Thu, 05 Oct 2006 09:27:30 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: booting 2.6 kernel on ML403
References: <20061004163517.17874.qmail@web83207.mail.mud.yahoo.com>
In-Reply-To: <20061004163517.17874.qmail@web83207.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Pradeep,

Pradeep Sampath wrote:
> Hello Ameet/Ming,
>  
> First of all really appreciate your inputs on this...
> Problem 1 :
> I was using the factory shipped compact flash as is which comes with a 
> DOS FAT16 partition and a linux 83 partition with ext3 filesystem. 
> I tried it on 2 factory shipped CFs and its the same behavior - . When 
> i plug-in the CF card reader to the linux box it always reads it as 
> "sda" and in the linux2.6.17.1/Documentation/devices.txt - sda is the 
> device file for SCSI disk devices. Wonerding how you guys configured 
> the root option as "/dev/xsa".
xsa and sda are nothing but the device name registered by the driver. It 
is not related to whether the device is a SCSI or not. Since I wrote the 
SysAce driver, I decided to name it as xsa (as opposed to the original 
Monta Vista xsysace). Thus, all the partitions on this device will be 
named xsa1 for the first partition, xsa2 for the second and so on.

When you access your CF card in your Linux PC, the driver names the 
device as sda. Thats all... theres no much difference. Hope you got the 
point.

cheers,
-Ameet
>  
> Now i re-formatted my CF, created a ext2 filesystem using 
> busybox-1.1.0 like the BYU instructions. Created 2 partitions on CF 
> card 1. FAT16 partition & 2. linux partition and then created 1. dos 
> file system using mkdosfs and 2. linux ext2 filesystem using mke2fs.
>  
> But the problem still persists and i get "Please append a correct 
> "root=" boot option :"
> :(
>  
> Problem 2: After i included the TEMAC driver and sysace drivers, 
> the kernel just hangs. I thought i'll fix problem 1 before i get to 
> problem 2...
>  
> With your help i am getting the confidence that i can make this all work!
> thanks once again.
> -Pradeep
>
>
>
> */Ming Liu <eemingliu@hotmail.com>/* wrote:
>
>     Hello Ameet,
>     I am using that driver very well now. There is only one problem.
>     It seems
>     that the driver for TEMAC only support Gigabit Enet, not 10/100/1000M
>     adapted. But because I want to use the Gigabit enet, I don't care
>     that. So
>     it's OK, at lease for 1Gbit/s.
>
>     So I don't think Pradeep's problem is caused by Temac. I still
>     suspect that
>     he didn't pass a right parameter to "root=", just like what I posted
>     before.
>
>     Regards
>     Ming
>
>
>     >From: Ameet Patil
>     >To: Ming Liu
>     >CC: pradeepsampath@yahoo.com, linuxppc-embedded@ozlabs.org
>     >Subject: Re: booting 2.6 kernel on ML403
>     >Date: Wed, 04 Oct 2006 09:35:07 +0100
>     >
>     >Ming Liu wrote:
>     > > Hi,
>     > >
>     > >> [ 3.093694] TCP bic registered
>     > >> [ 3.129458] NET: Registered protocol family 8
>     > >> [ 3.181412] NET: Registered protocol family 20
>     > >> [ 3.236744] VFS: Cannot open root device "xsa2" or
>     unknown-block(0,0)
>     > >> [ 3.313092] Please append a correct "root=" boot option
>     > >
>     > > It looks that some errors still exist in the parameters you
>     passed to
>     > > "root=". Please double check it, or post it in the maillist
>     for deep
>     > > analysis.
>     > > Regards
>     > > Ming
>     > >
>     > > _________________________________________________________________
>     > > 享用世界上最大的电子邮件系统— MSN Hotmail。
>     http://www.hotmail.com
>     > >
>     ------------------------------------------------------------------------
>     > >
>     > > _______________________________________________
>     > > Linuxppc-embedded mailing list
>     > > Linuxppc-embedded@ozlabs.org
>     > > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     >Hi Ming,
>     >IIRC, you are or were using the TEMAC driver along with my System Ace
>     >driver, isn't it? Does my driver patch ***-after-TEMAC.patch work for
>     >you? I ask this because Pradeep is having some problems using it (see
>     >Problem 2 in his email). Could you please update on this?
>     >
>     >Thanks,
>     >-Ameet
>
>     _________________________________________________________________
>     与联机的朋友进行交流，请使用 MSN Messenger:
>     http://messenger.msn.com/cn
>
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
