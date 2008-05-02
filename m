Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by ozlabs.org (Postfix) with ESMTP id 53D7EDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 May 2008 00:29:53 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1710076pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 02 May 2008 07:29:52 -0700 (PDT)
Subject: Re: treeImage vs cuImage
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Darcy Watkins <DWatkins@tranzeo.com>
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109583679@tranzeo-mail2.12stewart.tranzeo.com>
References: <D61182AC8012EA4EBC531B3AF23BE109583679@tranzeo-mail2.12stewart.tranzeo.com>
Content-Type: text/plain
Date: Fri, 02 May 2008 09:29:44 -0500
Message-Id: <1209738584.4209.7.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2008-05-02 at 07:14 -0700, Darcy Watkins wrote:
> Hello,
> 
> I am upgrading my BSP to 2.6.25 and notice cuImage and treeImage.  The
> source files both say Old U-Boot compatibility.

That's wrong.  treeImage isn't for U-Boot.  I should correct that
comment.

> Someone please educate me (or point me to a good URL that explains) as
> to what the difference is.

treeImage is for the older IBM 4xx eval boards that use the simple
OpenBIOS ROM monitor.  Ebony, Walnut, etc typically came with this
firmware.  cuImage is for boards using older U-Boot.

> I want to be able to load the kernel image using an older U-Boot and
> currently use cuImage for 2.6.23 arch/powerpc (and plain uImage for
> older kernels under arch/ppc).

You want cuImage then.

> Eventually, I want to generate both an old U-Boot compatible image and a
> new U-boot compatible image.

You'll get this by default when you build for cuImage.  The cuImage will
contain the vmlinux and the dtb wrapped into a single file for use with
older U-Boots.  You can just use the vmlinux itself and provide the dtb
separately for newer. (I think.)

> I notice that some boards, the boot support is all in one file, in
> others, it is split between cuboot-<board>.c and <board>.c.  In the case
> of ebony board, I see support for both cuImage and treeImage.  Is the
> strcuture into multiple files to ensure that ebony supports both of
> these and new U-boot support as well?

The boards that are split are for support with multiple different
firmwares, or because pieces of those can be shared with different
boards.

> I would like to make my BSP modules lean and clean enough to eventually
> send back upstream to kernel.org.

Great!

> 
> Also, if there are common snags / pitfalls I need to watch out for
> switching my BSP and DTS from 2.6.23 to 2.6.25, please warn me.
> 
> I am using AMCC PPC405EP processor.

405EP should be supported soon.  I have a Taihu board, I just need to
port it.  After that, you should be able to either reuse or mostly copy
it.  But if you beat me to it, I won't complain at all :)

josh
