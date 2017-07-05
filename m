Return-Path: <npiggin@gmail.com>
Date: Wed, 5 Jul 2017 14:23:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, Stewart Smith
 <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] powerpc/powernv: handle the platform error reboot
 in ppc_md.restart
Message-ID: <20170705142357.6cfc7f37@roar.ozlabs.ibm.com>
In-Reply-To: <20170705040422.20933-2-npiggin@gmail.com>
References: <20170705040422.20933-1-npiggin@gmail.com>
 <20170705040422.20933-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  5 Jul 2017 14:04:19 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Unrecovered MCE and HMI errors are sent through a special restart
> OPAL call to log the platform error. The downside is that they don't
> go through normal crash paths, so they don't give much information
> to the Linux console.
> 
> Change this by allowing them to set an error which then causes the
> normal restart handler to use the platform error call. Have MCE and HMI
> handlers set this and then use the normal panic path for unrecoverable
> cases.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

This patch is a bit clunky, setting this global variable. But it's
difficult to get this through the normal crash/panic paths by any
other way that I've found.

A concern is that we would like to add the opal log as early as
possible, but also print some information to the Linux console. This
goes against a competing concern that the more we do before logging
and xstop, the larger window something might go wrong.

So I would like to be able to cause opal to log a platform error
ASAP in the machine check handler, but then do some Linux crash
dumping before xstopping. That would require a new opal logging API
or convention though. So maybe this is an improvement (which also
allows patch 2 to be implemented more easily).

Anyway, discussion and criticism welcome.


Thanks,
Nick
