Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkKzX4D2RzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 20:35:52 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ib6so2067566pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 03:35:52 -0700 (PDT)
Date: Tue, 5 Jul 2016 05:08:41 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linux-kernel@vger.kernel.org, Simon Guo <simonguo@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND, v2] powerpc: Export thread_struct.used_vr/used_vsr to
 user space
Message-ID: <20160704210841.GA8915@simonLocalRHEL7.x64>
References: <20160406070012.GA11647@simonLocalRHEL7.x64>
 <3rkCQx0jldz9sBl@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3rkCQx0jldz9sBl@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,
On Tue, Jul 05, 2016 at 03:40:40PM +1000, Michael Ellerman wrote:
> On Wed, 2016-06-04 at 07:00:12 UTC, Simon Guo wrote:
> > These 2 fields track whether user process has used Altivec/VSX
> > registers or not. They are used by kernel to setup signal frame
> > on user stack correctly regarding vector part.
> > 
> > CRIU(Checkpoint and Restore In User space) builds signal frame
> > for restored process. It will need this export information to
> > setup signal frame correctly. And CRIU will need to restore these
> > 2 fields for the restored process.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> > @@ -176,6 +176,17 @@ struct pt_regs {
> >  #define PTRACE_GETREGS64	  0x16
> >  #define PTRACE_SETREGS64	  0x17
> >  
> > +/*
> > + * Get or set some register used bit.
> > + * The flags will be saved in a 32 bit data.
> > + * Currently it is only used for VR/VSR usage.
> > + */
> > +#define PTRACE_GET_REGS_USAGE	  0x1e
> > +#define PTRACE_SET_REGS_USAGE	  0x1f
> > +
> > +#define PTRACE_REGS_USAGE_VR_BIT  0x00000001
> > +#define PTRACE_REGS_USAGE_VSR_BIT 0x00000002
> 
> 
> It looks like you just made up this new ptrace ABI ?
> 
> Or is it used on other arches ? (no AFAICS)
> 
> How do other arches handle this ?
> 
> I'm a bit wary of adding new ptrace ABIs.
> 
> If we do want to do this, I'd at least think the mask should be u64, to give us
> more capacity to add new registers.
> 
> cheers

It is only used on PowerPc currently. I had better rename
it to:
#define PPC_PTRACE_GET_REGS_USAGE        0x96
#define PPC_PTRACE_SET_REGS_USAGE        0x97

I will change the mask into u64. 

Thanks,
- Simon
