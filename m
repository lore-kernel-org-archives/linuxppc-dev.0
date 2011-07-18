Return-Path: <mgarcia@rossvideo.com>
Received: from mail1.rossvideo.com (mail1.rossvideo.com [72.1.218.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.rossvideo.com",
	Issuer "DigiCert High Assurance CA-3" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE00DB6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 01:51:11 +1000 (EST)
Received: from mail3.rossvideo.com (server16.rossvideo.com [10.0.0.16]) by
	mail1.rossvideo.com with ESMTP id KB2NE2Wk1pRsmG7q for
	<linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 11:35:58 -0400 (EDT)
Subject: Busy waits take much longer in driver code vs. application code
From: Matias Garcia <mgarcia@rossvideo.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <CAKTLLVSZ1ju5e-_Hqi9i4bYMsd1nxS3gTP9Q8ecoe-zxdZDOAA@mail.gmail.com>
References: <CAKTLLVSZ1ju5e-_Hqi9i4bYMsd1nxS3gTP9Q8ecoe-zxdZDOAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 11:35:58 -0400
Message-ID: <1311003358.1851.14.camel@matias-lnx-host>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not sure if this is arch-dependant. If not, I'll register on the kernel
mailing list.

I'm working with some legacy driver code (an IOCTL) that busy waits
after requesting an operation from an FPGA. It reads a register in a
loop until the FPGA has finished the operation. The operation is
supposed to take about 1ms, but the driver code is returning after 11ms
or more. If I instead run the same busy loop inside the application that
calls the IOCTL, it takes <1ms. Instrumenting the driver loop shows that
the loop is only executed a couple of times about 5ms apart (though
printk may skew this slightly). The application loop is run MUCH more
often.

Platform is P2020 with kernel 2.6.37 running two applications. The one
in question is run with FIFO scheduler at priority 10, the other one is
run with FIFO scheduler at priority 50. All other processes are
regular/default priority.

The only difference in interface between calling the IOCTL and
reading/writing registers through the device file is that read/writes
use copy to/from user while the IOCTL calls io[read|write]32be. No data
needs to go to user-space for this operation.

A couple of questions:

1. Why is the application code running WAY faster than the IOCTL call? I
thought driver code was executed in process context at the same priority
as the calling process.

2. Can you suggest a better way to implement the busy wait in the driver
code if I can get the priorities right? Should I even leave it in there?
I'm doing a lot of reading, but could really use an expert opinion.

Any light shed will be toasted heartily.

Thanks,
Matias Garcia
