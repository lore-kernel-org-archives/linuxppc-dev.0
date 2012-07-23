Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 21:06:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
Message-ID: <20120723110654.GC29264@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120723093951.GB29264@bloggs.ozlabs.ibm.com>
 <87txwyhj5e.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87txwyhj5e.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2012 at 03:52:05PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:
> >
> >> -#define USER_ESID_BITS		16
> >> -#define USER_ESID_BITS_1T	4
> >> +#define USER_ESID_BITS		18
> >> +#define USER_ESID_BITS_1T	6
> >
> > You also need to change the proto-VSID generation for kernel addresses
> > when you do this.  If you don't you'll end up with some user processes
> > using the same VSIDs as we use for the kernel addresses, meaning that
> > those processes won't run very well...
> >
> 
> Can you explain this more. right now we generate vsid as below
> 
> vsid_scramble(ea >> SID_SHIFT, 256M) for kernel
> 
> vsid_scramble((context << USER_ESID_BITS) | (ea >> SID_SHIFT), 256M);
> for user
> 
> what changes are you suggesting ?

Think about it.  With the current values of USER_ESID_BITS and
CONTEXT_BITS, and the addresses we use for kernel mappings, there are
no values of context, user_ea and kernel_ea for which

kernel_ea >> SID_SHIFT == (context << USER_ESID_BITS) | (user_ea >> SID_SHIFT)

If you increase USER_ESID_BITS, then there will be some context values
for which that equation becomes true.  For example, if you increase
USER_ESID_BITS to 18, then context 0x30000 will generate the same
proto-VSIDs as the kernel linear mapping.  Since we can hand out
contexts up to 0x7ffff (with CONTEXT_BITS = 19), there is a collision.

In other words, the proto-VSID space (the space of values that are
input to vsid_scramble) is currently divided into two mutually
exclusive regions: from 0 to 2^35 - 1 for user processes, and from
2^35 to 2^36 - 1 for kernel addresses.  You are wanting to expand the
amount of proto-VSID space that user processes can use, but you need
either to move the kernel portion of the space, or to make sure that
the context allocator doesn't hand out context values that would
collide with the kernel portion of the space (or both).

Paul.
