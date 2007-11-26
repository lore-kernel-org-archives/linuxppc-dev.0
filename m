Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Flexible tree checking infrastructure (v2) 
In-Reply-To: Your message of "Thu, 22 Nov 2007 14:38:07 +1100."
	<20071122033807.GH19445@localhost.localdomain>
References: <20071121053851.GA17801@localhost.localdomain>
	<20071122033807.GH19445@localhost.localdomain>
Date: Mon, 26 Nov 2007 16:13:32 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IwmCq-0002g9-Nk@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> dtc: Flexible tree checking infrastructure
> 
> Here, at last, is a substantial start on revising dtc's infrastructure
> for checking the tree; this is the rework I've been saying was
> necessary practically since dtc was first release.
> 
> In the new model, we have a table of "check" structures, each with a
> name, references to checking functions, and status variables.  Each
> check can (in principle) be individually switched off or on (as either
> a warning or error).  Checks have a list of prerequisites, so if
> checks need to rely on results from earlier checks to make sense (or
> even to avoid crashing) they just need to list the relevant other
> checks there.
> 
> For now, only the "structural" checks and the fixups for phandle
> references are converted to the new mechanism.  The rather more
> involved semantic checks (which is where this new mechanism will
> really be useful) will have to be converted in future patches.
> 
> At present, there's no user interface for turning on/off the checks -
> the -f option now forces output even if "error" level checks fail.
> Again, future patches will be needed to add the fine-grained control,
> but that should be quite straightforward with the infrastructure
> implemented here.
> 
> Also adds a testcase for the handling of bad references, which catches
> a bug encountered while developing this patch.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

While I've Applied this one, it has introduced this:

         CC dtc.o
    dtc.c: In function 'main':
    dtc.c:199: warning: 'structure_ok' is used uninitialized in this function

Followup easy patch?

Thanks,
jdl
