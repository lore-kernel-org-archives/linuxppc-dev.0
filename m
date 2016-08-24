Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJphL5xsczDrcJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 10:53:22 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7O0mRhd044594
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 20:53:19 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0b-001b2d01.pphosted.com with ESMTP id 250w81grv7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 20:53:19 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 23 Aug 2016 21:53:17 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 51A201DC0071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 20:53:06 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7O0rFbd8585620
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 21:53:15 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7O0rE5e025570
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 21:53:15 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, kexec@lists.infradead.org,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
Date: Tue, 23 Aug 2016 21:53:12 -0300
In-Reply-To: <CAOSf1CGyfz97NLyrfxkHZ3-Hwq7R2ZsN8L3f3=aEjH0zyToz3A@mail.gmail.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <239172a5-1952-de2d-e48d-4ca7d882356c@gmail.com>
 <CAOSf1CGyfz97NLyrfxkHZ3-Hwq7R2ZsN8L3f3=aEjH0zyToz3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2306975.WkzT978XXa@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Mittwoch, 24 August 2016, 10:50:26 schrieb Oliver O'Halloran:
> On Tue, Aug 23, 2016 at 1:21 PM, Balbir Singh <bsingharora@gmail.com> 
wrote:
> >> zImage on ppc64 BE is an ELF32 file. This patch set only supports
> >> loading
> >> ELF files of the same class as the kernel, so a 64 bit kernel can't
> >> load an ELF32 file. It would be possible to add such support, but it
> >> would be a new feature.
> >> 
> >> The distros I was able to check on ppc64 LE and BE all use vmlinux.
> >> kexec-tools with kexec_load also doesn't support zImage. Do you think
> >> it is important to support zImage?
> > 
> > Well if it didn't work already, I think its low priority. Michael should
> > be able to confirm this. Oliver's been trying to cleanup the zImage to
> > get rid the old zImage limitation, cc'ing him
> 
> I don't think it's ever worked so I wouldn't worry too much about
> supporting it. Fixing kexec-into-zImage and fixing the 32bit wrapper
> on 64bit BE kernel problem has been on my TODO list for a while, but
> it's not a priority.

Ok, thanks for your input.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
