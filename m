Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9R364bjDzDvQ4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 02:44:18 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA4FiBlB037785
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 11:44:16 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26gw5ngcfh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 11:44:14 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 13:44:08 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 157AD1DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 11:44:01 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA4Fi1UX4956350
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 13:44:01 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA4Fi0YK022579
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 13:44:00 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
Date: Fri, 04 Nov 2016 13:43:55 -0200
In-Reply-To: <20161104073840.GD4314@x1>
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1558014.uilYosVS7M@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Baoquan,

Am Freitag, 4. November 2016, 15:38:40 BRST schrieb Baoquan He:
> On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > The kexec_file code currently builds the purgatory as a partially linked
> > object (using ld -r). Is there a particular reason to use that instead of
> > a position independent executable (PIE)?
> 
> It's taken as "-r", relocatable in user space kexec-tools too originally.
> I think Vivek just keeps it the same when moving into kernel.

Ok. If that's the only reason then PIE is better suited at least for powerpc.

> > I found a discussion from 2013 in the archives but from what I understood
> > it was about the purgatory as a separate object vs having it linked into
> > the kernel, which is different from what I'm asking:
> > 
> > http://lists.infradead.org/pipermail/kexec/2013-December/010535.html
> > 
> > Here is my motivation for this question:
> >  On ppc64 purgatory.ro has 12 relocation types when built as a partially
> > 
> > linked object. This makes arch_kexec_apply_relocations_add duplicate a lot
> > of code with module_64.c:apply_relocate_add to implement these
> > relocations. The alternative is to do some refactoring so that both
> > functions can share the implementation of the relocations. This is done
> > in patches 5 and 6 of the
> > kexec_file_load implementation for powerpc:
> In user space kexec-tools utility, you also got this problem?

Yes, kexec-tools' purgatory.ro has 10 relocation types instead of 12 (I don't 
know why), but that's still a lot.

> > @@ -942,7 +1085,13 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct
> > purgatory_info *pi,> 
> >  		/* Go through symbols for a match */
> >  		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > 
> > -			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > +			/*
> > +			 * FIXME: See if we can or should export the .TOC.
> > +			 * symbol as global instead of searching local symbols
> > +			 * here.
> > +			 */
> > +			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL &&
> > +			    ELF_ST_BIND(syms[k].st_info) != STB_LOCAL)
> > 
> >  				continue;
> >  			
> >  			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > 

I don't need the change above anymore. I found a way to obtain the TOC pointer 
without looking for the .TOC. symbol.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
