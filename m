Return-Path: <paulus@ozlabs.org>
Date: Tue, 22 Nov 2011 08:29:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 01/11] KVM: PPC: Add memory-mapping support for PCI
 passthrough and emulation
Message-ID: <20111121212950.GB10212@bloggs.ozlabs.ibm.com>
References: <20111116225055.GA26985@bloggs.ozlabs.ibm.com>
 <20111116225209.GB26985@bloggs.ozlabs.ibm.com>
 <4EC8F158.8010706@redhat.com>
 <20111121110356.GA1516@bloggs.ozlabs.ibm.com>
 <4ECA42A2.1040300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ECA42A2.1040300@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 21, 2011 at 02:22:58PM +0200, Avi Kivity wrote:
> On 11/21/2011 01:03 PM, Paul Mackerras wrote:
> > OK, so that's a somewhat different mental model than I had in mind.  I
> > can change the code to do almost everything on a per-page basis at
> > fault time on POWER7.  There is one thing we can't do at fault time,
> > which is to tell the hardware the page size for the "virtual real mode
> > area" (VRMA), which is a mapping of the memory starting at guest
> > physical address zero.  We can however work out that pagesize the
> > first time we run a vcpu.  By that stage we must have some memory
> > mapped at gpa 0, otherwise the vcpu is not going to get very far.  We
> > will need to look for the page size of whatever is mapped at gpa 0 at
> > that point and give it to the hardware.
> 
> Ok.  Do you need to check at fault time that your assumptions haven't
> changed, then?

At fault time, if we are expecting a large page and we find a small
page, pretty much all we can do is return from the vcpu_run ioctl with
an EFAULT error -- so yes we do check the page-size assumption at
fault time.  The other way around isn't a problem (expecting small
page and find large page), of course.

> > > What happens if mmu notifiers tell you to write protect a page?
> >
> > On POWER7, we have to remove access to the page, and then when we get
> > a fault on the page, request write access when we do
> > get_user_pages_fast.
> 
> Ok, so no ksm for you.  Does this apply to kvm-internal write
> protection, like we do for the framebuffer and live migration?  I guess
> you don't care much about the framebuffer (and anyway it doesn't need
> read-only access), but removing access for live migration is painful.

For the framebuffer, we can use the hardware 'C' (changed) bit to
detect dirty pages without having to make them read-only.

On further thought, we can in fact make pages read-only when the guest
thinks they're read/write, at the cost of making the real protection
faults in the guest a little slower.  I'll look into it.

Paul.
