Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-41-71-119.roch.qwest.net [67.41.71.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9C6167A64
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2005 10:34:33 +1000 (EST)
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B17@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B17@exnet.3il.fr>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 31 Mar 2005 17:34:21 -0600
Message-Id: <1112312061.12105.32.camel@jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to read/write in flash memories (MTD)?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-03-31 at 11:59 +0200, Garcia J=C3=A9r=C3=A9mie wrote:
> L&G,
> Although I'm a newbie in linux kernel development, I'm in charge of adapt=
ing a Montavista LSP to fit our hardware. In our platform, we use 2 AMD fla=
sh memories (AM29LV) in which one we would like to process read/write opera=
tions. So I'm looking for a way to do that. I saw that at compilation time,=
 there is MTD item which seems to be created for that. But I guess activate=
 that will not be enough to reach my objective.

You need to enable MTD with the appropriate chip drivers and either the
MTD character device or the MTD block device (or both).  These will
create /dev/mtdX and /dev/mtdblockX respectively.  If you are using
devfs or sysfs + udev, they should show up in /dev.  Otherwise, you'll
need to use mknod to create them.

> Indeed, we are developping an application (in the user-space) which will =
initiate operation on the 2 flash memories. So, how can I access them from =
my application?
> Please help me cause I'm getting lost in the linux sources....

I'm not sure what kind of operations you mean, but the block and char
devices allow read/write operation.  If you are looking for a filesystem
to run on these devices, take a look at JFFS2.  Cramfs or squashfs can
also be used, but they are read-only.

josh
