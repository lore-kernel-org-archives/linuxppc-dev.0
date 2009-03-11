Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 798B6DDFAA
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 02:30:13 +1100 (EST)
Message-Id: <4C4E1899-9086-4DF5-A5BF-832AEBEAA8E9@semihalf.com>
From: =?ISO-8859-2?Q?Bart=B3omiej_Si=EAka?= <tur@semihalf.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: NFS problems on a MPC5200-based board
Date: Wed, 11 Mar 2009 16:08:02 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This is a follow-up on NFS problems on an MPC5200-based board reported  
here a while back:

http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-to21750004.html#a21792612

To recap: while using NFS, especially while mounting the root  
filesystem over NFS, the system is really slow and displays a bunch of  
"nfs: server 192.168.1.1 not responding, still trying" messages.  
Sometimes it is able to get to the login prompt, sometimes not. In  
cases where the login is successful, the system is still extremely  
sluggish (console hangs for tens of seconds and longer).

git bisect narrows down the troublesome commit as:

commit 4c456a67f501b8b15542c7c21c28812bf88f484b
Author: Gerhard Pircher <gerhard_pircher@gmx.net>
Date:   Fri Jan 23 06:51:28 2009 +0000

    powerpc/mm: Fix handling of _PAGE_COHERENT in BAT setup code

    _PAGE_COHERENT is now always set in _PAGE_RAM resp. PAGE_KERNEL.
    Thus it has to be masked out, if the BAT mapping should be non
    cacheable or CPU_FTR_NEED_COHERENT is not set.

    This will work on normal SMP setups because we force-set
    CPU_FTR_NEED_COHERENT as part of CPU_FTR_COMMON on SMP.

    Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


We have tested recent mainline kernel (past 2.6.29-rc7) with the  
4c456a6...
commit reverted and NFS problems went away.

Other people have also reported similar problems (original posters on  
Cc):
http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-tp21750004p21792825.html
http://www.nabble.com/-PATCH--Add-support-for-the-digsy-MTC-board.-tp21750004p21792612.html

The commit in question does not look directly related to NFS/ 
networking; moreover it is a fix for some other problem, so just  
reverting it is not an option, it seems (?). So how do we go about  
having NFS operational again? Any comments?

Regards,
Bartlomiej Sieka
