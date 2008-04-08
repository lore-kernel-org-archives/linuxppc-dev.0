Return-Path: <dgaur@cdotd.ernet.in>
Received: from sandesh.cdotd.ernet.in (sandesh.cdotd.ernet.in [196.1.105.47])
	by ozlabs.org (Postfix) with ESMTP id 6B6C1DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Apr 2008 21:08:25 +1000 (EST)
From: "Deepak Gaur" <dgaur@cdotd.ernet.in>
To: "David Baird" <dhbaird@gmail.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: MVL Linux on MPC8560 Booting goes into infinite loop
	inearly_init memset_io ( )
Date: Tue, 8 Apr 2008 17:45:52 +0630
Message-Id: <20080408110411.M21892@cdotd.ernet.in>
In-Reply-To: <440abda90804071250v60bd970fh938e9690836ab61@mail.gmail.com>
References: <20080407064547.M56295@cdotd.ernet.in><47FA4601.1080707@freescal
	e.com> <440abda90804071250v60bd970fh938e9690836ab61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Thanks for valuable inputs.. memset_io() issue got resolved after I invalidated the L1
data and Instruction cache before calling early_init(was mentioned in some mailing list
). The code execution resumed and somewhere during MMU_init it again got struck.This
time its due to a DataTLBError. I am now trying to trace the function causing TLB miss
using ICE Trace32. Any pointers for reason behind generation of DataTLBError during MMU_init

Thanks  

Deepak Gaur
On Mon, 7 Apr 2008 13:50:04 -0600, David Baird wrote
> On Mon, Apr 7, 2008 at 10:04 AM, Scott Wood <scottwood@freescale.com> wrote:
> >  BTW, it's generally bad form to post the same question repeatedly.  If you
> > have new information regarding your problem, just post a followup in the
> > same thread containing the new information.
> 
> Agreed!  I was about to respond to your new post, and then I
> discovered this nearly identical slightly older post.
> 
> On Mon, Apr 7, 2008 at 12:37 AM, Deepak Gaur <gaur.deepak@gmail.com> wrote:
> > While booting MVL linux on MPC8560 based board the kernel goes into a
> > infinite loop in setup.c
> 
> Someone please correct me if I am wrong, but those symbols inside the
> BSS should only be variables (not functions....) which are initialized
> to zero.  The whole reason for BSS is to initialize variables to a
> 0/null value.
> 
> Now, about the infinite loop.  Can you check to see if perhaps you are
> getting an exception?
> 
> I have no experience with the MPC8560, but I've seen a couple problems
> that occur involving memset_io.  What happens is that a TLB miss
> exception occurs when the CPU gets inside of memset_io.  Do you have
> the ability to check that with a debugger (by setting breakpoints at
> exceptions, such as the data and instruction TLB miss exceptions) to
> see if you are getting exceptions?
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


Deepak Gaur
