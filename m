Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNhcY04fzzDqfh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 22:34:52 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9RBYlxX141527
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 07:34:50 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2dv00055q4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 07:34:49 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 27 Oct 2017 12:34:47 +0100
Date: Fri, 27 Oct 2017 17:04:42 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] powerpc/kprobes: refactor kprobe_lookup_name for
 safer string operations
References: <2a4b854c7fc11db576e3b7ff6dcfda94c64d2842.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <88995231cc2266dd11fac018bb2027bfbf4d255b.1508776485.git.naveen.n.rao@linux.vnet.ibm.com>
 <20171026013551.b48917de3f85993b6fee70e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026013551.b48917de3f85993b6fee70e7@kernel.org>
Message-Id: <20171027113442.di6746kkwb7f74pc@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/10/25 04:35PM, Masami Hiramatsu wrote:
> On Mon, 23 Oct 2017 22:07:41 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Use safer string manipulation functions when dealing with a
> > user-provided string in kprobe_lookup_name().
> > 
> 
> What would you mean "safer" here? using strnchr()?
> Could you please show at least an example case that causes problem in original code.

Yes, essentially about using bounded string operations. Since the 'name' 
parameter is provided by user, it's better to ensure it is within 
limits. Granted, this isn't a big deal since user needs to be root for 
accessing this API, but we felt it is good to clean up this code.

> And have one comment below:
> 
> > Reported-by: David Laight <David.Laight@ACULAB.COM>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 47 ++++++++++++++++++-------------------------
> >  1 file changed, 20 insertions(+), 27 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index a14c61855705..bbb4795660f8 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -53,7 +53,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
> >  
> >  kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> >  {
> > -	kprobe_opcode_t *addr;
> > +	kprobe_opcode_t *addr = NULL;
> >  
> >  #ifdef PPC64_ELF_ABI_v2
> >  	/* PPC64 ABIv2 needs local entry point */
> > @@ -85,36 +85,29 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> >  	 * Also handle <module:symbol> format.
> >  	 */
> >  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> > -	const char *modsym;
> >  	bool dot_appended = false;
> > -	if ((modsym = strchr(name, ':')) != NULL) {
> > -		modsym++;
> > -		if (*modsym != '\0' && *modsym != '.') {
> > -			/* Convert to <module:.symbol> */
> > -			strncpy(dot_name, name, modsym - name);
> > -			dot_name[modsym - name] = '.';
> > -			dot_name[modsym - name + 1] = '\0';
> > -			strncat(dot_name, modsym,
> > -				sizeof(dot_name) - (modsym - name) - 2);
> > -			dot_appended = true;
> > -		} else {
> > -			dot_name[0] = '\0';
> > -			strncat(dot_name, name, sizeof(dot_name) - 1);
> > -		}
> > -	} else if (name[0] != '.') {
> > -		dot_name[0] = '.';
> > -		dot_name[1] = '\0';
> > -		strncat(dot_name, name, KSYM_NAME_LEN - 2);
> > +	const char *c;
> > +	ssize_t ret = 0;
> > +	int len = 0;
> > +
> > +	if ((c = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
> > +		c++;
> > +		len = c - name;
> > +		memcpy(dot_name, name, len);
> > +	} else
> > +		c = name;
> > +
> > +	if (*c != '\0' && *c != '.') {
> > +		dot_name[len++] = '.';
> >  		dot_appended = true;
> 
> It is odd, you can call kallsyms_lookup_name(dot_name) here.

We'll then have to duplicate the strscpy() here.

Thanks for the review,
- Naveen

> 
> > -	} else {
> > -		dot_name[0] = '\0';
> > -		strncat(dot_name, name, KSYM_NAME_LEN - 1);
> >  	}
> > -	addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> > -	if (!addr && dot_appended) {
> > -		/* Let's try the original non-dot symbol lookup	*/
> > +	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
> > +	if (ret > 0)
> > +		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> > +
> > +	/* Fallback to the original non-dot symbol lookup */
> > +	if (!addr && dot_appended)
> >  		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> 
> Then we can remove dot_appended.
> 
> Thank you,
> 
> > -	}
> >  #else
> >  	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> >  #endif
> > -- 
> > 2.14.2
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 
