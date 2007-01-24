Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17847.12237.166954.453166@cargo.ozlabs.ibm.com>
Date: Wed, 24 Jan 2007 21:07:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: CPM2 interrupt controller fix
In-Reply-To: <20070123004203.5a3007fa@localhost.localdomain>
References: <20070113004150.1224.58427.stgit@localhost.localdomain>
	<17844.35471.554647.189851@cargo.ozlabs.ibm.com>
	<20070122164316.79569af9@localhost.localdomain>
	<1169495737.1582.7.camel@localhost.localdomain>
	<20070122235533.6f9f8d09@localhost.localdomain>
	<1169500388.1582.14.camel@localhost.localdomain>
	<20070123004203.5a3007fa@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just tried to compile up the ads8272_defconfig with ARCH=ppc, since
that was the only obviously 8272-based config in arch/ppc/configs.
However, arch/ppc/platforms/mpc8272ads_setup.c fails to compile
because of things like this in it (line 106):

static void init_fcc1_ioports(struct fs_platform_info*)
{
...
}

That is, it's a function definition (not declaration) with the
parameter name missing, which gcc rejects with an error.  Gitk tells
me it's been like this since September.

Is there any 8272-based config that actually still compiles with
ARCH=ppc?

Paul.
