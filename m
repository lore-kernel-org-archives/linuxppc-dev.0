Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfFys41dYzDqsp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 05:21:09 +1000 (AEST)
Date: Tue, 28 Jun 2016 15:20:55 -0400
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, vgoyal@redhat.com,
 Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Message-ID: <20160628192055.GA3165@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4923900.bfxGnX6mM2@hactar>
 <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
 <5428891.iJNV8CI1We@hactar>
 <20160627202125.GA9230@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160627202125.GA9230@dhcp-128-65.nay.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/16 at 04:21pm, Dave Young wrote:
> Please ignore previous reply, I mistakenly send a broken mail without
> subject, sorry about it. Resend the reply here.
> 
> On 06/27/16 at 01:37pm, Thiago Jung Bauermann wrote:
> > Am Dienstag, 28 Juni 2016, 00:19:48 schrieb Dave Young:
> > > On 06/23/16 at 12:37pm, Thiago Jung Bauermann wrote:
> > > > Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> > > > What is bad about the description of top_down?
> > > It is not clear enough to me, I personally think the original one in
> > > source code is better:
> > > /* allocate from top of memory hole */
> > 
> > Actually I realized there's some discrepancy in how the x86 code uses 
> > top_down and how I need it to work in powerpc. This may be what is confusing 
> > about my comment and the existing comment.
> > 
> > x86 always walks memory from bottom to top but if top_down is true, in each 
> > memory region it will allocate the memory hole in the highest address within 
> > that region. I don't know why it is done that way, though.
> 
> I think we did not meaning to do this, considering kdump we have only
> one crashkernel region for searching (crashk_res) so it is fine.
> For kexec maybe changing the walking function to accept top_down is
> reasonable.
>  
> Ccing Vivek see if he can remember something..
> 
> > 
> > On powerpc, the memory walk itself should be from top to bottom, as well as 
> > the memory hole allocation within each memory region.

What is the particular reason in powerpc for a mandatory top to bottom
walking?

> > 
> > Should I add a separate top_down argument to kexec_locate_mem_hole to 
> > control if the memory walk should be from top to bottom, and then the 
> > bottom_up member of struct kexec_buf controls where inside each memory 
> > region the memory hole will be allocated?

Using one argument for both sounds more reasonable than using a separate
argument for memory walk..

Thanks
Dave
