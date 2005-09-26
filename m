Return-Path: <flar@pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) by ozlabs.org (Postfix) with ESMTP id DE0DA68373
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 03:44:06 +1000 (EST)
Date: Mon, 26 Sep 2005 10:44:04 -0700
From: Brad Boyer <flar@allandria.com>
To: zhonglei <zhonglei@RCS-9000.COM>
Message-ID: <20050926174403.GA28765@pants.nu>
References: <200509261548.AA26280018@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509261548.AA26280018@RCS-9000.COM>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: sys_shmat
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 26, 2005 at 03:48:03PM +0800, zhonglei wrote:
>    I get a pointer shramptr from sys_shmat(shid,0,SHM_R|SHM_W,&shramptr) to use share RAM in my driver.
> But when I assign a value into this pointer in my interrupt routine,
> the system shows: oops: kernel access of bad area!
> what's the problem?

The problem is that sys_shmat is the implementation of the shmat() system
call and is therefore only intended to attach shared memory to a normal
user-space process. The memory is attached to whatever process is listed
as current at the time of the call. This is obviously not what you wanted,
since you apparently want something that is useful from kernel-space.

Perhaps you should tell the list what you are trying to do from a more
conceptual view? No matter what you are trying to do, I think you are
misunderstanding the services that are available to a driver in the kernel.
The key question you need to answer is where you need to be able to
access this memory. In particular, do you need it in a user-space program?

	Brad Boyer
	flar@allandria.com
