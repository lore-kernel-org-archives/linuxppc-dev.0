Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 957CF1A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 21:37:08 +1100 (AEDT)
Message-ID: <1456396627.15739.9.camel@ellerman.id.au>
Subject: Re: [PATCH 04/12] powerpc/ftrace: Prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz,  live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 25 Feb 2016 21:37:07 +1100
In-Reply-To: <56CE4A93.2040301@gmail.com>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-4-git-send-email-mpe@ellerman.id.au>
 <56CE4A93.2040301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-25 at 11:28 +1100, Balbir Singh wrote:
> On 25/02/16 01:28, Michael Ellerman wrote:
> > @@ -300,8 +298,34 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >  	 * The load offset is different depending on the ABI. For simplicity
> >  	 * just mask it out when doing the compare.
> >  	 */
> > -	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
> > -		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
> > +	if ((op0 != 0x48000008) || ((op1 & 0xffff0000) != 0xe8410000))
> > +		return 0;
> > +	return 1;
> > +}
> > +#else
> > +static int
> > +expected_nop_sequence(void *ip, unsigned int op0, unsigned int op1)
> > +{
> > +	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
> > +	if (op0 != PPC_INST_NOP)
> > +		return 0;
> > +	return 1;

> With the magic changes, do we care for this? I think it's a bit of an overkill

I don't particularly like it either. However this code doesn't actually use the
magic, it's the reverse case of turning a nop into a call to the stub. So the
magic in the stub doesn't actually make that any safer.

I think we do at least want to check there's a nop there. But without
mprofile-kernel it's not a nop, so we need some check and it does need to be
different between the profiling ABIs. So I think for now this is the
conservative approach.

cheers
