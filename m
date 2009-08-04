Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 95AF6B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 06:40:11 +1000 (EST)
Date: Tue, 4 Aug 2009 21:41:35 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Re:[PATCH 1/2] powerpc: add kexec support on FSL-Book-E
Message-ID: <20090804194135.GA19171@www.tglx.de>
References: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <e997b7420908011825n4ba2df16u71d53953d6774c21@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* wilbur.chan | 2009-08-02 09:25:43 [+0800]:

>Hi, Sebastian,
Hi Wilbur,

>In your patch of Booke support for kexec , it setup a 1GB TMP mapping
>and jump to it.
>
>But I saw that, the max size for an e500 entry is 256M??so I changed
>your code to setup 4*256M entries, and it works well on mpc8541.

The e500 core family reference manual [0] in chapter 12.2.2
(Variable-Sized Pages) says e500v1 supports only up to 256MiB and e500v2
supports up to 4GiB. So this code is e500v2 but not on purpose.

>
>Howerver,it didn't work on mpc8548(e500 v2)  and
>P2020ds(SMP,e500 v2) , and  'rfi' to final_copy_code failed.(I also
>setup a 1:1 mapping for serial ,so I can trap the flowchart in
>relocate_new_kernel)
>
>
>Any suggestions about this ?   Thank you very much.
There is no SMP support. The other CPUs are not halted/resumed. At the
time of writing it I did not have a SMP machine so I did not implement
it.
In general it should work on e500v2 boxes. There is one ugly thing: I
did not setup the stack in the purgatory code. That means the purgatory
code (and everything after it) is using kernel's old stack. This might
corrupt things.
I don't let purgatory code jump to the kernel code. Instead I jump to a
tiny wrapper that is linked at 8Mib and takes the device tree which
was handed over, uncompresses the kernel to 0x0 and jumps there. Since
there is a gap betwwen 0 and 8MiB I usually have my purgatory stack
there. Therefore the wrapper around kernel has to bring its own stack.

>regards,
>
>wilbur
[0] E500CORERM.pdf

Sebastian
