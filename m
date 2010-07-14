Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5947EB6F0C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 13:27:01 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6DNEXeH015499
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 19:14:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6E3QwSj1589482
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:26:58 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6E3Qw8A004043
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 23:26:58 -0400
Subject: Re: [PATCH 4/7] Allow sysfs memory directories to be split
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
References: <4C3B3446.5090302@austin.ibm.com> <4C3B3895.3040209@austin.ibm.com>
	<20100713152854.ec1f4d6a.kamezawa.hiroyu@jp.fujitsu.com>
	<4C3C8B9E.7000208@austin.ibm.com>
	<20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Date: Tue, 13 Jul 2010 20:26:56 -0700
Message-ID: <1279078016.10995.58.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-07-14 at 09:35 +0900, KAMEZAWA Hiroyuki wrote:
>   2. I'd like to write a configfs module for handling memory hotplug even when
>      sysfs directroy is not created.
>      Because configfs support rmdir/mkdir, the user (ppc's daemon?) has to do
>      
>      When offlining section X.
>      # insmod configfs_memory.ko
>      # mount -t configfs none /configfs
>      # mkdir /configfs/memoryX
>      # echo offline > /configfs/memoryX/state
>      # rmdir /configfs/memoryX
> 
>   And making this operation as the default bahavior for all arch's memory hotplug may
>   be better...
> 
> Dave, how do you think ? Because ppc guys uses "probe" interface already,
> this can be handled... no ?

I think creating a interface to duplicate the existing sysfs one is a
bad idea.  I also think removing the existing sysfs one isn't feasible
since there are users, and it's truly part of the ABI.  So, I'm not
really a fan on the configfs interface. :(

I really do think the sysfs interface is fixable.  We should at least
give it a good shot before largely duplicating its functionality.

-- Dave
