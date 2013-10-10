Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 194062C012E
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Oct 2013 16:05:30 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 10 Oct 2013 10:35:23 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 842FC394005B
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Oct 2013 10:34:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9A55CQg42926276
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Oct 2013 10:35:12 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9A55EAB012100
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Oct 2013 10:35:14 +0530
Message-ID: <52563550.3070002@linux.vnet.ibm.com>
Date: Thu, 10 Oct 2013 10:34:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
 <CABPqkBREXH5VUkULAsWvmpCer-s4SCxuof6LdqRO0i-iBOG8pA@mail.gmail.com>
 <524006C4.3010006@linux.vnet.ibm.com>
 <CABPqkBR0koi7Swzqxg2nhjDsXyfLCSdR5qtB7XuBwxfCxaRO0A@mail.gmail.com>
In-Reply-To: <CABPqkBR0koi7Swzqxg2nhjDsXyfLCSdR5qtB7XuBwxfCxaRO0A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/26/2013 04:44 PM, Stephane Eranian wrote:
> So you are saying that the HW filter is exclusive. That seems odd. But
> I think it is
> because of the choices is ANY. ANY covers all the types of branches. Therefore
> it does not make a difference whether you add COND or not. And
> vice-versa, if you
> set COND, you need to disable ANY. I bet if you add other filters such
> as CALL, RETURN,
> then you could OR them and say: I want RETURN or CALLS.
> 
> But that's okay. The API operates in OR mode but if the HW does not
> support it, you
> can check the mask and reject if more than one type is set. That is
> arch-specific code.
> The alternative, if to only capture ANY and emulate the filter in SW.
> This will work, of
> course. But the downside, is that you lose the way to appreciate how
> many, for instance,
> COND branches you sampled out of the total number of COND branches
> retired. Unless
> you can count COND branches separately.

Hey Stephane,

Thanks for your reply. I am working on a solution where PMU will process
all the requested branch filters in HW only if it can filter all of them in an
OR manner else it will just leave the entire thing upto the SW to process and
do no filtering itself. This implies that branch filtering will either happen
completely in HW or completely in SW and never in a mixed manner. This way
it will conform to the OR mode defined in the API. I will post the revised
patch set soon.

Regards
Anshuman
