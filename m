Return-Path: <michael@ellerman.id.au>
Date: Thu, 25 Jul 2013 13:15:01 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
Message-ID: <20130725031501.GA15673@concordia>
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com>
 <51ECD0BF.8080605@asianux.com> <51ECD3D4.9020405@asianux.com>
 <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia> <51EF1F97.3070409@asianux.com>
 <20130724011640.GA6042@concordia> <51EF375D.9060006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51EF375D.9060006@asianux.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>, "paulus@samba.org" <paulus@samba.org>,
 chenhui.zhao@freescale.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 24, 2013 at 10:09:33AM +0800, Chen Gang wrote:
> On 07/24/2013 09:16 AM, Michael Ellerman wrote:
> > On Wed, Jul 24, 2013 at 08:28:07AM +0800, Chen Gang wrote:
> >> > On 07/23/2013 09:44 PM, Michael Ellerman wrote:
> >>> > > On Mon, Jul 22, 2013 at 12:21:16PM +0530, Srivatsa S. Bhat wrote:
> >>>> > >> On 07/22/2013 12:10 PM, Chen Gang wrote:
> >>>>> > >>> Since not need 'max_cpus' after the related commit, the related code
> >>>>> > >>> are useless too, need be removed.
> >>> > > 
> >>> > > A good follow up patch, or actually series of patches, would be to
> >>> > > change the prototype of smp_ops->probe() to return void, and fix all the
> >>> > > implementations to no longer return anything.
> >>> > > 
> >> > 
> >> > Hmm... normally, a function need have a return value, it will make it
> >> > more extensible (especially, it is an API which need be implemented in
> >> > various sub modules).
> > A function doesn't need a return value, and if it needs one in future then
> > we'll add it then. We don't carry code around "just in case".
> 
> But for API (also include the internal API), at least, better to always
> provide the return value which can indicate failure by negative number
> (if succeed can return the meanness value, e.g. the number of cpus).

Are we still talking about this?

There is no point returning a value when no one checks it. Which is the
case here.

For a published API maybe it's a good idea to have a return value "just
in case", but this is kernel internal and we own both the implementation
and the callers of the API.

> >> > Even though the return value may be useless, now, if the performance is
> >> > not quite important in our case, I still suggest to have it (especially
> >> > each various original implementation already has it).

> > It's dead code, it should be removed.
> 
> For API, if not cause the real world issue, better to keep compatible
> (especially, the return value still can indicate failure by negative
> number).

No. Dead code is a real world issue. If we ever need a return value
we'll add one then.

cheers
