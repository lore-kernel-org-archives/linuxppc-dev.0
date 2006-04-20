Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17480.5183.958036.533453@cargo.ozlabs.ibm.com>
Date: Fri, 21 Apr 2006 09:07:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
In-Reply-To: <4447C3BA.6050709@am.sony.com>
References: <4447C3BA.6050709@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,

Ummm... why?  If procps is assuming that the page size of the kernel
it's running on is the same as the page size of the kernel it was
compiled on, it's broken.  It should be using sysconf(PAGE_SIZE) at
runtime.

Paul.
