Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17622.56592.41532.206800@cargo.ozlabs.ibm.com>
Date: Mon, 7 Aug 2006 16:26:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
In-Reply-To: <20060802175947.GA7489@w-mikek2.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz writes:

> This patch is built on top of Anton's hcall cleanup patch.  One
> remaining issue is 'where should the statistic data structures
> be updated?'.  For simplicity, I have the asm code call the
> following C routine to perform the updates.

Hmmm, doing the update in assembly would avoid the need to create a
stack frame, which would be nice...  Maybe we need to add some macros
to include/asm-powerpc/percpu.h to make it easier to access per-cpu
variables from assembly code.

Alternatively, we could put a pointer to the hcall_stats array for
each cpu in its paca.  That's very easily accessed from assembly code.

Paul.
