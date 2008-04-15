Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.12968.728788.841679@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 14:44:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Make Book-E debug handling SMP safe
In-Reply-To: <Pine.LNX.4.64.0804091621140.24556@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804091621140.24556@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> global_dbcr0 needs to be a per cpu set of save areas instead of a single
> global on all processors.

Looks reasonable.  At some point you might want to use a per-cpu
variable instead of an array in order to reduce cacheline bouncing.

> Also, we switch to using DBCR0_IDM to determine if the user space app is
> being debugged as its a more consistent way.  In the future we should
> support features like hardware breakpoint and watchpoints which will
> have DBCR0_IDM set but not necessarily DBCR0_IC (single step).

That should be OK.

Paul.
