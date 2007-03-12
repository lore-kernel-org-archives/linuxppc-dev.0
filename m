Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id B2DD6DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 18:18:09 +1100 (EST)
Date: Mon, 12 Mar 2007 08:18:02 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Zhou Rui <vancasperz@yahoo.com.cn>
Subject: Re: A problem of debugging kernel with BDI2000 and PPC
Message-ID: <20070312071802.GB14658@moe.telargo.com>
References: <754926.95105.qm@web15608.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <754926.95105.qm@web15608.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/03/07 13:46 +0800, Zhou Rui wrote:
> Hi, all
>     I am trying to debug a trivial "helloworld" module with BDI2000 and PPC405EP board. The kernel in the PPC board is 2.6.15 compiled from ELDK4.0. I have tried to get a load map of the module, but there is no "-m" parameter in ELDK's insmod, and if "insmod.old -m hello_module.ko > module.map" is executed, the result is "insmod QM_MODULES : Function not implemented", while "insmod hello_module.ko" runs ok. I also have tried the "insmod" provided by busybox, but there is no content in module.map after "insmod.old -m hello_module.ko > module.map".
>     So would you like to tell me it is the correct way to get the load map for module debugging? Or is there any other method to do that? Thank you very much.

I used something like:
~ $ insmod pcan.ko
~ $ grep '\[pcan\]' /proc/kallsyms | sort | grep '^.\{8\} t' | head -n 1
d1088000 t buffer_dump  [pcan]

(gdb) add-symbol-file pcan.ko 0xd1088000

You should probably provide other section addresses too, if you need them.


	Domen
