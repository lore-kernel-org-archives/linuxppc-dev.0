Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10BD8B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Mar 2010 17:31:13 +1100 (EST)
Subject: Re: Help about Freescale p2020ds problem under cpu load test
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Li.Wang" <Li.Wang@windriver.com>
In-Reply-To: <4BB02886.2010307@windriver.com>
References: <4BB02886.2010307@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 17:24:15 +1100
Message-ID: <1269843855.7101.7.camel@pasglop>
Mime-Version: 1.0
Cc: "Xiong, Wei" <Wei.Xiong@windriver.com>,
	Lans Zhang <jia.zhang@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-03-29 at 12:11 +0800, Li.Wang wrote:
> Hi Benjamin Herrenschmidt,

Well, I'm sure you'll have more chance with this one asking somebody
from Freescale :-)

It does look like there may be a coherency problem but I don't know
those chips well enough to tell

Cheers,
Ben.

> I use Freescale p2020ds board and kernel linux 2.6.33.
> Under cpu load test which test case is in attachment
> (#./cpu_load_multi.sh 500),
> the follow issues happen after a long time:
> =======================
> find: md5sum terminated by signal 6
> 
> find: md5sum terminated by signal 11
> =======================
> 
> If use kernel linux 2.6.27(porting p2020ds bsp to it), it's easy to 
> reproduce the issue:
> =======================
> find: ../nptl/sysdeps/unix/sysv/linux/powerpc/../i386/../fork.c:138:
> __libc_fork: Assertion `((void)(self), (((struct pthread *)
> (__thread_register - 0x7000 - (sizeof (struct pthread) + ((sizeof
> (tcbhead_t) + __alignof__ (struct pthread) - 1)&   ~(__alignof__ (struct
> pthread) - 1))))))->tid) != ppid' failed.
> 
> find: md5sum terminated by signal 6
> 
> find: md5sum terminated by signal 11
> 
> ./cpu_load.sh: line 6:  7944 Segmentation fault      find /usr -type f
> -exec md5sum {} \;>    /dev/null
> =======================
> 
> If turn off CONFIG_SMP, the issue disappear.
> 
> If use Freescale 8572ds board, the issue disappear, too.
> I know the two board is same about cpu(e500v2), but their version have a 
> little difference:
> ===================
> fsl_8572ds:
> cpu        : e500v2
> revision    : 3.0 (pvr 8021 0030)
> 
> fsl_p2020ds:
> cpu        : e500v2
> revision    : 4.0 (pvr 8021 1040)
> ===================
> 
> Please help me to check the problem.
> Thanks,
> LiWang.
