Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 Sep 2013 09:54:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/6] powerpc: Provide for giveup_fpu/altivec to save
 state in alternate location
Message-ID: <20130910235444.GD4455@iris.ozlabs.ibm.com>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
 <20130910102110.GC28145@iris.ozlabs.ibm.com>
 <675235E3-6991-4DB1-90A4-935E826F6413@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <675235E3-6991-4DB1-90A4-935E826F6413@suse.de>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 10, 2013 at 12:12:47PM -0500, Alexander Graf wrote:
> 
> On 10.09.2013, at 05:21, Paul Mackerras wrote:
> 
> > @@ -212,6 +212,7 @@ struct thread_struct {
> > #endif
> > #endif
> > 	struct thread_fp_state	fp_state;
> > +	struct thread_fp_state	*fp_save_area;
> 
> Why do you need these pointers? Couldn't you handle everything you need through preempt notifiers?

As you note in your review of a later patch, no, I need the pointer so
that if in-kernel code wants to use FP or VSX, potentially in the
context of this same process, it knows where to save the FP/VSX state
away to.

Paul.
