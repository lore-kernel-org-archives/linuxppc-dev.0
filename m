Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [PATCH 14/22] spufs: use SPU master control to
	prevent =?iso-8859-15?q?wild=09SPU?= execution
Date: Thu, 1 Mar 2007 14:50:50 +0100
References: <20061120174454.067872000@arndb.de>
	<20061120180525.281408000@arndb.de>
	<1172729890.5852.40.camel@concordia.ozlabs.ibm.com>
In-Reply-To: <1172729890.5852.40.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703011450.50935.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 01 March 2007, Michael Ellerman wrote:
> On Mon, 2006-11-20 at 18:45 +0100, Arnd Bergmann wrote:
> > plain text document attachment (spufs-master-control.diff)
> > When the user changes the runcontrol register, an SPU might be
> > running without a process being attached to it and waiting for
> > events. In order to prevent this, make sure we always disable
> > the priv1 master control when we're not inside of spu_run.
> 
> Hi Arnd,
> 
> Sorry I didn't comment on this when you sent it, I wasn't paying enough
> attention. This patch confuses me, you say we should make sure we always
> disable the master control when we're not inside spu_run, but I see
> several exit paths where we leave the master run bit enabled - or maybe
> I'm reading it wrong.

I think you're right, there is at least one path that I now saw
getting out of spufs_run_spu incorrectly. In particular, when
spu_reacquire_runnable() fails, we never call the master stop,
which is a bug, but should happen very infrequently in practice.
Do you see another case where we end up with the same problem?

If not, I'll prepare a patch to fix this one case.

	Arnd <><
