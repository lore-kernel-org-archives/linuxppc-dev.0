Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gc5b2wnRzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 01:04:03 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w71Exv3F034887
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Aug 2018 11:04:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkf4387x6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Aug 2018 11:04:00 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Wed, 1 Aug 2018 09:03:59 -0600
Date: Wed, 1 Aug 2018 12:03:50 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Joe Perches <joe@perches.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 9/9] powerpc/traps: Add line prefix in
 show_instructions()
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-10-muriloo@linux.ibm.com>
 <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
Message-Id: <20180801150350.GC6022@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Christophe.

On Wed, Aug 01, 2018 at 08:41:15AM +0200, Christophe LEROY wrote:
>
>
> Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > Remove "Instruction dump:" line by adding a prefix to display current->comm
> > and current->pid, along with the instructions dump.
> >
> > The prefix can serve as a glue that links the instructions dump to its
> > originator, allowing messages to be interleaved in the logs.
> >
> > Before this patch, a page fault looked like:
> >
> >    pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
> >    Instruction dump:
> >    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> >
> > After this patch, it looks like:
> >
> >    pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e5100 code 2 in pandafault[10000000+10000]
> >    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> >
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>
> Does the script scripts/decode_stacktrace.sh also works with this format
> change ?

I've got more feedback from Michael about this.  A better approach would be
having a new show_user_instructions(), a slightly modified version of
show_instructions(), that can be called from within show_signal_msg().

Since _exception_pkey() dies if the exception is in kernel mode, we'll be
safe to call the new show_user_instructions(), without interfering in
scripts/decode_stacktrace.sh.

Cheers
Murilo
