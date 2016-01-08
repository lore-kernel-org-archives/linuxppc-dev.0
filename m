Return-Path: <dwalker@fifo99.com>
Received: from ip-172-31-12-36.us-west-2.compute.internal
 (ec2-54-201-57-178.us-west-2.compute.amazonaws.com [54.201.57.178])
 by lists.ozlabs.org (Postfix) with ESMTP id 8CD161A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 04:58:19 +1100 (AEDT)
Date: Fri, 8 Jan 2016 09:45:06 -0800
From: dwalker@fifo99.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: simple_alloc space tramples initrd
Message-ID: <20160108174506.GA12105@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

A powerpc machine I'm working on has this problem where the simple_alloc_init() area is trampling the
initrd. The two are placed fairly close together.

I have a fix for this proposed to add a section into arch/powerpc/boot/zImage.lds.S called "mallocarea"
to account for this space, but not all powerpc platforms use simple_alloc_init(). So for those platforms
it's a waste.

Another alternative is to alter the bootloader to place more space between the kernel image and initrd image.

I wanted to get some feedback on the right way to fix this. It seems like it could be a generic issue on powerpc,
or it's possibly already fixed someplace and I just haven't noticed.

Any feedback appreciated.

Daniel
