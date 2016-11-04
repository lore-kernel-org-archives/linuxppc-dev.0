Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9X1X6Z8RzDvcs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 06:28:16 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA4JOKdu044807
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 15:28:14 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gtwyrqtj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 15:28:14 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 17:28:11 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id CAC961DC007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 15:19:56 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA4JJu0529491482
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 17:19:56 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA4JJu9u025914
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 17:19:56 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
Date: Fri, 04 Nov 2016 17:19:53 -0200
In-Reply-To: <871syrcm70.fsf@xmission.com>
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
 <871syrcm70.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3998943.Ju5lgDeipl@morokweng>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Eric,

Am Freitag, 4. November 2016, 10:13:39 BRST schrieb Eric W. Biederman:
> Baoquan He <bhe@redhat.com> writes:
> > On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
> >> Hello,
> >> 
> >> The kexec_file code currently builds the purgatory as a partially linked
> >> object (using ld -r). Is there a particular reason to use that instead
> >> of a position independent executable (PIE)?
> > 
> > It's taken as "-r", relocatable in user space kexec-tools too originally.
> > I think Vivek just keeps it the same when moving into kernel.
> 
> At least on x86 using just -r removed the need for a GOT and all of the
> other nasty dynamic relocatable bits, that are not needed when the you
> don't want to share your text bits with the page cache.
> 
> I can see reaons for refactoring code but I expect PIE expecutables need
> a GOT and all of that pain in the neck stuff that can just be avoided by
> building the code to run at an absolute address.

At least on powerpc, building the purgatory as PIE resulted in only the 
following differences:

1. A lot less relocation types to deal with.
2. __kexec_load_purgatory needs to use the program headers rather than the 
   section headers to figure out how to load the binary.
3. Symbol values are absolute addresses instead of relative to the start of 
   the section.

2. is an advantage too because it's actually easier to use the program headers 
because unlike section headers, the purpose of program headers is to provide 
the information needed by a program loader. You can see this by comparing the 
two implementations of __kexec_load_purgatory in the WIP patch I posted. The 
one using program headers is simpler.

3. isn't a problem, it's easy to convert the absolute addresses back into 
relative ones, as can be seen in my patch.

> So far I have not seen ELF relocations that are difficult to process.

The problem is not that it's difficult to process, but that on powerpc it 
takes a lot of code to implement that processing. In v9 of the kexec_file_load 
implementation for powerpc, the switch statement implementing all the 
relocation types (shared by powerpc's module_64.c and machine_kexec_file_64.c) 
has 200 lines. The switch statement implementing only the relocation types 
used by the PIE purgatory has 26 lines.

This is not a problem in x86, though: the purgatory built as a relocatable 
object has only two relocation types.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
