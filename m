Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgY2w5pYyzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 07:44:08 +1000 (AEST)
Date: Thu, 30 Jun 2016 17:43:57 -0400
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 2/9] kexec_file: Generalize kexec_add_buffer.
Message-ID: <20160630214357.GB4187@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160630150700.GA3058@dhcp-128-65.nay.redhat.com>
 <1866019.1p7Z0CLUZh@hactar> <1902156.s2yTykCR7c@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1902156.s2yTykCR7c@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/16 at 01:42pm, Thiago Jung Bauermann wrote:
> Am Donnerstag, 30 Juni 2016, 12:49:44 schrieb Thiago Jung Bauermann:
> > Am Donnerstag, 30 Juni 2016, 11:07:00 schrieb Dave Young:
> > > On 06/29/16 at 06:18pm, Thiago Jung Bauermann wrote:
> > > > I'm not following. The IMA buffer patchset doesn't use
> > > > kexec_locate_mem_hole nor struct kexec_buf.
> > > 
> > > It does not use kexec_locate_mem_hole, but the buffer being passed is
> > > very similar to a kexec_buf struct, no?
> > 
> > If what you're saying is that the arguments passed to
> > kexec_add_handover_buffer in the IMA buffer patchset are very similar to
> > the arguments passed to kexec_add_buffer then yes, it's true.
> > 
> > > So you may refactor kexec_add_buffer and your new function to pass only
> > > kimage and a kbuf, it will be better than passing all those arguments
> > > separately.
> > 
> > To be honest I think struct kexec_buf is an implementation detail inside
> > kexec_locate_mem_hole, made necessary because the callback functions it
> > uses need to access its arguments. Callers of kexec_locate_mem_hole,
> > kexec_add_handover_buffer and kexec_add_buffer shouldn't need to know it
> > exists.
> 
> Elaborating a bit more: the argument list for these three functions are 
> equal or similar because kexec_add_handover_buffer uses kexec_add_buffer, 
> which uses kexec_locate_mem_hole.
> 
> It could be beneficial to have a struct to collect the arguments to these 
> functions if someone using one of them would be likely to use another one 
> with the same arguments. In that case, you set up kexec_buf once and then 
> just pass it whenever you need to call one of those functions.
> 
> But that is unlikely to happen. A user of the kexec API will need to use 
> only one of these functions with a given set of arguments, so they don't 
> gain anything by setting up a struct.
> 
> Syntactically, I also don't think it's clearer to set struct members instead 
> of simply passing arguments to a function, even if the argument list is 
> long.

Sorry, I'm not sure I get your points but the long argument list really looks ugly,
since you are introducing more callbacks I still think a cleanup is necessary.

kexec_buffer struct is pretty fine to be a abstract of all these buffers.

Thanks
Dave
