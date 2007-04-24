Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E2EAFDDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 10:27:26 +1000 (EST)
Date: Wed, 25 Apr 2007 03:57:04 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 2/2] POWERPC: Remove global CPM mappings
Message-ID: <20070425035704.19794dde@localhost.localdomain>
In-Reply-To: <3AC6566B-FCB5-4B45-B282-B737F51545ED@embeddedalley.com>
References: <20070423223649.4955.77579.stgit@localhost.localdomain>
	<20070423223910.4955.18106.stgit@localhost.localdomain>
	<5AC8BD28-125C-4552-97E9-D35E85D0E555@embeddedalley.com>
	<20070424091831.1793fa26@localhost.localdomain>
	<3AC6566B-FCB5-4B45-B282-B737F51545ED@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 24 Apr 2007 16:24:42 -0400
Dan Malek wrote:

> 
> On Apr 24, 2007, at 1:18 AM, Vitaly Bordug wrote:
> 
> > At first I was thinking of make_everybody_happy solution,
> 
> Just make me happy :-)  The problem with these
> "works in progress" submissions is no one ever
> goes back to properly finish them, so I suspect
> this code you are checking in, which I don't
> like at all, is going to just stay there and bug
> me until _I_ fix it.
> 
Hmm - it seems I want to check stuff in and forget about it? That's just not right, and there is zero value in it.
> 
> > I know it can be more efficient. And I am looking at this way, but  
> > it just cannot
> > be achieved via single step.
> 
> Why?  Because it's more work than you want to do?
> 
Because one_step_for_all is breakage-prone; and small changes are easier to debug. I want to make CPM layer
stuff better while keeping it working, and definitely not just to do some specific amount of work/code, sorry.

> > TODO list includes rehaul of GPIO (with long-time-grown
> > feature_call + device tree bindings that were implemented for 8360  
> > but looks reasonable), muxing, etc.
> 
> Nothing you have done so far affects any of this.
> The things you are changing are the very basic
> support functions.  You'll never go back and
> fix these because then the excuse will be
> "all of the drivers now use it."
> 
It does not matter what "all of the drivers now use". I just dumped long-term plan.

Anyway let's refrain from predicting future - this is kinda off topic here ;).



> > This patch just fixes what already exist in kernel, removing the  
> > global IMMR pointer
> 
> It doesn't "fix" anything, it just changes the model to make it
> more heavyweight.
> 
This approach assumes keeping whole mapped immr just to toggle a bit in mux or issue cpm_cr_cmd
is not a good thing. If the driver needs to initialize values in mux(once), it makes sense to remap that part of immr and do just that. 

for "It doesn't "fix" anything", this particular patch wraps up the cleanup and does not actually introduce new
model. The only critial path I can admit is CPM command stuff inside fs_enet and uart drivers, I'll fix it if that is the point.

> > and bringing all remaining code paths to the same need_stuff- 
> > >immr_map->use_it->immr_unmap model.
> 
> That's not the model.  The model is:  driver init maps IMMR,
> driver uses it's local mapping, driver unloaded unmaps IMMR.
> We don't map/unmap on every use.  The macros should be
> given this mapped immr as a parameter, not always
> map and unmap because it takes more than five minutes
> to properly change all of the APIs.
> 

So you see good in each CPM-related driver keeping its own remapped immr? It's up to driver/implementation how to handle stuff: it can remap needed things upon init and keep offsets around in internal struct, or have it ioremapped and modified in case of single-shot init/reconfigure thing. Macro is just a tool to access only necessary part of immr, and is kind of hacky just to keep arch/ppc in the loop.

> > Current code is messy at some parts, and this what I am trying to  
> > address (with current patch and upcomings).
> 
> IMHO this does nothing to clean it up.  I don't understand
> the big deal about needing to remove the IMMR as a global
> pointer.  The kernel has lots of other global variables that
> no one seems concerned about and admit they must be
> present.  These crappy macros and hacks in the name of
> removing a global IMMR just isn't right.
> 

Again, macros is used to keep arch/ppc/ working. direct immr usage may be efficient but pretty hacky too.
The patch is changing only arch/powerpc stuff and is sort of formal because does not really affect anything(in arch/powerpc of course) except cpm_reset and brg setting.

> > Thanks for looking at it!
> 
> I'm not in any agreement this is correct nor do I want to
> see the crap checked in.  You're turning a simple,
> couple of clock cycle memory access into huge overhead,
> probably context switchable operation.  Someone is
> going to grab a spin lock, and end up crashing on
> what appears to be a trivial memory access.....
> 
> This is not progress.

Erm.. Where exactly in this patch - cr_cmd stuff in drivers/? Overhead relies on implementation - nobody would be happy of the incremental ioremapping. 

-V
