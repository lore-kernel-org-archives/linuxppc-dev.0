Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ04P3NNCzDvRX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 18:53:09 +1100 (AEDT)
Date: Tue, 15 Nov 2016 18:52:58 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64: Simplify adaptation to new ISA v3.00 HPTE
 format
Message-ID: <20161115075258.GA1892@fergus.ozlabs.ibm.com>
References: <20161111055503.z4b6urq7xkgworrw@oak.ozlabs.ibm.com>
 <cf75750b-5c11-ce06-381b-a208da30b7b3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cf75750b-5c11-ce06-381b-a208da30b7b3@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2016 at 11:26:00AM +1100, Balbir Singh wrote:
> 
> 
> On 11/11/16 16:55, Paul Mackerras wrote:
> > This changes the way that we support the new ISA v3.00 HPTE format.
> > Instead of adapting everything that uses HPTE values to handle either
> > the old format or the new format, depending on which CPU we are on,
> > we now convert explicitly between old and new formats if necessary
> > in the low-level routines that actually access HPTEs in memory.
> > This limits the amount of code that needs to know about the new
> > format and makes the conversions explicit.  This is OK because the
> > old format contains all the information that is in the new format.
...
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +		hpte_r = hpte_old_to_new_r(hpte_v, hpte_r);
> > +		hpte_v = hpte_old_to_new_v(hpte_v);
> 
> I don't think its called out, but it seems like we have a depedency where
> hpte_old_to_new_r MUST be called prior to hpte_old_to_new_v, since we need
> the v bit to be extracted and moved to the _r bit. I suspect one way to avoid
> that dependency is to pass the ssize_field or to do both conversions at once.

There is no dependency between the functions.  The functions are pure
functions.  If you are overwriting the input values with the output
values, then yes you need to call the functions with the inputs not
the outputs.  I would like to think that even programmers of average
skill can see that

	a = foo(a, b);
	b = bar(b);

computes something different from

	b = bar(b);
	a = foo(a, b);

If someone is going to be so careless as to overlook that difference,
then I don't believe they would bother to read a comment either.  (I
know for sure that people don't read comments, as witnessed by the KVM
bug I found recently.)

Paul.
