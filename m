Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id E91C0B6F15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 10:40:30 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o6E0ePAh031458 for <linuxppc-dev@ozlabs.org> (envelope-from
	kamezawa.hiroyu@jp.fujitsu.com); Wed, 14 Jul 2010 09:40:26 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2CB2A45DE51
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 09:40:25 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F2DBF45DE4D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 09:40:24 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DD8C61DB803E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 09:40:24 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.249.87.104])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9623C1DB8037
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 09:40:24 +0900 (JST)
Date: Wed, 14 Jul 2010 09:35:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 4/7] Allow sysfs memory directories to be split
Message-Id: <20100714093550.40036034.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4C3C8B9E.7000208@austin.ibm.com>
References: <4C3B3446.5090302@austin.ibm.com> <4C3B3895.3040209@austin.ibm.com>
	<20100713152854.ec1f4d6a.kamezawa.hiroyu@jp.fujitsu.com>
	<4C3C8B9E.7000208@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 13 Jul 2010 10:51:58 -0500
Nathan Fontenot <nfont@austin.ibm.com> wrote:

> > 
> > And for what purpose this interface is ? Does this split memory block into 2 pieces
> > of the same size ?? sounds __very__ strange interface to me.
> 
> Yes, this splits the memory_block into two blocks of the same size.  This was
> suggested as something we may want to do.  From ppc perspective I am not sure we
> would use this.
> 
> The split functionality is not required.  The main goal of the patch set is to
> reduce the number of memory sysfs directories created.  From a ppc perspective
> the split functionality is not really needed.
> 

Okay, this is an offer from me.

  1. I think you can add an boot option as "don't create memory sysfs".
     please do.

  2. I'd like to write a configfs module for handling memory hotplug even when
     sysfs directroy is not created.
     Because configfs support rmdir/mkdir, the user (ppc's daemon?) has to do
     
     When offlining section X.
     # insmod configfs_memory.ko
     # mount -t configfs none /configfs
     # mkdir /configfs/memoryX
     # echo offline > /configfs/memoryX/state
     # rmdir /configfs/memoryX

  And making this operation as the default bahavior for all arch's memory hotplug may
  be better...

Dave, how do you think ? Because ppc guys uses "probe" interface already,
this can be handled... no ?

One problem is that I don't have enough knowledge about configfs..it seems complex.

Thanks,
-Kame
  
