Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/kexec: Fix orphaned offline CPUs across kexec
In-reply-to: <4C521FD2.4050301@ozlabs.org>
References: <4C511216.30109@ozlabs.org> <3296.1280448512@neuling.org>
	<4C521FD2.4050301@ozlabs.org>
Date: Fri, 30 Jul 2010 13:15:14 +1000
Message-ID: <20694.1280459714@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(adding kexec list to CC)

In message <4C521FD2.4050301@ozlabs.org> you wrote:
> Michael Neuling wrote:
> > In message <4C511216.30109@ozlabs.org> you wrote:
> >> When CPU hotplug is used, some CPUs may be offline at the time a kexec is
> >> performed.  The subsequent kernel may expect these CPUs to be already runn
ing
> > ,
> >> and will declare them stuck.  On pseries, there's also a soft-offline (ced
e)
> >> state that CPUs may be in; this can also cause problems as the kexeced ker
nel
> >> may ask RTAS if they're online -- and RTAS would say they are.  Again, stu
ck.
> >>
> >> This patch kicks each present offline CPU awake before the kexec, so that
> >> none are lost to these assumptions in the subsequent kernel.
> > 
> > There are a lot of cleanups in this patch.  The change you are making
> > would be a lot clearer without all the additional cleanups in there.  I
> > think I'd like to see this as two patches.  One for cleanups and one for
> > the addition of wake_offline_cpus().
> 
> Okay, I can split this.  Typofixy-add-debug in one, wake_offline_cpus
> in another. 

Thanks.

> 
> > Other than that, I'm not completely convinced this is the functionality
> > we want.  Do we really want to online these cpus?  Why where they
> > offlined in the first place?  I understand the stuck problem, but is the
> > solution to online them, or to change the device tree so that the second
> > kernel doesn't detect them as stuck?
> 
> Well... There are two cases.  If a CPU is soft-offlined on pseries, it
> must b e woken from that cede loop (in
> platforms/pseries/hotplug-cpu.c) as we're repla cing code under its
> feet.  We could either special-case the wakeup from this ce de loop to
> get that CPU to RTAS "stop-self" itself properly.  (Kind of like a "
> wake to die".)

Makes sense.  

> So that leaves hard-offline CPUs (perhaps including the above): I
> don't know why they might have been offlined.  If it's something
> serious, like fire, they'd be removed from the present set too (and
> thus not be considered in this restarting case).  We could add a mask
> to the CPU node to show which of the threads (if any) are running, and
> alter the startup code to start everything if this mask doesn't exist
> (non-kexec) or only online currently-running threads if the mask is
> present.  That feels a little weird.
> 
> My reasoning for restarting everything was: The first time you boot,
> all of your present CPUs are started up.  When you reboot, any CPUs
> you offlined for fun are restarted.  Kexec is (in this non-crash
> sense) a user-initiated 'quick reboot', so I reasoned that it should
> look the same as a 'hard reboot' and your new invocation would have
> all available CPUs running as is usual.

OK, I like this justification.  Would be good to include it in the
checkin comment since we're changing functionality somewhat.

Mikey
