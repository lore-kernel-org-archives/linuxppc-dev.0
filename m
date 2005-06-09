Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 2D36C67B2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 19:12:53 +1000 (EST)
Date: Thu, 9 Jun 2005 02:12:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: scarayol@assystembrime.com
Message-ID: <20050609021250.A5659@cox.net>
References: <OF76EEFE38.5001E643-ONC125701B.00283639@brime.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF76EEFE38.5001E643-ONC125701B.00283639@brime.fr>;
	from scarayol@assystembrime.com on Thu, Jun 09, 2005 at
	09:30:43AM +0200
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Read in /dev/port with Segmentation Fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 09, 2005 at 09:30:43AM +0200, scarayol@assystembrime.com wrote:
> Hi all,
> 
> I want to access to IO ports on a MPC885. The iopl() is not implemented, in
> my distribution, to use inw() outw().
> So I use /dev/port. It works for open("/dev/port",..) and lseek() but when
> i do a read()  i have a segmentation fault. I gave all the right to
> /dev/port
> Does anybody have an idea ?

You are trying to use x86-specific interfaces to x86-specific IO space.
By "IO ports" you must mean memory mapped I/O registers since you are
on PPC. From userspace, use mmap() to map physical address space to a
user virtual address range.

-Matt
