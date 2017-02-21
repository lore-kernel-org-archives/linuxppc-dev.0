Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS7Dp4lzSzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 15:43:54 +1100 (AEDT)
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS7Dp0hHjz9s2G
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 15:43:54 +1100 (AEDT)
Received: by mail-pg0-x231.google.com with SMTP id a123so27555429pgc.0
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:43:54 -0800 (PST)
Date: Tue, 21 Feb 2017 14:43:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 5/7] powerpc/book3s: Don't turn on the MSR[ME] bit
 until opal processes the reason.
Message-ID: <20170221144340.3f784ff3@roar.ozlabs.ibm.com>
In-Reply-To: <c3a85fbf-29e8-e20d-dc68-6c1f1413d063@linux.vnet.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
 <148764197591.19289.17096730042146758117.stgit@jupiter.in.ibm.com>
 <20170221124728.675af9f9@roar.ozlabs.ibm.com>
 <c3a85fbf-29e8-e20d-dc68-6c1f1413d063@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Feb 2017 09:47:53 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 02/21/2017 08:17 AM, Nicholas Piggin wrote:
> > On Tue, 21 Feb 2017 07:22:56 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >   
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> Delay it until we are done with machine_check_early() call. Turn on MSR[ME]
> >> once opal is done with processing MCE.  
> > 
> > Why? This seems like quite a regression -- the MCE handler today
> > has about 60 instructions and 30 l/st with ME clear.  
> 
> I understand that this is bit long window. But we are in MCE handling
> code and if we hit MCE while doing that we may anyway end up with
> recursive MCE interrupts without really be able to recover from it.

There is careful code to handle recursive machine checks though.
Things should be structured so we will handle recursive MCEs and
recover/fail/checkstop properly.

> Instead lets risk checkstop which would get us rebooted with hostboot
> throwing proper error call out.

I'd like more justification for the proposed change. How is it an
improvement?

Thanks,
Nick
