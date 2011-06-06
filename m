Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 14DA7B6FBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 19:02:03 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 05803-02 for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Jun 2011 10:01:48 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] powerpc: Use the #address-cells information to
	parsememory/reg
Date: Mon, 6 Jun 2011 10:00:22 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD73@saturn3.aculab.com>
In-Reply-To: <4DEC7F49.8060000@in.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Suzuki Poulose" <suzuki@in.ibm.com>, "Simon Horman" <horms@verge.net.au>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Changed the add_usable_mem_property() to accept FILE* fp instead of
int fd,
> > as most of the other users of read_memory_region_limits() deals with
FILE*.
> >
> > Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
>=20
> Could you please let me know your thoughts/comments about this patch ?

Is the change to use 'FILE *' actually progress?
I'd have thought that the randomly aligned read/lseek system calls
that this allows to happen are not desirable for anything that
isn't a true file.

I'd also suggest that the sizeof's should be applied to the
actual type of the variable being read/written, not arbitrarily
'long' or 'int', and this probably ought to be some fixed size type.

	David
