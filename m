Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH]Add notification for active Cell SPU tasks
Date: Thu, 7 Dec 2006 23:58:13 +0100
References: <OF9A01B09B.B62F8342-ON8325723C.006A9343-8325723C.006B2236@us.ibm.com>
	<45773E85.8040505@us.ibm.com>
In-Reply-To: <45773E85.8040505@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612072358.15707.arnd.bergmann@de.ibm.com>
Cc: maynardj@linux.vnet.ibm.com, Luke Browning <lukeb@br.ibm.com>,
	linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 06 December 2006 23:04, Maynard Johnson wrote:
> text(struct spu *spu, struct=20
> > spu_context *ctx)
> > >
> > > Is this really the right strategy? =A0First, it serializes all spu=20
> > context
> > > switching at the node level. =A0Second, it performs 17 callouts for
> >
> I could be wrong, but I think if we moved the mutex_lock to be inside of=
=20
> the list_for_each_entry loop, we could have a race condition. =A0For=20
> example, we obtain the next spu item from the spu_prio->active_mutex=20
> list, then wait on the mutex which is being held for the purpose of=20
> removing the very spu context we just obtained.
>=20
> > > every context
> > > switch. =A0Can't oprofile internally derive the list of active spus=20
> > from the =A0
> > > context switch callout.=20
> >
> Arnd would certainly know the answer to this off the top of his head,=20
> but when I initially discussed the idea for this patch with him=20
> (probably a couple months ago or so), he didn't suggest a better=20
> alternative. =A0Perhaps there is a way to do this with current SPUFS=20
> code. =A0Arnd, any comments on this?



No code should ever need to look at other SPUs when performing an
operation on a given SPU, so we don't need to hold a global lock
during normal operation.

We have two cases that need to be handled:

=2D on each context unload and load (both for a full switch operation),
  call to the profiling code with a pointer to the current context
  and spu (context is NULL when unloading).

  If the new context is not know yet, scan its overlay table (expensive)
  and store information about it in an oprofile private object. Otherwise
  just point to the currently active object, this should be really cheap.

=2D When enabling oprofile initially, scan all contexts that are currently
  running on one of the SPUs. This is also expensive, but should happen
  before the measurement starts so it does not impact the resulting data.

> > >
> > > Also, the notify_spus_active() callout is dependent on the return=20
> > code of
> > > spu_switch_notify(). =A0Should notification be hierarchical? =A0If I
> > > only register
> > > for the second one, should my notification be dependent on the=20
> > return code
> > > of some non-related subsystem's handler.=20
> >
> I'm not exactly sure what you're saying here. =A0Are you suggesting that =
a=20
> user may only be interested in acitve SPU notification and, therefore,=20
> shouldn't have to be depenent on the "standard" notification=20
> registration succeeding? =A0There may be a case for adding a new=20
> registration function, I suppose; although, I'm not aware of any other=20
> users of the SPUFS notification mechanism besides OProfile and PDT, and=20
> we need notification of both active and future SPU tasks. =A0But I would=
=20
> not object to a new function.
>=20
I think what Luke was trying to get to is that notify_spus_active() should
not call blocking_notifier_call_chain(), since it will notify other users
as well as the newly registered one. Instead, it can simply call the
notifier function directly.

	Arnd <><
