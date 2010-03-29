Return-Path: <prvs=17043c47b5=steve@digidescorp.com>
Received: from digidescorp.com (mail.digidescorp.com [66.244.163.200])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37497B7CE6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 02:50:25 +1100 (EST)
Received: from [10.10.6.102] by digidescorp.com (Cipher SSLv3:RC4-MD5:128)
	(MDaemon PRO v10.1.1) with ESMTP id md50001237953.msg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2010 10:42:55 -0500
Subject: Re: [PATCH] [RFC] Xilinx MPMC SDMA subsystem
From: "Steven J. Magnani" <steve@digidescorp.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa41003261653j5a9be6e8gbe8f12e19a563cd6@mail.gmail.com>
References: <201003172118.41559.temerkhanov@cifronik.ru>
	<fa686aa41003261653j5a9be6e8gbe8f12e19a563cd6@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 29 Mar 2010 10:42:53 -0500
Message-Id: <1269877373.6173.27.camel@iscandar.digidescorp.com>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au,
	Sergey Temerkhanov <temerkhanov@cifronik.ru>,
	linuxppc-dev@lists.ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: steve@digidescorp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-26 at 17:53 -0600, Grant Likely wrote:
> I've not got time to review this patch right now, but Sergey and
> Steven, you both posted MPMC drivers on the same day; Steven on the
> microblaze list and Sergey on the powerpc list.  Can you two please
> coordinate and figure out how to mork toward a single driver that will
> meet both your needs?  I don't want to have 2 drivers (3 if you count
> the ll_temac driver) in mainline for the same hardware interface.
> 

I don't think we'll end up with a single driver. A MPMC DMA Engine
driver is useful only on "loopback" SDMA ports. Sergey's code looks like
a nice generic interface to Xilinx SDMA HW that could be used by the
xlldma and ll_temac drivers, for instance. Both of those will get
smaller, but won't go away.

For this to be useful to me, it would need to be located somewhere more
accessible than arch/powerpc and it would need to have initialization
methods that don't depend on OF. In my build I would have platform code
that binds to the xlldma platform attachment, which would call Sergey's
SDMA code to assign it the proper resources. 

Any objections to having Sergey's code live in drivers/dma, and putting
sdma.h out in include/linux? Might need to tweak the file/function names
some to head off namespace issues. Or is there some other strategy for
managing Xilinx-related drivers common to both Microblaze and PowerPC?

Steve
