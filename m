Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D4B4DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 15:10:40 +1000 (EST)
In-Reply-To: <12648671.post@talk.nabble.com>
References: <12648489.post@talk.nabble.com>
	<85940BCC-C5A7-4461-B49C-A5C1879708C3@kernel.crashing.org>
	<12648671.post@talk.nabble.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <57BB0290-6787-4504-BC29-0E92AB226E6C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.23-rc3 boot hang on MPC8641D
Date: Thu, 13 Sep 2007 00:13:31 -0500
To: sivaji <rameshmrm@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 11:47 PM, sivaji wrote:

>
>
> Hi,
>           I have JTAG Debugger connected to the board. I was given the
> following commands in the root path of the kernel source

If you can dump memory w/o connecting GDB, I suggest the following.

Look in your kernel build for System.map and grep for log_buf you  
should get something like:

c040b04c d log_buf
c043b1a4 b __log_buf

then dump the memory @ these addresses.  I can't remember which one  
is the correct one.  You'll want to subtract c000_0000 from the  
address to get a physical address that you can dump.  This should  
help provide some possible insight into what's going on.

- k
