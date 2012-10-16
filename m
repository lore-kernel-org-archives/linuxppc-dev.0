Return-Path: <michael@ellerman.id.au>
Message-ID: <1350367235.32704.1.camel@concordia>
Subject: Re: [PATCH] kvm/powerpc: Handle errors in secondary thread grabbing
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Date: Tue, 16 Oct 2012 17:00:35 +1100
In-Reply-To: <20121016031352.GK1218@drongo>
References: <1350346550-32539-1-git-send-email-michael@ellerman.id.au>
 <20121016031352.GK1218@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-16 at 14:13 +1100, Paul Mackerras wrote:
> Michael,
> 
> On Tue, Oct 16, 2012 at 11:15:50AM +1100, Michael Ellerman wrote:
> > In the Book3s HV code, kvmppc_run_core() has logic to grab the secondary
> > threads of the physical core.
> > 
> > If for some reason a thread is stuck, kvmppc_grab_hwthread() can fail,
> > but currently we ignore the failure and continue into the guest. If the
> > stuck thread is in the kernel badness ensues.
> > 
> > Instead we should check for failure and bail out.
> > 
> > I've moved the grabbing prior to the startup of runnable threads, to simplify
> > the error case. AFAICS this is harmless, but I could be missing something
> > subtle.
> 
> Thanks for looking at this - but in fact this is fixed by my patch
> entitled "KVM: PPC: Book3S HV: Fix some races in starting secondary
> threads" submitted back on August 28.

OK thanks. It seems that patch didn't make 3.7 ?

I don't see it in kvm-ppc-next either.

cheers
