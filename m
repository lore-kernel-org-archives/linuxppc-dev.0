Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7K363gFmzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:07:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JAwsie122420
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 07:07:23 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29wqq190n8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 07:07:23 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 16:37:20 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JB5rtj13434928
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 16:35:53 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JB7FxO005700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 16:37:17 +0530
Date: Wed, 19 Apr 2017 16:37:13 +0530
From: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/5] kprobes: convert kprobe_lookup_name() to a function
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <2780c632bc2c6e39f27920f8cc98e17430189e27.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C07@AcuExch.aculab.com>
 <1492589122.ncy876vm18.astroid@naverao1-tp.none>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD4D95@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFD4D95@AcuExch.aculab.com>
Message-Id: <20170419110713.GA4751@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/04/19 08:48AM, David Laight wrote:
> From: Naveen N. Rao
> > Sent: 19 April 2017 09:09
> > To: David Laight; Michael Ellerman
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Masami Hiramatsu; Ingo Molnar
> > Subject: RE: [PATCH v2 1/5] kprobes: convert kprobe_lookup_name() to a function
> > 
> > Excerpts from David Laight's message of April 18, 2017 18:22:
> > > From: Naveen N. Rao
> > >> Sent: 12 April 2017 11:58
> > > ...
> > >> +kprobe_opcode_t *kprobe_lookup_name(const char *name)
> > >> +{
> > > ...
> > >> +	char dot_name[MODULE_NAME_LEN + 1 + KSYM_NAME_LEN];
> > >> +	const char *modsym;
> > >> +	bool dot_appended = false;
> > >> +	if ((modsym = strchr(name, ':')) != NULL) {
> > >> +		modsym++;
> > >> +		if (*modsym != '\0' && *modsym != '.') {
> > >> +			/* Convert to <module:.symbol> */
> > >> +			strncpy(dot_name, name, modsym - name);
> > >> +			dot_name[modsym - name] = '.';
> > >> +			dot_name[modsym - name + 1] = '\0';
> > >> +			strncat(dot_name, modsym,
> > >> +				sizeof(dot_name) - (modsym - name) - 2);
> > >> +			dot_appended = true;
> > >
> > > If the ':' is 'a way down' name[] then although the strncpy() won't
> > > overrun dot_name[] the rest of the code can.
> > 
> > Nice catch, thanks David!
> > We need to be validating the length of 'name'. I'll put out a patch for
> > that.
> 
> Silent truncation is almost certainly wrong here.

Indeed. This will be handled by the earlier validation to ensure that 
the module name as well as the symbol name are within the expected 
lengths.

> 
> > As an aside, I'm not sure I follow what you mean when you say that the
> > strncpy() won't overrun dot_name[]. If we have a name[] longer than
> > sizeof(dot_name) with the ':' after that, the strncpy() can also overrun
> > dot_name[].
> 
> Yes, that should just be a memcpy(), as should the strncat().
> 
> Using strncpy() where the length is other than the size of the target buffer
> should be banned. Not that it ever does what people expect.
> strncat() is even worse.

Sure, but with the proper validation, I still think string functions are 
convenient and useful here. I agree about your view on strncat(), so 
I'll switch to strlcat() instead.

Thanks,
Naveen
