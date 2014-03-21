Return-Path: <ego@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 611F22C0082
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2014 01:26:09 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 10:26:05 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6411838C804A
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 10:26:02 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2LEQ2K94653342
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 14:26:02 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2LEQ1dj010349
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 10:26:02 -0400
Date: Fri, 21 Mar 2014 19:55:55 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Message-ID: <20140321142555.GF2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
 <20140321130450.GD2493@in.ibm.com>
 <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: ego@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2014 at 06:42:50PM +0530, Viresh Kumar wrote:
> On 21 March 2014 18:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > Consider the case when pmspr = 0x00feffffffffffff;
> >
> > We are interested in extracting the value 'fe'. And ensure that when
> > we store this value into an int, we get the sign extension right.
> >
> > So the following doesn't work:
> >
> >    pstate_id = (pmspr_val >> 48) & 0xFFFFFFFF;
> 
> What about pstate_id = (pmspr_val >> 48) & 0xFF; ??

Nope. 

Suppose the pmspr_val is contained in the register 
%rax, and pstate_id corresponds to the address -20(%rbp) then:

	pstate_id = (pmspr_val >> 48) & 0xFF;

would corrspond to 

        shrq    $48, %rax        // Left shift by 48 bits
        andl    $255, %eax       // Mask the lower 32 bits of %rax with 0x000000FF
        movl    %eax, -20(%rbp)  // Store the lower 32 bits of %rax
                                    into pstate_id


On the other hand, 

   pstate_id = (int)((s8)((pmspr_val >> 48) & 0xFF));

would correspond to:

        shrq    $48, %rax  // Left shift by 48 bits.
        movsbl  %al, %eax  // Move the lower 8 bits of %rax to %eax
                              with sign-extension. 
        movl    %eax, -20(%rbp) // store the result in pstate_id;

So with this, we are getting the sign extension due to the use of movsbl.

And if local_pstate_id corresponds to the address -1(%rbp) then:

       local_pstate_id = (pmspr_val >> 48) & 0xFF;
       pstate_id = local_pstate_id;

would correspond to:

        shrq    $48, %rax        // Left shift by 48 bits
        movb    %al, -1(%rbp)    //copy the lower 8 bits to local_pstate_id
        movsbl  -1(%rbp), %eax   //move the contents of
                                   local_pstate_id to %eax with sign extension.
        movl    %eax, -20(%rbp)  // Store the result in pstate_id


Hope this helps :-)

--
Thanks and Regards
gautham.
