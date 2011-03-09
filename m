Return-Path: <anton@samba.org>
Date: Wed, 9 Mar 2011 23:46:57 +1100
From: Anton Blanchard <anton@samba.org>
To: =?ISO-8859-1?B?QW3pcmljbw==?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] kdump: Allow shrinking of kdump region to be
	overridden
Message-ID: <20110309234657.264d3080@kryten>
In-Reply-To: <20110309122046.GC16951@cr0.redhat.com>
References: <20100825002258.GD28360@kryten> <m139u37cii.fsf@fess.ebiederm.org>
	<4D771EE6.5050404@linux.vnet.ibm.com>
	<20110309122046.GC16951@cr0.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, "Eric W.
	Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> The crashkernel region is specified via kernel cmdline, so why
> not just drop a failure when it overlaps with RMO region?
> Am I missing something?

Unfortunately a ppc64 kernel requires a chunk of RMO memory. We would
need the ability to specify multiple crashkernel regions - about 32MB
in the RMO and the rest can be anywhere. That sounds pretty fragile for
a user to configure successfully on the cmdline.

Thats why the ppc64 crashkernel region begins mid way through the RMO
region. It means both kernels get a chunk of RMO and we only have to
deal with one crashkernel reservation in all the tools and
documentation.

Anton
