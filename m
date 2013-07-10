Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id E4DD72C0182
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 10:00:50 +1000 (EST)
Message-ID: <1373414448.7458.42.camel@gandalf.local.home>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Emulate MCSRR0/1 SPR and rfmci
 instruction
From: Steven Rostedt <rostedt@goodmis.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 09 Jul 2013 20:00:48 -0400
In-Reply-To: <1373408783.8183.208@snotra>
References: <1373408783.8183.208@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>,
 "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 17:26 -0500, Scott Wood wrote:
> On 07/09/2013 05:00:26 PM, Alexander Graf wrote:
> > 
> > On 09.07.2013, at 23:54, Scott Wood wrote:
> > 
> > > On 07/09/2013 04:49:32 PM, Alexander Graf wrote:
> > >> Not sure I understand. What the timing stats do is that they  
> > measure the time between [exit ... entry], right? We'd do the same  
> > thing, just all in C code. That means we would become slightly less  
> > accurate, but gain dynamic enabling of the traces and get rid of all  
> > the timing stat asm code.
> > >
> > > Compile-time enabling bothers me less than a loss of accuracy (not  
> > just a small loss by moving into C code, but a potential for a large  
> > loss if we overflow the buffer)
> > 
> > Then don't overflow the buffer. Make it large enough.
> 
> How large is that?  Does the tool recognize and report when overflow  
> happens?

Note, the ftrace buffers allow you to see when overflow does happen.

> 
> How much will the overhead of running some python script on the host,  
> consuming a large volume of data, affect the results?

This doesn't need to be python, and you can read the buffers in binary
as well. Mauro wrote a tool that uses ftrace for MCE errors. You can
probably do something similar. I need to get the code that reads ftrace
binary buffers out as a library.


> 
> > IIRC ftrace improved recently to dynamically increase the buffer size  
> > too.

What did change was that you can create buffers for your own use.

> > 
> > Steven, do I remember correctly here?
> 
> Yay more complexity.

What? Is ftrace complex? ;-)

> 
> So now we get to worry about possible memory allocations happening when  
> we try to log something?  Or if there is a way to do an "atomic" log,  
> we're back to the "buffer might be full" situation.

Nope, ftrace doesn't do dynamic allocation here.

-- Steve

> 
> > > and a dependency on a userspace tool
> > 
> > We already have that for kvm_stat. It's a simple python script - and  
> > you surely have python on your rootfs, no?
> > 
> > > (both in terms of the tool needing to be written, and in the hassle  
> > of ensuring that it's present in the root filesystem of whatever  
> > system I'm testing).  And the whole mechanism will be more  
> > complicated.
> > 
> > It'll also be more flexible at the same time. You could take the logs  
> > and actually check what's going on to debug issues that you're  
> > encountering for example.
> > 
> > We could even go as far as sharing the same tool with other  
> > architectures, so that we only have to learn how to debug things once.
> 
> Have you encountered an actual need for this flexibility, or is it  
> theoretical?
> 
> Is there common infrastructure for dealing with measuring intervals and  
> tracking statistics thereof, rather than just tracking points and  
> letting userspace connect the dots (though it could still do that as an  
> option)?  Even if it must be done in userspace, it doesn't seem like  
> something that should be KVM-specific.
> 
> > > Lots of debug options are enabled at build time; why must this be  
> > different?
> > 
> > Because I think it's valuable as debug tool for cases where compile  
> > time switches are not the best way of debugging things. It's not a  
> > high profile thing to tackle for me tbh, but I don't really think  
> > working heavily on the timing stat thing is the correct path to walk  
> > along.
> 
> Adding new exit types isn't "working heavily" on it.
> 
> -Scott
