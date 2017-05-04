Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJgpk5wh0zDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 May 2017 02:44:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44GYTQc139031
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 12:44:12 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a7rcxguq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 12:44:11 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 5 May 2017 02:44:09 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44GhxfR7668058
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 02:44:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44GhXre022049
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 May 2017 02:43:34 +1000
Date: Thu, 4 May 2017 22:13:17 +0530
From: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Clarke <pc@us.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] powerpc/kprobes: refactor kprobe_lookup_name for
 safer string operations
References: <20170504102452.9701-1-naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFE5478@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFE5478@AcuExch.aculab.com>
Message-Id: <20170504164317.GD9733@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/04 12:45PM, David Laight wrote:
> From: Naveen N. Rao [mailto:naveen.n.rao@linux.vnet.ibm.com]
> > Sent: 04 May 2017 11:25
> > Use safer string manipulation functions when dealing with a
> > user-provided string in kprobe_lookup_name().
> > 
> > Reported-by: David Laight <David.Laight@ACULAB.COM>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > Changed to ignore return value of 0 from strscpy(), as suggested by
> > Masami.
> 
> let's see what this code looks like;
> 
> >  	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> >  	bool dot_appended = false;
> > +	const char *c;
> > +	ssize_t ret = 0;
> > +	int len = 0;
> > +
> > +	if ((c = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
> 
> I don't like unnecessary assignments in conditionals.
> 
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
> If you don't append a dot, then you can always just lookup
> the original string.
> 
> >  	}
> > +	ret = strscpy(dot_name + len, c, KSYM_NAME_LEN);
> > +	if (ret > 0)
> > +		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> 
> I'm not sure you need 'ret' here at all.
> 
> > +	/* Fallback to the original non-dot symbol lookup */
> > +	if (!addr && dot_appended)
> >  		addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
> 
> We can bikeshed this function to death:

Sure, though that was never the intent. For me, this was all about 
ensuring safe string manipulation. And I suppose my patch and your 
version both achieve that.

> 
> 	/* The function name must start with a '.'.
> 	 * If it doesn't then we insert one. */
> 	c = strnchr(name, MODULE_NAME_LEN, ':');
> 	if (c && c[1] && c[1] != '.') {
		 ^^^^^^^
		 while we're here, I might as well point out that that's 
		 un-necessary and probably a few more things below... 
		 ;-)

- Naveen

> 		/* Insert a '.' after the ':' */
> 		c++;
> 		len = c - name;
> 		memcpy(dot_name, name, len);
> 	} else {
> 		if (name[0] == '.')
> 			goto check_name:
> 		/* Insert a '.' before name */
> 		c = name;
> 		len = 0;
> 	}
> 
> 	dot_name[len++] = '.';
> 	if (strscpy(dot_name + len, c, KSYM_NAME_LEN) > 0) {
> 		addr = (kprobe_opcode_t *)kallsyms_lookup_name(dot_name);
> 		if (addr)
> 			return addr;
> 	}
> 	/* Symbol with extra '.' not found, fallback to original name */
> 
> check_name:
> 	return (kprobe_opcode_t *)kallsyms_lookup_name(name);
> 
> 	David
> 
