Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 78BADDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:28:02 +1100 (EST)
Received: from [10.50.1.77] (blade.az.mvista.com [10.50.1.77])
	by hermes.mvista.com (Postfix) with ESMTP id D3F3A1F172
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 14:27:59 -0800 (PST)
Message-ID: <474B4923.905@mvista.com>
Date: Mon, 26 Nov 2007 15:30:59 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: mmap on PPC removes file refcount?
References: <47435338.2050107@mvista.com>
In-Reply-To: <47435338.2050107@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

NM, it was a bad test causing weird behavior on PPC. :(

Dave Jiang wrote:
> It seems the mmap() userland call on PPC causes the kernel to lose the ref
> count for the mount point. This is what I did on a prpmc2800 board (74xx) with
> latest powerpc.git tree (but also seem to happen on 8548 as well).
> 
> I mounted an IDE partition. The userland test app opens a file on the mounted
> partition and sits in a sleep loop while holding the file open. I call umount
> on the partition and I get "device is busy" which is suppose to happen.
> However, after the test app calls mmap on the file id for the opened file, I
> can successfully umount even though it should still say "device is busy".  This
> does not happen on x86 so I'm assuming something is going on with just PPC.
> 
> So using lsof I can list the opened files on a particular partition. When the
> file is opened, it lists 1 entry. When mmaped, on x86 it would list 2 entries,
> but on ppc it lists nothing. Not only did the mmaped entry not show up, the
> entry caused by open disappeared as well. Also, I put a printk in do_umount()
> to see what the refcount is. On x86, it would be 3 and thus causes device busy.
> On PPC it is 3 when the file is openend, however if mmap is called, the
> refcount becomes 2 and thus umount proceeds. It's almost as if the mmap call
> wiped out the opened file entry and decremented the mount count as well.
> 
> 


-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
