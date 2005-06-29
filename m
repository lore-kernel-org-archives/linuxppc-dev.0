Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2910C67B82
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Jun 2005 02:54:10 +1000 (EST)
Date: Wed, 29 Jun 2005 09:54:08 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Chunlei Dong <cldong@gmail.com>
Message-ID: <20050629165408.GB17313@gate.ebshome.net>
References: <b8fbdd1e05062909398f091c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b8fbdd1e05062909398f091c1@mail.gmail.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: /sbin/init is not beeing scheduled to run
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2005 at 09:39:55AM -0700, Chunlei Dong wrote:
> Hi, 
> 
> I am trying to boot the linux 2.6.11.5 in high memory, that means the
> phys memory does not start from 0, but 0x04000000, on ppc440gp ebony
> board.  I changed the TLB setting and register settings for bdinfo,
> cmdline. Now it seems ok to run to the end of the process 0. After the
> start_thread() in load_elf_binary(), which loaded the "/sbin/init",
> the cpu becomes idle state, the /sbin/init process(the process 1) is
> never been scheduled to run.
> Anybody encountered this problem or give a hint?

Well, my suggestion is NOT to use such strange configuration and put 
memory at 0, you'll save yourself a lot of time.

Theoretically, it should be possible to make Linux work when RAM 
isn't at 0 address, but you have to fix many places and this requires 
quite deep understanding of Linux and PPC 44x memory management, and, 
frankly, you're on your own in this quest :).

-- 
Eugene
