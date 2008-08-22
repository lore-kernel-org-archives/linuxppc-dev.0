Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.226])
	by ozlabs.org (Postfix) with ESMTP id 1410ADF44B
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 04:43:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so505892wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 11:43:06 -0700 (PDT)
Date: Fri, 22 Aug 2008 14:42:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Re: Why does one "stw" fail with address translation disabled in
	PPC405EP?
Message-ID: <20080822184213.GA24526@yoda.jdub.homelinux.org>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219429635.8882.22.camel@zr.gii.upv.es>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 08:27:15PM +0200, Zhou Rui wrote:
>Hi, all:
>    I think I meet an odd problem with PPC405EP (PPChameleonEVB Board).

What kernel version are you using?

>    I am running a kernel module which will execute a user space
>application. The entry point of the application is 0x100000a0. At the

That should be the first clue that you are doing it wrong.  Don't do
stuff like that in modules...

>moment when the processor tries to execute the application, 0x100000a0
>is not in TLB (this can be seen from BDI by printing out TLB entries),
>so DTLBMiss is called automatically and then finish_tlb_load. However,
>InstructionAccess is followed and the problem arises here.
>InstructionAccess starts from 0x400, and after instruction "0xc0000434
><InstructionAccess+52>:      stw     r12,64(r11)", machine check occurs.
>This instruction will store the value of r12, which is 0x0 at this
>moment, to address 0x03072de0. I am puzzled why this action leads to
>machine check. Is it illegal to store 0x0 in a memory address? Or is
>there some other cause of the machine check here?

I have no idea if you're using physical or virtual addresses here, so
there isn't much we can do to help you.

Do you have enough DRAM to cover that?  Some of those boards only come
with 32MiB of DRAM.

josh
